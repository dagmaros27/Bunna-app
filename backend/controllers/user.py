from flask_mail import Message
from server import mail
import re
from flask import jsonify, request
from models.user import User
from server import db, bcrypt
from flask_jwt_extended import create_access_token, get_jwt_identity
from datetime import datetime, timedelta
import random
from models.password_reset_code import PasswordResetCode
from models.report import Report


def send_reset_email(user_email, code):
    msg = Message("Password Reset Request", recipients=[user_email])
    msg.body = f"Please use the following 6 digit code  to reset your password: {code}"
    mail.send(msg)
    

def is_valid_email(email):
    # RegEx pattern for email validation
    pattern = r"^[\w\.-]+@[\w\.-]+\.\w+$"
    return re.match(pattern, email) is not None


def is_strong_password(password):
    # RegEx pattern for strong password validation
    pattern = r"^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$"
    return re.match(pattern, password) is not None


class UserController:
    def __init__(self, database_handler):
        self.database_handler = database_handler
        

    def create_user(self):
        firstName = request.json["firstName"]
        lastName = request.json["lastName"]
        email = request.json["email"]
        password = request.json["password"]
        phoneNumber = request.json["phoneNumber"]
        zone = request.json["zone"]
        region = request.json["region"]
        occupation = request.json["occupation"]

        existing_user = User.query.filter_by(email=email).first()
        existing_phone = User.query.filter_by(phoneNumber=phoneNumber).first()
        if existing_user:
            return jsonify({"message": "Username already exists"}), 400
        if existing_phone:
            return jsonify({"message": "Phone number already exists"}), 400
        if is_valid_email(email):
            hashed_password = bcrypt.generate_password_hash(password)
            if is_strong_password(password):
                new_user = User(
                    firstName,
                    lastName,
                    email,
                    hashed_password,
                    phoneNumber,
                    zone,
                    region,
                    occupation,
                )
                db.session.add(new_user)
                db.session.commit()
                return jsonify({"message": "User created successfully"}), 201
            else:
                return jsonify({"message": "Invalid Password"}), 400
        else:
            return jsonify({"message": "Invalid Email"}), 400
        
    def login(self):
        email = request.json["email"]
        password = request.json["password"]
        user = User.query.filter_by(email=email).first()
        if user and bcrypt.check_password_hash(user.password, password):
            access_token = create_access_token(
                identity=user.id, additional_claims={"email": email}
            )

            return (
                jsonify(
                    {
                        "access_token": access_token,
                        "user_id": user.id,
                        "email": user.email,
                        "firstName": user.firstName,
                        "lastName": user.lastName,
                        "phoneNumber": str(user.phoneNumber),
                        "zone": user.zone,
                        "region": user.region,
                        "occupation": user.occupation
                    }
                ),
                200,
            )
        return jsonify({"message": "Invalid username or password"}), 401
    
    def forgot_password(self):
        email = request.json["email"]

        if is_valid_email(email):
            existing_user = User.query.filter_by(email=email).first()
            if existing_user:
                reset_code = random.randint(100000, 999999)
                expiration_time = datetime.now() + timedelta(hours=1)
                passwordResetData = PasswordResetCode.query.filter_by(
                    user_id=existing_user.id
                ).first()
                if passwordResetData:
                    passwordResetData.code = str(reset_code)
                    passwordResetData.expiration = expiration_time
                    db.session.commit()
                else:
                    password_reset_Code = PasswordResetCode(
                        code=str(reset_code),
                        expiration=expiration_time,
                        user_id=existing_user.id,
                    )
                    db.session.add(password_reset_Code)
                    db.session.commit()
                print(f"password Reset {reset_code}")
                send_reset_email(email, reset_code)
                return (
                    jsonify({"message": "Reset code has been sent to your email"}),
                    201,
                )
            return jsonify({"message": "Invalid email address"}), 404
        return jsonify({"message": "Invalid form data"}), 400
    
    def reset_password(self):
        reset_code = request.json["code"]
        if not reset_code.isdigit() or len(reset_code) != 6:
            return jsonify({"error": "Reset code must be exactly 6 digits"}), 400

        else:
            resetCode = PasswordResetCode.query.filter_by(code=reset_code).first()
            password = request.json["password"]
            if resetCode:
                print(f"expiration {resetCode.expiration }")
                print(f"now {datetime.now()}")
                if resetCode.expiration > datetime.now():
                    user_id = resetCode.user_id
                    print(f"user code {resetCode.user_id}")
                    user = User.query.get(user_id)
                    if user:
                        if is_strong_password(password):
                            user.password = bcrypt.generate_password_hash(password)
                            db.session.commit()
                            return jsonify({"message": "Password reset successful"}), 201
                        else:
                            return jsonify({"message": "Invalid Password"}), 400
                    else:
                        return jsonify({"message": "User not found"}), 401
                else:
                    return jsonify({"message": "The code has expired"}), 401
            else:
                return jsonify({"message": "Invalid code"}), 400
            
    def change_password(self):
        user_id = get_jwt_identity()
        user = User.query.get(user_id)
        oldPassowrd = request.json["oldPassword"]
        if bcrypt.check_password_hash(user.password, oldPassowrd):
            newPassword = request.json["newPassword"]
            if is_strong_password(newPassword):
                user.password = bcrypt.generate_password_hash(newPassword)
                db.session.commit()
                return jsonify({"message": "Password changed successful"}), 201
            else:
                return jsonify({"message": "Invalid Password"}), 400
        else:
            return jsonify({"message": "Old password is incorrect"}), 400

    def get_users(self):
        users = User.query.all()
        user_list = []

        for user in users:
            user_data = {}
            reports = Report.query.filter_by(user_id=user.id).all()
            print(f"all reports{reports}")
            user_data["user_id"] = user.id
            user_data["firstName"] = user.firstName
            user_data["lastName"] = user.lastName
            user_data["email"] = user.email
            user_data["phoneNumber"] = str(user.phoneNumber)
            user_data["zone"] = user.zone
            user_data["region"] = user.region
            user_data["occupation"] = user.occupation
            user_data["report"] = [report.to_dict() for report in reports]
            user_list.append(user_data)
        return jsonify(user_list), 200
    
    def get_user(self, user_id):
        current_user_id = get_jwt_identity()
        if current_user_id != user_id:
            return jsonify({"message": "Access denied"}), 403
        user = User.query.get(user_id)
        reports = Report.query.filter_by(user_id=user_id).all()
        print(reports)
        if user:
            user_data = {}
            user_data["user_id"] = user.id
            user_data["firstName"] = user.firstName
            user_data["lastName"] = user.lastName
            user_data["email"] = user.email
            user_data["phoneNumber"] = str(user.phoneNumber)
            user_data["zone"] = user.zone
            user_data["region"] = user.region
            user_data["occupation"] = user.occupation
            user_data["report"] = [report.to_dict() for report in reports]
            return jsonify(user_data), 200
        return jsonify({"message": "User not found"}), 404
    
    def update_user(self, user_id):
        current_user_id = get_jwt_identity()

        if current_user_id == user_id:
            user = User.query.get(current_user_id)
            if user:
                user.firstName = request.json["firstName"]
                user.lastName = request.json["lastName"]
                user.phoneNumber = request.json["phoneNumber"]
                user.zone = request.json["zone"]
                user.region = request.json["region"]
                user.occupation = request.json["occupation"]
                db.session.commit()
                return jsonify({"message": "User updated successfully"}), 201
            return jsonify({"message": "User Not found"}), 404
        return jsonify({"message": "Access denied"}), 403
    
    
    def delete_user(self, user_id):
        current_user_id = get_jwt_identity()
        if current_user_id != user_id:
            return jsonify({"message": "Access denied"}), 403
        user = User.query.get(user_id)
        if user:
            db.session.delete(user)
            db.session.commit()
            return jsonify({"message": "User deleted successfully"}), 201
        return jsonify({"message": "User not found"}), 404