package model;
import java.sql.*;
import org.sqlite.SQLiteConfig;
import org.sqlite.SQLiteException;



/**
 * Consists of the factory methods connection objects.
 */
public class ConnectionFactory {
	
	private static ConnectionFactory object=null;
	
	Connection connection=null;
	private final Driver driver= new org.sqlite.JDBC();
	SQLiteConfig config = new SQLiteConfig();
	private static String URL=null;
	
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
	public Connection getConnection() {
		if(connection==null) {
			try {
				DriverManager.registerDriver(driver);
				config.enforceForeignKeys(true);
				connection=DriverManager.getConnection("jdbc:sqlite:"+URL+"\\ttmsDS.db",
						config.toProperties());
			}catch (SQLiteException e) {
				e.printStackTrace();
			}catch (SQLException s) {
				s.printStackTrace();
			}
		}
		return connection;
	}
	
	public static void setDBpath(String url) {
		if(URL==null)
			URL=url;
	}
	
}
