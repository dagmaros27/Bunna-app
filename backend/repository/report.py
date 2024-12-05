from server import db
from models.report import Report
from sqlalchemy import func

class DatabaseHandler:
    def __init__(self, session):
        self.session = session

    def fetch_report_disease_counts(self):
        return (
            self.session.query(
                Report.region, Report.disease_name, func.count(Report.id)
            )
            .group_by(Report.region, Report.disease_name)
            .all()
        )

    def fetch_report_region_counts(self):
        return (
            self.session.query(Report.region, func.count(Report.region))
            .group_by(Report.region)
            .all()
        )

    def fetch_report_count(self):
        return self.session.query(Report).count()

    def fetch_report_regional_disease_counts(self):
        return (
            self.session.query(
                Report.disease_name, Report.region, func.count(Report.id)
            )
            .group_by(Report.disease_name, Report.region)
            .all()
        )

    def add_report(self, report):
        self.session.add(report)
        self.session.commit()
