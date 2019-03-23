package model;
import java.sql.*;
import java.util.Properties;
import org.sqlite.*;


/**
 * Consists of the factory methods connection objects.
 */
public class ConnectionFactory {
	
	private static ConnectionFactory object=null;
	
	Connection connection=null;
	private final Driver driver= new org.sqlite.JDBC();
	private Properties connectoProperties= new Properties();
	SQLiteConfig config = new SQLiteConfig();
	
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
		if(connection==null) {
			try {
				DriverManager.registerDriver(driver);
				//Database entry point.
				config.enforceForeignKeys(true);
				connectoProperties=config.toProperties();
				connection=DriverManager.getConnection("jdbc:sqlite:"+URL+"/database/ttmsDS.db",connectoProperties);
			}catch (SQLException s) {
				s.printStackTrace();
			}catch (Exception e) {
				e.printStackTrace();
			}
		}
		return connection;
	}
	
}
