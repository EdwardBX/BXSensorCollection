package com.sensor.action;
import java.util.Map;
import org.apache.struts2.interceptor.SessionAware;
import com.sensor.dao.UserDao;
import com.opensymphony.xwork2.*;

public class LoginAction extends ActionSupport implements SessionAware{

	private static final long serialVersionUID = 1L;
	private Map<String, Object> session;
	private String username;
	private String password;
	
	public String execute() throws Exception {
		
		UserDao sDao = new UserDao();
		int userid = sDao.LoginCheck(username, password);
		//验证格式
			if(username.trim().length()>20)
			{
				this.addActionError("输入的用户名过长,长度不能超多20的数字!");
				return INPUT;
			}
			if(username.trim().equals(""))
			{
				this.addActionError("账号不能为空!");
				return INPUT;
			}
			if(password.trim().equals(""))
			{
				this.addActionError("密码不能为空!");
				return INPUT;
			}

			if(password.trim().length()>30)
			{
				this.addActionError("输入的密码过长,长度不能超过30的英文或数字!");
				return INPUT;
			}
		
			//验证失败
			if(userid == -1)
			{
				this.addActionError("用户名或密码错误!");
				return INPUT;
			}
			else
			{
				session.put("username",username);
			}
			return "success";
		}

	public String getUsername() {
		return username;
	}
    
	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public void setSession(Map<String, Object> session) {
		this.session = session;
		
	}
}
