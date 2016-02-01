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
		SimpleDateFormat d = new SimpleDateFormat("yyyyMMddHH");//�������ڸ�ʽ
		String t = d.format(new Date()).toString();
	    String sql="select * from temperature where time LIKE '" + t + "%'";
	   		try{
	   			Statement statement = con.createStatement();
	   			rs=(ResultSet) statement.executeQuery(sql);
	   			while (rs.next()) 
				{
					TemperatureBean temperatureBean = new TemperatureBean();
					//ʱ��ȡ��֮��������ĳ�UTCʱ��
					Date date = null;
					SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
					//�˴������쳣
					date = df.parse(rs.getString("time"));
					//��ȡ������
					/*long longDate = date.getTime();*/
					Calendar cal = Calendar.getInstance(TimeZone.getDefault());//TimeZone.getDefault()��ȡ������Ĭ�� TimeZone����ʱ��ƫ������
					cal.setTime(date);
					long longDate = date.getTime()+cal.getTimeZone().getRawOffset();//����2012-11-26��Ӧ��utc�µĺ���ֵ
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
					//ʱ��ȡ��֮��������ĳ�UTCʱ��
					Date date = null;
					SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHH");
					//�˴������쳣
					date = df.parse(rs.getString("time"));
					//��ȡ������
					/*long longDate = date.getTime();*/
					Calendar cal = Calendar.getInstance(TimeZone.getDefault());//TimeZone.getDefault()��ȡ������Ĭ�� TimeZone����ʱ��ƫ������
					cal.setTime(date);
					long longDate = date.getTime()+cal.getTimeZone().getRawOffset();//����2012-11-26��Ӧ��utc�µĺ���ֵ
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
