package model;
import java.sql.*;


/**
 * Consists of the factory methods connection objects.
 */
public class ConnectionFactory {
	
	private static ConnectionFactory object=null;
	
	Connection cn=null;
	Driver driver=null;
	
	private String URL=null;
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
	public Connection getConnection(String uri) {
		URL="jdbc:sqlite:"+uri;
		if(cn==null && driver==null) {
			try {
				driver= new org.sqlite.JDBC();
				DriverManager.registerDriver(driver);
				cn=DriverManager.getConnection(URL);
			}catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return cn;
	}
	
}
