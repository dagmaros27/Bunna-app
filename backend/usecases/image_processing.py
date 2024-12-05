import numpy as np
import tensorflow as tf
from PIL import Image
from io import BytesIO

class ImageProcessing:
    @staticmethod
    def preprocess_image(image_bytes) -> np.ndarray:
        image = Image.open(BytesIO(image_bytes)).convert("RGB")
        image = image.resize((128, 128))
        image_array = np.array(image) / 255.0
        return tf.expand_dims(image_array, 0)