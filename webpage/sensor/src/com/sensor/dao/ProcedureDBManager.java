package com.sensor.dao;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ProcedureDBManager extends DBManager{
	public CallableStatement cstmt;
	
	public void setCstmt(CallableStatement cstmt) {
		this.cstmt = cstmt;
	}
	public CallableStatement getCstmt() {
		return cstmt;
	}

	public ResultSet getResult() {
		try {
			rs = cstmt.executeQuery();
			return rs;
		} catch (SQLException sqle) {			
			System.out.println(sqle.toString());		
			return null;
		}		
	}	
	public boolean updateSql() {
		try {
			cstmt.executeUpdate();
			return true;
			
		} catch (SQLException sqle) {
			System.out.println(sqle.toString());
			return false;
		}
	}
}
