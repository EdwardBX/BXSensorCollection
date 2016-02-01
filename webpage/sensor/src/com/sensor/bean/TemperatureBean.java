package com.sensor.bean;

import java.util.Date;

public class TemperatureBean {
	private String time;
	private String temp;
	private String humi;
	private String dust;
	private String gas;
	private String beam;
	
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public String getTemp() {
		return temp;
	}
	public void setTemp(String temp) {
		this.temp = temp;
	}
	public String getHumi() {
		return humi;
	}
	public void setHumi(String humi) {
		this.humi = humi;
	}
	public String getDust() {
		return dust;
	}
	public void setDust(String dust) {
		this.dust = dust;
	}
	public String getGas() {
		return gas;
	}
	public void setGas(String gas) {
		this.gas = gas;
	}
	public String getBeam() {
		return beam;
	}
	public void setBeam(String beam) {
		this.beam = beam;
	}
}
