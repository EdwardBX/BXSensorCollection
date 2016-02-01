#include <dht.h>
#include <Wire.h> //BH1750 IIC Mode 
#include <math.h>

#define DHT22_PIN 7

int BH1750address = 0x23; //setting i2c address
byte buff[2];
int ledPower = 2;
dht DHT;

void setup() {
    Wire.begin();
    Serial.begin(9600);
    pinMode(ledPower,OUTPUT);
}

void loop() {
    int chk = DHT.read22(DHT22_PIN);  // 读取 DHT 传感器数据数据

    uint16_t valLight=0;
    BH1750_Init(BH1750address);
    delay(100);

    // 读取光照传感器数据
    if(2==BH1750_Read(BH1750address)) {
        valLight=((buff[0]<<8)|buff[1])/1.2;
        Serial.print("l:");
        Serial.println(valLight,DEC);
    }
  
    switch (chk) {
        case DHTLIB_OK:
                Serial.print("h:"); 
                break;
        case DHTLIB_ERROR_CHECKSUM:
                Serial.print("Checksum error,\t"); 
                break;
        case DHTLIB_ERROR_TIMEOUT:
                Serial.print("Time out error,\t"); 
                break;
        default:
                Serial.print("Unknown error,\t"); 
                break;
    }
    Serial.println(DHT.humidity, 1);

    Serial.print("t:");
    Serial.println(DHT.temperature, 1);
    delay(1024*5);
}

int BH1750_Read(int address) {
    int i=0;
    Wire.beginTransmission(address);
    Wire.requestFrom(address, 2);
    while(Wire.available()) {
        buff[i] = Wire.read();
        i++;
    }
    Wire.endTransmission();
    return i;
}

void BH1750_Init(int address) {
    Wire.beginTransmission(address);
    Wire.write(0x10);
    Wire.endTransmission();
}
