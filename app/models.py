from app import db_conn
from app import login_manager
from werkzeug.security import generate_password_hash, check_password_hash

class User(object):
    def __new__(cls, **kwargs):
        row = None
        if "id" in kwargs:
            with db_conn.cursor() as cur:
                cur.execute("SELECT id FROM Users WHERE id=%s;", (kwargs["id"],))
                row = cur.fetchone()
        elif "username" in kwargs: 
            with db_conn.cursor() as cur:
                cur.execute("SELECT id FROM Users WHERE username=%s;", (kwargs["username"],))
                row = cur.fetchone()
        if row is not None:
            return super().__new__(cls)
        else:
            return None
    def __init__(self, **kwargs):
        with db_conn.cursor() as cur:
            cur.execute(f"SELECT id, username, email, first_name, last_name, phone, is_private, is_active FROM Users WHERE {'id' if 'id' in kwargs else 'username'}=%s;", (kwargs['id'] if 'id' in kwargs else kwargs['username'],))
            row = cur.fetchone()
            self.id = row[0]
            self.username = row[1]
            self.email = row[2]
            self.first_name = row[3]
            self.last_name = row[4]
            self.phone = row[5]
            self.is_private = row[6]
            self.is_active = row[7]
        self.is_authenticated = False
        self.is_anonymous = False
    def get_id(self):
        return str(self.id)
    def check_password(self, password):
        with db_conn.cursor() as cur:
            cur.execute("SELECT password FROM Users WHERE username=%s;", (self.username,))
            db_pw_hash = cur.fetchone()[0]
        return check_password_hash(db_pw_hash, password)
    def __str__(self):
        if self.is_private:
            return self.username
        else:
            return f'{self.username} ({self.first_name} {self.last_name})'


@login_manager.user_loader
def load_user(user_id):
    return User(id=int(user_id))
