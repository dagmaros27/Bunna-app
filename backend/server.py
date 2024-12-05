from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy
from flask_cors import CORS
from flask_jwt_extended import (
    JWTManager,
    create_access_token,
    jwt_required,
    get_jwt_identity,
)
from werkzeug.utils import secure_filename
from flask_mail import Mail, Message

# from datetime import timedelta
from io import BytesIO
from PIL import Image
from flask_cors import CORS
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from sqlalchemy import func
from flask_bcrypt import Bcrypt
import numpy as np
import tensorflow as tf
import os
from dotenv import load_dotenv
import uuid
import re
import random
import phonenumbers
from datetime import datetime, timedelta
from controllers.user import UserController
from controllers.disease_detection import DiseaseDetectionController
from controllers.data_analysis import DataAnalysisController
from repository.database_handler import DatabaseHandler


# configuration for coffee disease detection model
UPLOAD_FOLDER = "uploads"
load_dotenv()

app = Flask(__name__)
CORS(app)
app.config["SQLALCHEMY_DATABASE_URI"] = os.getenv("SQLALCHEMY_DATABASE_URI")
app.config["JWT_SECRET_KEY"] = os.getenv("JWT_SECRET_KEY")
app.config["JWT_ACCESS_TOKEN_EXPIRES"] = timedelta(hours=2)
app.config["PORT"] = os.getenv("PORT")
app.config["UPLOAD_FOLDER"] = UPLOAD_FOLDER
app.config["MAIL_SERVER"] = os.getenv("MAIL_SERVER")
app.config["MAIL_PORT"] = os.getenv("MAIL_PORT")
app.config["MAIL_USE_TLS"] = os.getenv("MAIL_USE_TLS")
app.config["MAIL_USERNAME"] = os.getenv("MAIL_USERNAME")
app.config["MAIL_PASSWORD"] = os.getenv("MAIL_PASSWORD")
app.config["MAIL_DEFAULT_SENDER"] = os.getenv("MAIL_DEFAULT_SENDER")
# write a program

db = SQLAlchemy(app)
engine = create_engine("sqlite:///users.db")
Session = sessionmaker(bind=engine)
session = Session()
jwt = JWTManager(app)
mail = Mail(app)
CORS(app)
bcrypt = Bcrypt(app)
MODEL_PATH = "saved_models/coffee3.keras"
MODEL = tf.keras.models.load_model(MODEL_PATH)
AUTOENCODER_PATH = "autoencoder/autoencoder2.keras"
AUTOENCODER = tf.keras.models.load_model(AUTOENCODER_PATH)


user_controller = UserController(db)
disease_detection_controller = DiseaseDetectionController(db, MODEL, AUTOENCODER, app)
data_analysis_controller = DataAnalysisController(db)

@app.route("/register", methods=["POST"], endpoint="create_user")
def create_user():
    return user_controller.create_user()

@app.route("/login", methods=["POST"], endpoint="login")
def login():
    return user_controller.login()

@app.route("/forgot-password", methods=["POST"], endpoint="forgot_password")
def forgot_password():
    return user_controller.forgot_password()

@app.route("/reset-password", methods=["POST"], endpoint="reset_password")
def reset_password():
    return user_controller.reset_password()

@app.route("/change-password", methods=["POST"], endpoint="change_password")
@jwt_required()
def change_password():
    return user_controller.change_password()

@app.route("/users", methods=["GET"], endpoint="get_users")
def get_users():
    return user_controller.get_users()

@app.route("/users/<int:user_id>", methods=["GET"], endpoint="get_user")
@jwt_required()
def get_user(user_id):
    return user_controller.get_user(user_id)

@app.route("/users/<int:user_id>", methods=["PUT"], endpoint="update_user")
@jwt_required()
def update_user(user_id):
    return user_controller.update_user(user_id)

@app.route("/users/<int:user_id>", methods=["DELETE"], endpoint="delete_user")
@jwt_required()
def delete_user(user_id):
    return user_controller.delete_user(user_id)


@app.route(
    "/coffee-disease-detection",
    methods=["POST"],
    endpoint="coffee_disease_detection",
)
@jwt_required()
def coffee_disease_detection():
    return disease_detection_controller.coffee_detection()




@app.route(
    "/researcher-page",
    methods=["GET"],
    endpoint="researcher-page",
)
@jwt_required()
def researcher_page():
    return data_analysis_controller.researcher_page()



if __name__ == "__main__":
    with app.app_context():
        db.create_all()

    app.run(debug=True)
