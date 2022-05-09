from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField, BooleanField, SubmitField, TextAreaField, DateTimeField
from wtforms.validators import DataRequired, EqualTo

class LoginForm(FlaskForm):
    username = StringField("Please enter your username", validators=[DataRequired()])
    password = PasswordField("Password", validators=[DataRequired()])
    remember_me = BooleanField("remember me")
    submit = SubmitField("Log in")

class CreateUserForm(FlaskForm):
    username = StringField("Please enter your username", validators=[DataRequired()])
    password = PasswordField("Password", validators=[DataRequired()])
    confirm_pw = PasswordField("Confirm Password", validators=[DataRequired(), EqualTo('password', message='both password fields must be equal')])
    first_name = StringField("Please enter your first name", validators=[DataRequired()])
    last_name = StringField("Please enter your last name", validators=[DataRequired()])
    email = StringField("Please enter your email address", validators=[DataRequired()])
    phone = StringField("Please enter your phone number", validators=[DataRequired()])
    is_private = BooleanField("Make account private?")
    submit = SubmitField("Create User")

class CreateClubForm(FlaskForm):
    name = StringField("Please enter your club name", validators=[DataRequired()])
    location = StringField("Please enter your club's location", validators=[DataRequired()])
    description = TextAreaField("Please enter your club's description", validators=[DataRequired()])
    submit = SubmitField("Create Club")

class CreateEventForm(FlaskForm):
    name = StringField("Please enter the name of your event", validators=[DataRequired()])
    location = StringField("Please enter your event's location", validators=[DataRequired()])
    description = TextAreaField("Please enter your event's description", validators=[DataRequired()])
    start_datetime = StringField(validators=[DataRequired()])
    end_datetime = StringField(validators=[DataRequired()])
    submit = SubmitField("Create Event")

class SendMessage(FlaskForm):
    msg = TextAreaField("Please enter your message", validators=[DataRequired()])
    submit = SubmitField("Send Message")

