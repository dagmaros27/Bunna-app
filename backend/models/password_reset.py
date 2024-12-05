from server import db

class PasswordResetCode(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    code = db.Column(db.String(6), unique=True, nullable=False)
    expiration = db.Column(db.DateTime, nullable=False)
    user_id = db.Column(db.Integer, db.ForeignKey("user.id"), nullable=False)

    def __init__(self, code, expiration, user_id):
        self.code = code
        self.expiration = expiration
        self.user_id = user_id