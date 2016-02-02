# -*- coding: cp936 -*-
import time
import random
import serial
import MySQLdb
import string

conn = MySQLdb.connect(host='localhost',
                       port = 3306,
                       user='root',
                       passwd='',
                       db ='sensor',)
cur = conn.cursor()
#cur.execute("create table pm25(id varchar(20) ,time varchar(20),data varchar(10))")
ser = serial.Serial('/dev/tty.usbmodem1421')  
line = ser.readline()

dustArr = []
tempArr = []
humiArr = []
lightArr = []
gasArr = []

count = 0

while line:
    currenttime = time.strftime("%Y-%m-%d-%H-%M-%S")
    newline = line.strip()
    first = newline[0]
    
    if(first == 'd'):
        dust = newline[2:]
        print currenttime + ' ' + dust
    
    if(first == 't'):
        temp = newline[2:]
        print currenttime + ' ' + temp

    if(first == 'h'):
        humi = newline[2:]
        print currenttime + ' ' + humi

    if(first == 'l'):
        light = newline[2:]
        print currenttime + ' ' + light

    if(first == 'g'):
        gas = newline[2:]
        print currenttime + ' ' + gas

    if ((len(dust) != 0) and (len(temp) != 0) and (len(humi) != 0) and (len(light) != 0) and (len(gas) != 0)):
        value = [dust,temp,humi,light,gas,currenttime]
        print value
        
        dustArr[count] = string.atoi(value[0].doubleValue)
        
        count += 1
        cur.execute("insert into temperature(dust,temp,hum,light,gas,time)values(%s, %s, %s, %s, %s, %s)",value)
        cur.close()
        conn.commit()
        dust = ''
        temp = ''
        humi = ''
    line = ser.readline()
    cur = conn.cursor()
cur.close()
conn.commit()
conn.close()
ser.close()
