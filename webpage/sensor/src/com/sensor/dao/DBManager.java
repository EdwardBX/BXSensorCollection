package com.sensor.dao;
import java.sql.*;

public class DBManager {
	protected Connection con;
	protected ResultSet rs;
	private Statement stmt;

	// ���ݿ����ӹ��캯��
	public DBManager() {
		System.out.println("connectting database...");
		String driverName = "com.mysql.jdbc.Driver";
			try {
				Class.forName(driverName);
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			}			
			try {
				con = DriverManager.getConnection(
						"jdbc:mysql://localhost/sensor","root", "");
				System.out.println("���ݿ����ӳɹ�!");
				
			} catch (SQLException e) {
				System.out.println("���ݿ�����ʧ��!");
				
				e.printStackTrace();
			}
			// DriverManager.getConnection("jdbc:sqlserver://pc2011:1433;DatabaseName=LSystem","sa",
			// "123");
			// "jdbc:odbc:Driver={MicroSoft Access Driver (*.mdb)};DBQ=D:\\123.mdb";
			// con=DriverManager.getConnection(url, "", "");
		

	}
	//��������
	public Connection getCon()
	{
		return this.con;
	}
	public Statement getStatement()
	{
		try {
			stmt = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,
					ResultSet.CONCUR_UPDATABLE);
		} catch (SQLException e) 
		{
			System.out.println("return stmt faild!");
			e.printStackTrace();
		}
		return stmt;
	}
	// ���ز�ѯ�ṹ
	public ResultSet getResult(String strSQL) {
		try {
			rs = stmt.executeQuery(strSQL);
			return rs;
		} catch (SQLException sqle) {
			
			System.out.println(sqle.toString());		
			return null;
		}		
	}

	// �������ݿ�
	public boolean updateSql(String strSQL) {
		try {
			stmt.executeUpdate(strSQL);
			con.commit();
			return true;

		} catch (SQLException sqle) {
			System.out.println(sqle.toString());
			return false;
		}
	}
	// �ر�����Դ
	public void closeConnection() {
		try {
			con.close();
		} catch (SQLException sqle) {
			System.out.println(sqle.toString());
		}
	}

}



