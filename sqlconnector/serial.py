# -*- coding: cp936 -*-
import time
import random
import serial
import MySQLdb
import string

def averageValue(array):
    sumscore = sum(array)
    length = len(array)
    averageV = sumscore / length
    return averageV

conn = MySQLdb.connect(host='localhost',
                       port = 3306,
                       user='root',
                       passwd='',
                       db ='sensor',)
cur = conn.cursor()
#cur.execute("create table pm25(id varchar(20) ,time varchar(20),data varchar(10))")

ser = serial.Serial('COM3')  
line = ser.readline()
dust = ''
temp = ''
humi = ''
light = ''
gas = ''
dustArray = []
tempArray = []
humiArray = []
lightArray = []
gasArray = []
count = 0

while line:
    currenttime = time.strftime("%Y%m%d%H%M%S")
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
        cur.execute("insert into temperature(dust,temp,hum,beam,gas,time)values(%s, %s, %s, %s, %s, %s)",value)
        
        dustArray.append(string.atof(value[0]))
        tempArray.append(string.atof(value[1]))
        humiArray.append(string.atof(value[2]))
        lightArray.append(string.atof(value[3]))
        gasArray.append(string.atof(value[4]))
        
        count += 1

        if (count % 180 == 0):
            dusthour = averageValue(dustArray)
            temphour = averageValue(tempArray)
            humihour = averageValue(humiArray)
            gashour = averageValue(gasArray)
            lighthour = averageValue(lightArray)
            currentday = time.strftime("%Y%m%d%H")
            hourValue = [dusthour,temphour,currentday,humihour,gashour,lighthour]
            cur.execute("insert into day(dust,temp,time,hum,gas,beam)values(%s, %s, %s, %s, %s, %s)",hourValue)
            dustArray = []
            tempArray = []
            humiArray = []
            lightArray = []
            gasArray = []
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


