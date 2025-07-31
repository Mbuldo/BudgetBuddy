from flask import Flask
from .models import db
from .models import User, Transaction
from .routes import bp
from flask_migrate import Migrate

import os

def create_app():
    app = Flask(__name__)
    DATABASE_URL = os.getenv("DATABASE_URL")
    
    app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///budgetbuddy.db'
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

    app.config['SECRET_KEY'] = 'your-secret-key'

    db.init_app(app)
    Migrate(app, db)  
    app.register_blueprint(bp)

    return app
