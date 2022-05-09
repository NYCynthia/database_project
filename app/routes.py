from datetime import datetime as dt
from flask import render_template, redirect, url_for, flash, session, request
from flask_login import current_user, login_user, logout_user, login_required
from werkzeug.security import generate_password_hash
from app import app, db_conn
from app.forms import *
from app.models import User

@app.route("/", methods=["GET", "POST"])
@app.route("/index", methods=["GET", "POST"])
def index():
    form = LoginForm()
    if form.validate_on_submit():
        user = User(username=form.username.data)
        if user is None or user.check_password(form.password.data) == False: 
            flash("invalid username or password")
            return redirect(url_for("index"))
        login_user(user, remember=form.remember_me.data)
        return redirect(url_for("dashboard"))
    return render_template("index.html", form=form)

@app.route("/create_user", methods=["GET", "POST"])
def create_user():
    form = CreateUserForm()
    if form.validate_on_submit():
        with db_conn.cursor() as cur:
            cur.execute("INSERT INTO Users (username, password, first_name, last_name, email, phone, is_private, is_active) VALUES (%s, %s, %s, %s, %s, %s, %s, %s);", (form.username.data, generate_password_hash(form.password.data), form.first_name.data, form.last_name.data, form.email.data, form.phone.data, form.is_private.data, True))
            db_conn.commit()
        flash("User created successfully")
        return redirect(url_for("index"))
    return render_template("create_user.html", form=form)

@login_required 
@app.route("/dashboard")
def dashboard():
    with db_conn.cursor() as cur:
        cur.execute("SELECT club_id, club_name FROM ClubAndMemberView WHERE user_id=%s;", (session["_user_id"],))
        clubs = cur.fetchall()
        results = None
        if "q" in request.args:
            cur.execute("SELECT Clubs.id, name FROM Clubs WHERE LOWER(name) LIKE %s;", ('%' + request.args["q"].lower() + "%",))
            results = cur.fetchall()
    return render_template("dashboard.html", clubs=clubs, results=results)


@app.route("/404")
def error_404():
    return render_template("404.html")

@login_required
@app.route("/view_user/<other_user_id>", methods=["GET", "POST"])
def view_user(other_user_id):
    user = User(id=session["_user_id"])
    other_user = User(id=other_user_id)
    form = None
    messages = None
    if other_user is None or other_user.is_private:
        return redirect(url_for("error_404"))
    if user.id != other_user_id:
        form = SendMessage()
        if form.validate_on_submit():
            with db_conn.cursor() as cur:
                cur.execute("INSERT INTO Messages (sender_user_id, receiver_user_id, msg, timestamp) VALUES (%s, %s, %s, %s);", (user.id, other_user_id, form.msg.data, dt.utcnow()))
                db_conn.commit()
            return redirect(url_for("view_user", other_user_id=other_user_id))
        with db_conn.cursor() as cur:
            cur.execute("SELECT username as sender_name, msg FROM Messages JOIN Users ON sender_user_id = Users.id WHERE (sender_user_id=%s AND receiver_user_id=%s) OR (sender_user_id=%s AND receiver_user_id=%s) ORDER BY timestamp;", (session["_user_id"], other_user.id, other_user.id, session["_user_id"]))
            messages = cur.fetchall()
    return render_template("view_user.html", user=user, other_user=other_user, messages=messages, form=form)


@login_required
@app.route("/logout")
def logout():
    logout_user()
    return redirect(url_for("index"))

@login_required
@app.route("/create_club", methods=["GET", "POST"])
def create_club():
    form = CreateClubForm()
    if form.validate_on_submit():
        with db_conn.cursor() as cur:
            cur.execute("CALL CreateClub(%s, %s, %s, %s);", (session["_user_id"], form.name.data, form.location.data, form.description.data))
            db_conn.commit()
        flash("Club was created successfully")
        return redirect(url_for("dashboard"))
    return render_template("create_club.html", form=form)

@login_required
@app.route("/view_club/<club_id>", methods=["GET", "POST"])
def view_club(club_id):
    with db_conn.cursor() as cur:
        cur.execute("SELECT id, name, location, description FROM Clubs WHERE id=%s;", (club_id,))
        club = cur.fetchone()
        cur.execute("SELECT user_id, username, first_name, last_name, is_private, is_active, is_admin FROM ClubAndMemberView WHERE club_id=%s;", (club_id,))
        members = cur.fetchall()
        user_id = int(session["_user_id"])
        is_member = user_id in [m[0] for m in members]
        is_admin = False
        if is_member:
            cur.execute("SELECT is_admin FROM ClubMembers WHERE club_id=%s AND user_id=%s;", (club_id, user_id))
            is_admin = cur.fetchone()[0]
        cur.execute("SELECT club_id, club_name, event_id, event_name, event_location, event_description, start_datetime, end_datetime FROM ClubAndEventView WHERE club_id=%s;", (club_id,))
        events = cur.fetchall()
        cur.execute("SELECT enrollment(%s);", (club_id,))
        num_of_members = cur.fetchone()[0]
        if "action" in request.args:
            if request.args["action"] == "join" and not is_member:
                if num_of_members < 5:
                    cur.execute("INSERT INTO ClubMembers (club_id, user_id, is_admin) VALUES (%s, %s, %s);", (club_id, user_id, False))
                    flash("You are now a member")
                    db_conn.commit()
                else:
                    flash("Sorry but the club is at its max capacity for now. Try again later!")
                return redirect(url_for("view_club", club_id=club_id))
            elif request.args["action"] == "leave":
                cur.execute("DELETE FROM ClubMembers WHERE club_id = %s AND user_id = %s;", (club_id, user_id))
                flash("You have left the club")
                db_conn.commit()
                return redirect(url_for("view_club", club_id=club_id))
    form = None
    messages = None
    if is_member:
        form = SendMessage()
        if form.validate_on_submit():
            with db_conn.cursor() as cur:
                cur.execute("INSERT INTO Messages (sender_user_id, receiver_club_id, msg, timestamp) VALUES (%s, %s, %s, %s);", (user_id, club_id, form.msg.data, dt.utcnow()))
                db_conn.commit()
            return redirect(url_for("view_club", club_id=club_id))
        with db_conn.cursor() as cur:
            cur.execute("SELECT username as sender_name, msg FROM Messages JOIN Users ON sender_user_id = Users.id WHERE receiver_club_id=%s ORDER BY timestamp;", (club_id,))
            messages = cur.fetchall()
    return render_template(
        "view_club.html", 
        club=club, 
        members=members, 
        is_member=is_member,
        is_admin=is_admin,
        events=events,
        form=form,
        messages=messages,
        joinable = num_of_members < 5,
    )

