package model.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import model.ConnectionFactory;

public class UserAuthDAO {
	PreparedStatement statement=null;
	Connection connection=null;
	ResultSet resultSet=null;
	int flag=-1;
	String uriString=null;
	
	private String querString = "SELECT ADMIN FROM userReg WHERE EXISTS("
			+ "SELECT * FROM userReg WHERE MOBILE=? AND PASSWORD=?)"
			+ " AND ?=(SELECT PASSWORD FROM userReg WHERE MOBILE=?)"
			+ " AND MOBILE=?";
	
	public UserAuthDAO(String uriString) {
		this.uriString=uriString;
	}
	
	public int login(long mobile, String pass)  {
		
		try {
				connection = ConnectionFactory.getInstance().getConnection();
				statement= connection.prepareStatement(querString);
				statement.setLong(1, mobile);
				statement.setString(2, pass);
				statement.setString(3, pass);
				statement.setLong(4, mobile);
				statement.setLong(5, mobile);
				
				resultSet=statement.executeQuery();
				
				System.out.println(resultSet.getInt("ADMIN"));
				if(resultSet.next()) {
					flag = resultSet.getInt("ADMIN");
				}
			}catch (SQLException e) {
				e.printStackTrace();
			}finally {
				try {
					if(resultSet!=null)
						resultSet.close();
					//statement.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		
		return flag;
		
	}
}
