int measurePin = 0; // 连接模拟口 0
int ledPower = 2; // 连接数字口 2

int samplingTime = 280; 
int deltaTime = 40;
int sleepTime = 9680;

float voMeasured = 0; 
float voMeasuredLast = 2.0;
float calcVoltage = 0; 
float dustDensity = 0;
float dust = 0;
String dustlength = "";
int ms = 2000;
float a[10];
float average = 0;
float lastAverage = 0;
float sum = 0;
int i = 0;

void setup(){
    Serial.begin(9600);
    pinMode(ledPower,OUTPUT);
}

void loop(){
    digitalWrite(ledPower,LOW); // 开启内部 LED
    delayMicroseconds(samplingTime); // 开启 LED 后的 280us 的等待时间
    voMeasured = analogRead(measurePin); // 读取模拟值
    delayMicroseconds(deltaTime); // 40us 等待时间
    digitalWrite(ledPower,HIGH); // 关闭 LED
    voMeasured = voMeasuredLast + (voMeasured - voMeasuredLast) / 10.0;
    delayMicroseconds(sleepTime);
    // ADC 得到测量精确值
    calcVoltage = voMeasured * (5.0 / 1024.0); // 0 - 5V 映射到 0 - 1023 整数区间
    // linear eqaution taken from
    // Chris Nafis (c) 2012
    dustDensity = 0.17 * calcVoltage - 0.1;
    dust = dustDensity * 1000; // 将电压值转换为粉尘密度输出单位
    a[i++] = dust;
    if(i == 10){
        for (int j = 0; j < 10; j++){
            sum += a[j];
        }
        average = sum/10;
        average = lastAverage * 0.125 + average * 0.875;
        memset(a, 0, sizeof(int) * 10);
        i = 0;
        sum = 0;
        Serial.print("d:");
        Serial.println(average); // 输出单位: 毫克/立方米
        lastAverage = average;
    }
  
    voMeasuredLast = voMeasured;
    dustlength = String(average);
    ms += dustlength.length();
    delay(ms);
    ms = 2000;
    average = 0;
}
