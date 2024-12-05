from flask import jsonify
from flask_jwt_extended import get_jwt_identity
from backend.models.user import User
from backend.models.report import Report
from sqlalchemy import func
from backend.repository.database_handler import DatabaseHandler
from backend.usecases.data_analysis import DataAnalysis

class DataAnalysisController:
    def __init__(self, db):
        self.db = db
    def researcher_page(self):
        user_id = get_jwt_identity()

        # user existence checking
        user = User.query.get(user_id)
        if not user:
            return jsonify({"error": "User not found"}), 404
        if user.occupation != "Researcher":
            return jsonify({"unauthorized user"}), 403
        else:
            database_handler = DatabaseHandler(self.db.session)
            data_analysis = DataAnalysis(database_handler)
            analysis_result = data_analysis.analyze_data()
            print(analysis_result)
            #  Calculate the average confidence
            average_confidence = self.db.session.query(func.avg(Report.confidence)).scalar()

            # Convert the average confidence to a float
            average_confidence = (
                float(average_confidence) if average_confidence is not None else 0.0
            )

            print(f"Average Confidence: {average_confidence}")
            return (
                jsonify(
                    {
                        "Total disease Report": analysis_result,
                        "Average Confidence": average_confidence,
                    }
                ),
                200,
            )

