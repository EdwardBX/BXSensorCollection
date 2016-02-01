package com.sensor.dao;
import java.sql.*;

public class DBManager {
	protected Connection con;
	protected ResultSet rs;
	private Statement stmt;

	// 数据库连接构造函数
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
				System.out.println("数据库连接成功!");
				
			} catch (SQLException e) {
				System.out.println("数据库连接失败!");
				
				e.printStackTrace();
			}
			// DriverManager.getConnection("jdbc:sqlserver://pc2011:1433;DatabaseName=LSystem","sa",
			// "123");
			// "jdbc:odbc:Driver={MicroSoft Access Driver (*.mdb)};DBQ=D:\\123.mdb";
			// con=DriverManager.getConnection(url, "", "");
		

	}
	//返回连接
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
	// 返回查询结构
	public ResultSet getResult(String strSQL) {
		try {
			rs = stmt.executeQuery(strSQL);
			return rs;
		} catch (SQLException sqle) {
			
			System.out.println(sqle.toString());		
			return null;
		}		
	}

	// 更新数据库
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
	// 关闭数据源
	public void closeConnection() {
		try {
			con.close();
		} catch (SQLException sqle) {
			System.out.println(sqle.toString());
		}
	}

}



