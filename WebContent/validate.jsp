<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"
    import="java.lang.*,java.sql.*,model.ConnectionFactory,java.io.File" session="true"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/theme.css">
<title>Validating Login Request</title>
</head>
<body>
<%!boolean validResult=false;
	Connection connection=null;%>

	<%
	String QUERY= "SELECT U_ADMIN, U_NAME,U_EMAIL  FROM userAccount WHERE U_EMAIL=? AND U_PASS=?";
		PreparedStatement statement=null;
		ResultSet resultSet=null;
		
		String[] part= this.getServletContext().getRealPath(File.separator).replace("\\", "/").split("/.metadata");
		try{
			connection=ConnectionFactory.getInstance().getConnection(
					part[0]+this.getServletContext().getContextPath());
			
			statement= connection.prepareStatement(QUERY);
			statement.setString(1, (String)request.getParameter("adminEmail"));
			statement.setString(2, (String)request.getParameter("adminPass"));
			resultSet=statement.executeQuery();
			
			if(resultSet.next()){
				if(resultSet.getString(3).equals(request.getParameter("adminEmail"))){
					session.setAttribute("auth", resultSet.getInt(1));
					session.setAttribute("name", resultSet.getString(2));
					session.setAttribute("email", resultSet.getString(3));
					validResult=true;
				}
			}
		}catch(SQLException e){
			e.printStackTrace();
		}%>
		
		<%
			if(validResult){
				validResult=false;
				
					if(resultSet.getInt(1)==1){
						System.out.println("\nAdmin Logged in : "+resultSet.getString(2)+"\n");
						response.sendRedirect("adminHome.jsp");
							
					}else if(resultSet.getInt(1)==0){ 
							System.out.println("\nUser Logged in : "+resultSet.getString(2)+"\n");
							response.sendRedirect("userHome.jsp");
					}
				}else{
				
				%>
				<P align=center><IMG SRC="Images/error48.png" WIDTH="48" HEIGHT="48" BORDER="0" ALT=""><br>
				<FONT COLOR="Red" size=5 Face="verdana">SORRY! Invalid Email/password please try again</FONT>
				<BR>
				<font Face="Comic Sans MS" size=3><A HREF="home.html">&lt;&lt; Home</A></font>
				</P>
				<%
			}
		%>
</body>
</html>