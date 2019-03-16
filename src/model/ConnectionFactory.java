package model;
import java.sql.*;


/**
 * Consists of the factory methods connection objects.
 */
public class ConnectionFactory {
	
	private static ConnectionFactory object=null;
	
	Connection cn=null;
	Driver driver= null;
	
	//private String URL="jdbc:mysql://sql7.freesqldatabase.com:3306/sql7281796";
	//private String USERNAME="sql7281796";
	//private String PASSWORD="j76igHvYd3";
	private ConnectionFactory() {}
	
	/**
	 * Used to get the singleton instance of this class and avoid memory leaks.
	 * @return {@link ConnectionFactory}
	 */
	public static ConnectionFactory getInstance() {
		if(object==null)
			object=new ConnectionFactory();
		
		return object;
	}
	
	/**
	 * Used to fetch the single time connection instance of the database.
	 * @return {@link Connection}
	 */
	public Connection getConnection(String URL) {
		if(cn==null && driver==null) {
			try {
				driver= new org.sqlite.JDBC();
				DriverManager.registerDriver(driver);
				//Database entry point.
				cn=DriverManager.getConnection("jdbc:sqlite:"+URL+"/database/ttmsDS.db");
			}catch (SQLException e) {
				e.printStackTrace();
			}finally {
				try {
					DriverManager.deregisterDriver(driver);
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return cn;
	}
	
}
