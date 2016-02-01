package com.sensor.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.TimeZone;

import com.sensor.bean.TemperatureBean;
import com.sensor.dao.ProcedureDBManager;
import com.sun.org.apache.regexp.internal.recompile;

public class TemperatureDao{
	private Connection con;
	private CallableStatement cstmt;
	ProcedureDBManager pdbm;
	ResultSet rs;
	public TemperatureDao()
	{
		pdbm = new ProcedureDBManager();
		con = pdbm.getCon();
	}
	
	public List<TemperatureBean> getTemperatureList() {
		List<TemperatureBean> temperatureList = new ArrayList<TemperatureBean>();
		SimpleDateFormat d = new SimpleDateFormat("yyyyMMddHH");//设置日期格式
		String t = d.format(new Date()).toString();
	    String sql="select * from temperature where time LIKE '" + t + "%'";
	   		try{
	   			Statement statement = con.createStatement();
	   			rs=(ResultSet) statement.executeQuery(sql);
	   			while (rs.next()) 
				{
					TemperatureBean temperatureBean = new TemperatureBean();
					//时间取得之后在这里改成UTC时间
					Date date = null;
					SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
					//此处会抛异常
					date = df.parse(rs.getString("time"));
					//获取毫秒数
					/*long longDate = date.getTime();*/
					Calendar cal = Calendar.getInstance(TimeZone.getDefault());//TimeZone.getDefault()获取主机的默认 TimeZone，即时区偏移量。
					cal.setTime(date);
					long longDate = date.getTime()+cal.getTimeZone().getRawOffset();//就是2012-11-26对应的utc下的毫秒值
					temperatureBean.setTime(Long.toString(longDate));
					DecimalFormat fnum = new DecimalFormat("##0.00"); 
					float  tt = rs.getFloat("temp");
					String temp=fnum.format(tt); 
					float  hh = rs.getFloat("hum");
					String hum=fnum.format(hh); 
					float  dd = rs.getFloat("dust");
					String dust=fnum.format(dd); 
					float  gg = rs.getFloat("gas");
					String gas=fnum.format(gg); 
					float  bb = rs.getFloat("beam");
					String beam=fnum.format(bb); 
					
					temperatureBean.setTemp(temp);
					temperatureBean.setHumi(hum);
					temperatureBean.setDust(dust);
					temperatureBean.setGas(gas);
					temperatureBean.setBeam(beam);
					temperatureList.add(temperatureBean);		
				}	
	   		}catch(Exception e){
	   			e.printStackTrace();
	   		}
		return temperatureList;
	}
	
	public List<TemperatureBean> getDayList() {
		List<TemperatureBean> temperatureList = new ArrayList<TemperatureBean>();
	    String sql="select * from day";
	   		try{
	   			Statement statement = con.createStatement();
	   			rs=(ResultSet) statement.executeQuery(sql);
	   			while (rs.next()) 
				{
					TemperatureBean temperatureBean = new TemperatureBean();
					//时间取得之后在这里改成UTC时间
					Date date = null;
					SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHH");
					//此处会抛异常
					date = df.parse(rs.getString("time"));
					//获取毫秒数
					/*long longDate = date.getTime();*/
					Calendar cal = Calendar.getInstance(TimeZone.getDefault());//TimeZone.getDefault()获取主机的默认 TimeZone，即时区偏移量。
					cal.setTime(date);
					long longDate = date.getTime()+cal.getTimeZone().getRawOffset();//就是2012-11-26对应的utc下的毫秒值
					temperatureBean.setTime(Long.toString(longDate));
					DecimalFormat fnum = new DecimalFormat("##0.00"); 
					float  tt = rs.getFloat("temp");
					String temp=fnum.format(tt); 
					float  hh = rs.getFloat("hum");
					String hum=fnum.format(hh); 
					float  dd = rs.getFloat("dust");
					String dust=fnum.format(dd); 
					float  gg = rs.getFloat("gas");
					String gas=fnum.format(gg); 
					float  bb = rs.getFloat("beam");
					String beam=fnum.format(bb); 
					
					temperatureBean.setTemp(temp);
					temperatureBean.setHumi(hum);
					temperatureBean.setDust(dust);
					temperatureBean.setGas(gas);
					temperatureBean.setBeam(beam);
					temperatureList.add(temperatureBean);		
				}	
	   		}catch(Exception e){
	   			e.printStackTrace();
	   		}
		return temperatureList;
	}
	
	public boolean closeConnect()
	{
		try {
			cstmt.close();
		} catch (SQLException e) {
	
			e.printStackTrace();
		}
		return true;
	}
	
}
