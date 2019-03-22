<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.lang.*,java.sql.*,model.ConnectionFactory,java.io.File" session="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Validating User</title>
<link rel="stylesheet" type="text/css" href="css/theme.css">
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
			statement.setString(1, (String)request.getParameter("userEmail"));
			statement.setString(2, (String)request.getParameter("userPass"));
			resultSet=statement.executeQuery();
			
			if(resultSet.next()){
				if(resultSet.getString(3).equals(request.getParameter("userEmail"))){
					session.setAttribute("auth", resultSet.getInt(1));
					session.setAttribute("name", resultSet.getString(2));
					validResult=true;
				}
			}
		}catch(SQLException e){
			e.printStackTrace();
		}%>
		
		<%
			if(validResult){
				validResult=false;
				if(resultSet.getInt(1)==0){
					System.out.println("\nUser Logged in : "+resultSet.getString(2)+"\n");
					%>
					<P align=center><FONT COLOR="Green" Face="Georgia"><I><B>Welcome <%=resultSet.getString(2)%></B></I></FONT>
						<BR><BR>
						<jsp:forward page="userHome.jsp"/>
					</P>
					
				<%}else{ %>
					<P align=center><IMG SRC="Images/error48.png" WIDTH="48" HEIGHT="48" BORDER="0" ALT=""><br>
						<FONT COLOR="Red" size=5 Face="verdana">Administrators are prohibited from accessing the User Portal !</FONT>
						<BR>
						<font Face="Comic Sans MS" size=3><A HREF="userLogin.jsp">&lt;&lt; Back</A></font>
					</P>
				<%
				}
			}else{
				
				%>
				<P align=center>
				<IMG SRC="Images/error48.png" WIDTH="48" HEIGHT="48" BORDER="0" ALT=""><br>
				<FONT COLOR="Red" size=5 Face="verdana">SORRY! Invalid Email/password please try again</FONT>
				<BR>
				<font Face="Comic Sans MS" size=3><A HREF="userLogin.jsp">&lt;&lt; Back</A></font>
				</P>
				<%
			}
		%>
</body>
</html>