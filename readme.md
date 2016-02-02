实现该系统主要用到了 Arduino / Zigbee / MySQL / JS 等技术。

####collector 
使用 Arduino 驱动 Xbee 模块收集各个传感器终端采集的数据。

####sqlconnector
使用 Python 脚本读取串口数据并存入 MySQL 数据库。

####webpage
使用 JSP 技术构建的数据显示网站。

####gas & tem & light
驱动各个传感器的终端节点。