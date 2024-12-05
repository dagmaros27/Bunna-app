import phonenumbers
from server import db

class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    firstName = db.Column(db.String(100), nullable=False)
    lastName = db.Column(db.String(100), nullable=False)
    email = db.Column(db.String(100), unique=True, nullable=False)
    password = db.Column(db.String(100), nullable=False)
    phoneNumber = db.Column(db.String(13), unique=True, nullable=False)
    zone = db.Column(db.String(100))
    region = db.Column(db.String(100))
    occupation = db.Column(db.String(100))

    def __init__(
        self,
        firstName,
        lastName,
        email,
        password,
        phoneNumber,
        zone,
        region,
        occupation,
    ):
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.password = password
        self.phoneNumber = self.validate_phone_number(phoneNumber)
        self.zone = zone
        self.region = region
        self.occupation = occupation

    @staticmethod
    def validate_phone_number(phone_number):
        try:
            parsed_number = phonenumbers.parse(phone_number, None)
            if not phonenumbers.is_valid_number(parsed_number):
                raise ValueError("Invalid phone number")
            return phonenumbers.format_number(
                parsed_number, phonenumbers.PhoneNumberFormat.E164
            )
        except phonenumbers.phonenumberutil.NumberParseException:
            raise ValueError("Invalid phone number")