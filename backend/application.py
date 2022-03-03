import io
import numpy as np
import tensorflow as tf
from PIL import Image
from flask import Flask, jsonify, request
from keras.preprocessing import image


model = tf.keras.models.load_model('WesternAIModel.h5')

application = Flask(__name__)
app = application

def prepare_image(img):
    BOX = Image.open(io.BytesIO(img))
    BOX = BOX.resize((256, 192))
    test_img = image.img_to_array(BOX)
    img = np.expand_dims(test_img, axis=0)
    return img

def predict_results(file):
    img = prepare_image(file)
    predictions = model.predict(img)
    score = tf.nn.softmax(predictions[0])
    return int(np.argmax(score))


@app.route('/predict', methods=['POST'])
def infer_image():

    print(request.get_data())
    # Catch the image file from a POST request
    if 'file' not in request.files:
        return "Please try again. The Image doesn't exist"

    file = request.files.get('file')

    if not file:
        return

    # Read the image
    img_bytes = file.read()

    # Return on a JSON format
    return jsonify(prediction=predict_results(img_bytes))

@app.route('/', methods=['GET'])
def index():
    return 'Test'

if __name__ == '__main__':
    # uncomment when running localy 
    app.run(debug=True, host='0.0.0.0')
    #app.run()