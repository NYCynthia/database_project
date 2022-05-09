import os 

class Config(object):
    SECRET_KEY = os.environ.get("SECRET_KEY") or "hfnskkbfnzal.ur77639qnHyeea&98&^2bjdsks0ij"
    DB_NAME = "meetapp"
    DB_USER = "meetapp_user"
    DB_PASSWORD = os.getenv("DB_PASSWORD")
    DB_HOST = "localhost"
    DB_PORT = "5432"
