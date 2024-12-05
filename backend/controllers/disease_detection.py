from flask import jsonify, request
from werkzeug.utils import secure_filename
import os
import uuid
from datetime import datetime
from backend.models.user import User
from backend.models.disease import Disease
from backend.models.report import Report
from backend.usecases.image_processing import ImageProcessing
from backend.usecases.disease_classification import DiseaseClassification
from flask_jwt_extended import get_jwt_identity


class DiseaseDetectionController:
    def __init__(self, database_handler, MODEL, AUTOENCODER, app):
        self.db = database_handler
        self.MODEL = MODEL
        self.AUTOENCODER = AUTOENCODER
        self.app = app
        
    def coffee_detection(self):
        user_id = get_jwt_identity()

        # user existence checking
        user = User.query.get(user_id)
        if not user:
            return jsonify({"error": "User not found"}), 404

        # image file inclusion checking
        if "image" not in request.files:
            return jsonify({"error": "No image file provided"}), 400

        image_file = request.files["image"]
        if image_file.filename == "":
            return jsonify({"error": "No selected Image"}), 400
        image_bytes = image_file.read()
        image_processing_controller = ImageProcessing()

        image_id, filename = self.save_image(image_file)
        disease_classifier = DiseaseClassification(image_processing_controller, self.MODEL, self.AUTOENCODER)
        classified_disease, confidence = disease_classifier.classify_disease(image_bytes)
        if classified_disease == "Anomaly":
            return jsonify(
                {"class": str(classified_disease), "confidence": str(confidence)}
            )

        # Create a new report instance
        else:
            print(f"found disease {classified_disease}")
            # Fetch disease data from the database
            disease = Disease.query.filter_by(name=classified_disease).first()
            current_time = datetime.utcnow()
            report = Report(
                user_id=user_id,
                image_id=os.path.join(image_id + "_" + filename),
                timestamp=current_time,
                region=user.region,
                confidence=float(confidence),
                disease_name=disease.name,
            )

            # Add the report to the database
            self.db.session.add(report)
            self.db.session.commit()

            response_data = {
                "disease_name": disease.name,
                "timestamp": current_time,
                "confidence": str(confidence),
                "region": user.region,
                "description": disease.description,
                "symptoms": disease.symptoms,
                "treatment": disease.treatment,
            }
            return jsonify(response_data), 200


    def save_image(self, image_file):
        image_id = str(uuid.uuid4())
        # saving image file
        filename = secure_filename(image_file.filename)
        image_path = os.path.join(self.app.config["UPLOAD_FOLDER"], image_id + "_" + filename)
        image_file.save(image_path)
        return image_id, filename
