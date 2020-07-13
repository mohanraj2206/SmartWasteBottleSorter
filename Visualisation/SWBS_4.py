# This code is used to create the visualisation
# which is subscribed to the topic visualise 

from flask import Flask, render_template 
from flask_mqtt import Mqtt

WhiteBin = 0
GreenBin = 0
BrownBin = 0
WhiteBinCount = 0
GreenBinCount = 0
BrownBinCount = 0

app = Flask(__name__)
app.config["TEMPLATES_AUTO_RELOAD"] = True
app.config['MQTT_BROKER_URL'] = '100.64.88.130'
app.config['MQTT_BROKER_PORT'] = 1883
app.config['MQTT_USERNAME'] = ''
app.config['MQTT_PASSWORD'] = ''
app.config['MQTT_REFRESH_TIME'] = 0.5  # refresh time in seconds
mqtt = Mqtt(app)

@app.route("/home")
@app.route("/")

def home():
    global WhiteBin, GreenBin, BrownBin, WhiteBinCount, GreenBinCount, BrownBinCount
    templateData = {
      'val1' : WhiteBin,
      'val2' : GreenBin,
      'val3' : BrownBin,
      'val4' : WhiteBinCount,
      'val5' : GreenBinCount,
      'val6' : BrownBinCount
      }
    print(templateData)
    return render_template('SWBS.html', **templateData)

@mqtt.on_connect()
def handle_connect(client, userdata, flags, rc):
    mqtt.subscribe('Visualise')

@mqtt.on_message()
def handle_mqtt_message(client, userdata, message):
    global WhiteBin, GreenBin, BrownBin, WhiteBinCount, GreenBinCount, BrownBinCount
    data = dict(
        topic=message.topic,
        payload=message.payload.decode()
    )
    print(data)
    payloadData = message.payload.decode('utf-8')
    payloadDataValues = payloadData[1:len(payloadData)-1].split(',')
    
    WhiteBin = int(payloadDataValues[0])
    GreenBin = int(payloadDataValues[1])
    BrownBin = int(payloadDataValues[2])
    WhiteBinCount = int(payloadDataValues[3])
    GreenBinCount = int(payloadDataValues[4])
    BrownBinCount = int(payloadDataValues[5])

if __name__ == "__main__":
    app.run(debug=False)
    app.run()
