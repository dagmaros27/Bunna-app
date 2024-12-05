from server import db
    
class Disease(db.Model):
    id = db.Column(db.Integer, nullable=False)
    name = db.Column(db.String(100), unique=True, primary_key=True, nullable=False)
    description = db.Column(db.Text, nullable=False)
    symptoms = db.Column(db.Text, nullable=False)
    treatment = db.Column(db.Text, nullable=False)

    def __init__(self, name, description, symptoms, treatment):
        self.name = name
        self.description = description
        self.symptoms = symptoms
        self.treatment = treatment