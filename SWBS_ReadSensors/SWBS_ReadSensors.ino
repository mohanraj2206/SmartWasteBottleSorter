#include <Wire.h>  //For i2c SDA-A4, SCl-A5
#include <Adafruit_TCS34725.h> //color sensor library
#include <Ultrasonic.h> // ultrasonic Sensor library

//Pin Definitions

// AnalogPins 
int lightSensor = A0;
int piezoVibrationSensor = A1;
// DigitalPins
Ultrasonic usWhite(4);
Ultrasonic usGreen(5);
Ultrasonic usBrown(6);

//Sensor Configurations

Adafruit_TCS34725 tcs = Adafruit_TCS34725(TCS34725_INTEGRATIONTIME_50MS, TCS34725_GAIN_4X);

struct BinStatus
{
  byte white;
  byte green;
  byte brown;
}binstatus;

boolean colorSensorCheck;

void setup() {
  Serial.begin(9600);
  if (tcs.begin()) {
//        Serial.println("Color Sensor Detected");
        colorSensorCheck = true;
    } else {
//        Serial.println("No Color Sensor found ... check your connections...");
        colorSensorCheck = false;
//        while (1); // halt!
    }
}

void loop() {
    
    //To detect the material
    short vibrationSensor = analogRead(piezoVibrationSensor);
    
    while(vibrationSensor < 500)
    {
      vibrationSensor = 0;
      vibrationSensor = analogRead(piezoVibrationSensor);
    }
    vibrationSensor = 1; // bottle detected
    
    //To find Bottle cleaniness
    short lightSensor = analogRead(lightSensor);
    
    //TO find the color
    int clearValue, red, green, blue;
    tcs.setInterrupt(false);      // turn on LED
    delay(60);  // takes 50ms to read
    tcs.getRawData(&red, &green, &blue, &clearValue);
    tcs.setInterrupt(true);  // turn off LED

    // error in color sensor 
    if(colorSensorCheck == false)
    {
      red = 10;
      green = 20;
      blue = 30;
    }
    
    //checking the Bin status
    binstatus.white = usWhite.MeasureInCentimeters();
    binstatus.green = usGreen.MeasureInCentimeters();
    binstatus.brown = usBrown.MeasureInCentimeters();

    //send data to raspberry pi
    // formating the packet by padding it with '$' at the beginning and end
    
     short dataPacket[6];

     dataPacket[0] = lightSensor;
     dataPacket[1] = vibrationSensor;
     dataPacket[2] = clearValue+red+green+blue;
     dataPacket[3] = binstatus.white;
     dataPacket[4] = binstatus.green;
     dataPacket[5] = binstatus.brown;

     Serial.println('$'); 
     for(int i=0;i<6;i++)
     {
      Serial.println(dataPacket[i]);     
     }
     Serial.println('$'); 
}
