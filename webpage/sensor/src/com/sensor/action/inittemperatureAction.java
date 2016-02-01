package com.sensor.action;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.ListIterator;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.SessionAware;


import com.opensymphony.xwork2.ActionSupport;
import com.sensor.bean.TemperatureBean;
import com.sensor.dao.TemperatureDao;

public class inittemperatureAction extends ActionSupport implements SessionAware {
	private static final long serialVersionUID = 1L;
	private Map<String, Object> session;
	private List<TemperatureBean> temperatureList;
	private Map jsonMap;

	public inittemperatureAction()
	{
		setTemperatureList(new ArrayList<TemperatureBean>());
	}
	public String execute() throws Exception {
		//取得温度List
//		TemperatureDao temperatureDao = new TemperatureDao();
//		temperatureList = temperatureDao.getTemperatureList();
//		/*JSONArray json = new JSONArray();
//		json.addAll(temperatureList);
//		json.listIterator();
//		if(json.isEmpty()){
//			System.out.println("JSON为空");
//		}
//		ListIterator  li = json.listIterator();
//		while(li.hasNext()){
//			System.out.println(li.next().toString());
//		}*/
//		jsonMap = new HashMap();
//		jsonMap.put("temperatureList",temperatureList);
		return SUCCESS;
	}
	
	public void obtainData() throws Exception {
		// 取得温度List
		TemperatureDao temperatureDao = new TemperatureDao();
		temperatureList = temperatureDao.getTemperatureList();
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
