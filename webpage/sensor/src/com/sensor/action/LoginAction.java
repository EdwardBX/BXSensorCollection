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
		//��֤��ʽ
			if(username.trim().length()>20)
			{
				this.addActionError("������û�������,���Ȳ��ܳ���20������!");
				return INPUT;
			}
			if(username.trim().equals(""))
			{
				this.addActionError("�˺Ų���Ϊ��!");
				return INPUT;
			}
			if(password.trim().equals(""))
			{
				this.addActionError("���벻��Ϊ��!");
				return INPUT;
			}

			if(password.trim().length()>30)
			{
				this.addActionError("������������,���Ȳ��ܳ���30��Ӣ�Ļ�����!");
				return INPUT;
			}
		
			//��֤ʧ��
			if(userid == -1)
			{
				this.addActionError("�û������������!");
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
