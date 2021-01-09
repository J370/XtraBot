

#from flask_wtf.csrf import CSRFProtect
from flask import Flask
from datetime import datetime
#from flask_sqlalchemy import SQLAlchemy
#from flask_bcrypt import Bcrypt
from flask_login import LoginManager
import os


app = Flask(__name__)
#csrf = CSRFProtect(app)

SECRET_KEY = os.urandom(32)
app.config['SECRET_KEY'] = SECRET_KEY
#app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///site.db'
#app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
#db = SQLAlchemy(app)
#bcrypt = Bcrypt(app)

login_manager = LoginManager(app) 
login_manager.login_view = 'home'
login_manager.login_message_category = 'info'


from routesfile import routes
