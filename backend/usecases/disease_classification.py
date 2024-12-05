import numpy as np
import tensorflow as tf
CLASS_NAMES = ["Cerscospora", "Healthy", "Leaf rust", "Miner", "Phoma"]

class DiseaseClassification:
    def __init__(self, imageProcessingController, MODEL, AUTOENCODER):
        self.imageProcessingController = imageProcessingController
        self.classificationResults = None
        self.disease = None
        self.MODEL = MODEL
        self.AUTOENCODER = AUTOENCODER

    def is_anomaly(self, img):
        reconstructed_img = self.AUTOENCODER.predict(img)
        reconstruction_error = tf.reduce_mean(tf.square(img - reconstructed_img))
        anomaly_threshold = 0.0009
        return reconstruction_error > anomaly_threshold

    def classify_disease(self, image_bytes):
        preprocessed_image = self.imageProcessingController.preprocess_image(
            image_bytes
        )
        if self.is_anomaly(preprocessed_image):
            classified_disease = "Anomaly"
            confidence = "0.0"
            return classified_disease, confidence
        else:
            predictions = self.MODEL.predict(preprocessed_image)
            max_prob = np.max(predictions[0])
            if max_prob >= 0.5:
                classified_disease = CLASS_NAMES[np.argmax(predictions[0])]
                confidence = round(100 * max_prob, 2)
                return classified_disease, confidence
            else:
                classified_disease = "Anomaly"
                confidence = round(100 * max_prob, 2)
                return classified_disease, confidence

    # def generate_report(self, classification_results, disease):
    #     self.classificationResults = classification_results
    #     self.disease = disease
    #     if classification_results == disease.name:
    #         report = {
    #             "disease": disease.name,
    #             "description": disease.description,
    #             "symptoms": disease.symptoms,
    #             "treatment": disease.treatment,
    #         }
    #     return report

    # def log_classification_event(self, log):
    #     print("Classification Event Log:", log)
    #     return log

