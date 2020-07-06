from os import path

import joblib
import numpy as np
from news_classifier.models import text_examples

LE_PATH = path.join("models", "le.gz")
TFID_PATH = path.join("models", "tfid.gz")
MODEL_PATH = path.join("models", "model.gz")

LE = joblib.load(LE_PATH)
TFID = joblib.load(TFID_PATH)
MODEL = joblib.load(MODEL_PATH)


def predict(X: np.array):
    """
    It classifies the category of the given texts
    :param X: A numpy array with the texts to classify
    :return:  A list with the predicted categories
    """
    X = TFID.transform(X)
    cls = MODEL.predict(X)
    category = LE.inverse_transform(cls)
    return category


if __name__ == "__main__":
    texts = np.array([
        text_examples.business
    ])
    prediction = predict(texts)
    print(prediction)
