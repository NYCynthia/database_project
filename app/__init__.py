from flask import Flask
from config import Config
import psycopg2
from flask_login import LoginManager

app = Flask(__name__)
app.config.from_object(Config)
db_conn = psycopg2.connect(dbname=app.config['DB_NAME'], user=app.config['DB_USER'], password=app.config['DB_PASSWORD'])
login_manager = LoginManager()
login_manager.init_app(app)

from app import routes
