from server import db
from models.disease import Disease

class Report(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey("user.id"), nullable=False)
    image_id = db.Column(db.String(100), nullable=False)
    timestamp = db.Column(db.DateTime, nullable=False)
    region = db.Column(db.String(100))
    confidence = db.Column(db.String(100), nullable=False)
    disease_name = db.Column(
        db.String(100), db.ForeignKey("disease.name"), nullable=False
    )

    def to_dict(self):
        disease = Disease.query.filter_by(name=self.disease_name).first()
        return {
            "user_id": self.user_id,
            "image_id": self.image_id,
            "disease_name": self.disease_name,
            "timestamp": self.timestamp,
            "region": self.region,
            "confidence": self.confidence,
            "description": disease.description if disease else None,
            "symptoms": disease.symptoms if disease else None,
            "treatment": disease.treatment if disease else None,
        }