@login_required
@app.route("/create_event/<club_id>", methods=["GET", "POST"])
def create_event(club_id):
    with db_conn.cursor() as cur:
        cur.execute("SELECT is_admin FROM ClubMembers WHERE club_id=%s AND user_id=%s;", (club_id, session["_user_id"]))
        row = cur.fetchone()
        if row and row[0] == True:
            form = CreateEventForm()
        else:
            flash("You need to be an admin of this club to create an event!")
            return redirect(url_for("view_club", club_id=club_id))
        if form.validate_on_submit():
            cur.execute("SELECT id FROM Events ORDER BY id DESC;", ())
            row = cur.fetchone()
            event_id = 1 if not row else row[0] + 1
            cur.execute("INSERT INTO Events (id, name, location, description, start_datetime, end_datetime) VALUES (%s, %s, %s, %s, %s, %s);", (event_id, form.name.data, form.location.data, form.description.data, form.start_datetime.data, form.end_datetime.data))
            cur.execute("INSERT INTO InvitedClubs (event_id, club_id) VALUES (%s, %s);", (event_id, club_id))
            db_conn.commit()
            flash("Event created successfully!")
            return redirect(url_for("view_club", club_id=club_id))
        cur.execute("SELECT name FROM Clubs WHERE id=%s;", (club_id,))
        club_name = cur.fetchone()[0]
    return render_template("create_event.html", form=form, club_name=club_name)

@login_required
@app.route("/view_event/<event_id>", methods=["GET", "POST"])
def view_event(event_id):
    with db_conn.cursor() as cur:
        # This might be a good place for a database function that returns True if the user is invited to this event, since this requires querying over TWO different many-to-many relationships!
        if "attendance" in request.args:
            if request.args["attendance"] == "2":
                status = 2
            elif request.args["attendance"] == "1":
                status = 1
            else:
                status = 0
            cur.execute("SELECT * FROM Attendance WHERE event_id=%s AND user_id=%s;", (event_id, session["_user_id"]))
            att_id = cur.fetchone()
            if att_id is not None:
                cur.execute("DELETE FROM Attendance WHERE event_id=%s and user_id=%s;", (event_id, session["_user_id"]))
            cur.execute("INSERT INTO Attendance (user_id, event_id, status) VALUES (%s, %s, %s);", (session["_user_id"], event_id, status))
            db_conn.commit()
        cur.execute("SELECT * FROM Events WHERE id=%s;", (event_id,))
        event = cur.fetchone()
        cur.execute(f"SELECT user_id, is_admin FROM ClubMembers WHERE club_id in (SELECT club_id FROM InvitedClubs WHERE event_id=%s);", event_id)
        invited_users = set()
        is_invited = False
        is_admin = False
        user_id = int(session['_user_id'])
        for uid, isAdmin in cur.fetchall():
            if uid == user_id:
                is_invited = True
                if isAdmin:
                    is_admin = True
                    break
        cur.execute("SELECT * FROM Attendance WHERE event_id=%s AND user_id=%s;", (event_id, session["_user_id"]))
        row = cur.fetchone()
        attendance = None if not row else row[3]
        if not is_invited and attendance is not None: # if club's invitation was removed
            cur.execute("DELETE FROM Attendance WHERE event_id=%s AND user_id=%s;", (event_id, session["_user_id"]))
            db_conn.commit()
        attendees = None
        if is_admin:
            # cur.execute("SELECT user_id, username, first_name, last_name, is_private FROM Users JOIN ClubMembers ON Users.id=user_id JOIN InvitedClubs ON ClubMembers.club_id = InvitedClubs.club_id JOIN Events ON event_id = Events.id WHERE event_id = %s;", (event_id,))
            cur.execute("SELECT user_id, username, first_name, last_name, is_private, status FROM Users JOIN Attendance ON Users.id=user_id JOIN Events ON event_id = Events.id WHERE event_id = %s;", (event_id,))
            attendees = cur.fetchall()
    form = None
    messages = None
    if is_invited:
        form = SendMessage()
        if form.validate_on_submit():
            with db_conn.cursor() as cur:
                cur.execute("INSERT INTO Messages (sender_user_id, receiver_event_id, msg, timestamp) VALUES (%s, %s, %s, %s);", (user_id, event_id, form.msg.data, dt.utcnow()))
                db_conn.commit()
            return redirect(url_for("view_event", event_id=event_id))
        with db_conn.cursor() as cur:
            cur.execute("SELECT username as sender_name, msg FROM Messages JOIN Users ON sender_user_id = Users.id WHERE receiver_event_id=%s ORDER BY timestamp;", (event_id,))
            messages = cur.fetchall()
    return render_template("view_event.html", event=event, is_invited=is_invited, is_admin=is_admin, attendance=attendance, attendees=attendees, form=form, messages=messages)

