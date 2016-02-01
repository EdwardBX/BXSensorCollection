package com.sensor.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class UserDao {
	private Connection con;
	ProcedureDBManager pdbm;
	ResultSet rs;
	public UserDao()
	{
		pdbm = new ProcedureDBManager();
		con = pdbm.getCon();
	}
	
	public int LoginCheck(String username, String password) {
		int mg_id = -1;	
	    String sql="select * from users where username = '"+ username + "' and password = '" + password + "';";
	   		try{
	   			Statement statement = con.createStatement();
	   			rs=(ResultSet) statement.executeQuery(sql);
		
			System.out.println(username+" "+ password);
            
			while (rs.next()) 
			{
				System.out.println("¥Ê‘⁄”√ªß");
				mg_id = 1;
			}	
			con.close();
		} catch (SQLException e) {
			System.out.println("logincheck error!");	
			return -1;
		}
		return mg_id ;
	}

}
