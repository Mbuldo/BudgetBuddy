from flask import Flask
from .models import db
from .routes import bp
from flask_migrate import Migrate  # <-- add this

def create_app():
    app = Flask(__name__)
    app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://postgres:12345678@localhost/budgetbuddy'
    app.config['SECRET_KEY'] = 'your-secret-key'

    db.init_app(app)
    Migrate(app, db)  # <-- add this
    app.register_blueprint(bp)

    return app
