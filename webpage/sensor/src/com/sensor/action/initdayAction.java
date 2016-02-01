package com.sensor.action;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.SessionAware;

import com.opensymphony.xwork2.ActionSupport;
import com.sensor.bean.TemperatureBean;
import com.sensor.dao.TemperatureDao;

public class initdayAction  extends ActionSupport implements SessionAware{
	private static final long serialVersionUID = 1L;
	private Map<String, Object> session;
	private List<TemperatureBean> temperatureList;
	private Map jsonMap;
	private String date1;
	
	public String getDate1() {
		return date1;
	}

	public void setDate1(String date1) {
		this.date1 = date1;
	}

	public initdayAction()
	{
		setTemperatureList(new ArrayList<TemperatureBean>());
	}
	
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}
	
	public String execute() throws Exception {
		return SUCCESS;
	}
	
	public void obtainData() throws Exception {
		// È¡µÃÎÂ¶ÈList
		TemperatureDao temperatureDao = new TemperatureDao();
		temperatureList = temperatureDao.getDayList();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("application/json;charset=utf-8");
		response.setCharacterEncoding("utf-8");
		PrintWriter pw = response.getWriter();
		pw.write(JSONArray.fromObject(temperatureList).toString());
		System.out.println(JSONArray.fromObject(temperatureList).toString());
		pw.flush();
		pw.close();
	}
	
	public List<TemperatureBean> getTemperatureList() {
		return temperatureList;
	}
	
	public void setTemperatureList(List<TemperatureBean> temperatureList) {
		this.temperatureList = temperatureList;
	}

	public Map<String, Object> getSession() {
		return session;
	}



	public void setSession(Map<String, Object> arg0) {
		// TODO Auto-generated method stub
		
	}
	public Map getJsonMap() {
		return jsonMap;
	}
	public void setJsonMap(Map jsonMap) {
		this.jsonMap = jsonMap;
	}


}
