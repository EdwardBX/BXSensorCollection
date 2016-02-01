int ledPin = 13;
String val = "";
int ms = 0;

void setup() {
    pinMode(ledPin, OUTPUT);
    Serial.begin(9600);
}

void loop() {
    digitalWrite(ledPin,LOW);
    // 从另一个 XBee 模块读取数据
    while(Serial.available()){
        val += char(Serial.read());
        delay(2);
    }
  
    if(val.length() > 3){
        Serial.print(val);
        digitalWrite(ledPin, HIGH);
        delay(500);
        digitalWrite(ledPin,LOW);
        ms = 500 + 2 * val.length();
        delay(ms);
        val = "";
    } 
}   


