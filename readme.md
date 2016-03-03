###无线传感器网络开发实践----室内环境远程监控系统

实现该系统主要用到了 Arduino / Zigbee / MySQL / Java Servlet 等技术。

####Collector 
驱动带有 XBee 模块的协调器节点的 Arduino Sketch 文件，负责收集各个传感器终端采集到的数据。

####Sqlconnector
使用 Python 编写的脚本，读取串口数据并存入 MySQL 数据库。

####Webpage
使用 Java Servlet 构建的实时数据显示网站。

####Gas & Tem & Light
驱动各个终端节点传感器的 Arduino Sketch 文件。
包括：  

* 温湿度传感器 DHT22
* 光照传感器 BH1750
* 颗粒物传感器 
* To be Continue...