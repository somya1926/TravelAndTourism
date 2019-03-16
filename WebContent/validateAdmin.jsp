<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"
    import="java.lang.*,java.sql.*,model.ConnectionFactory,java.io.File" session="true"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Validating Admin</title>
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
					validResult=true;
				}
				System.out.println("\nauth:"+resultSet.getInt(1)+"\nName: "+resultSet.getString(2)+"\nEmail: "+resultSet.getString(3));
			}
		}catch(SQLException e){
			e.printStackTrace();
		}%>
		
		<%
			if(validResult){
				validResult=false;
				if(resultSet.getInt(1)==1){
					%>
					<P align=center><FONT COLOR="Green" Face="Georgia"><I><B>Welcome <%=resultSet.getString(2)%></B></I></FONT>
						<BR><BR>
						<jsp:forward page="adminHome.jsp"/>
					</P>
					
				<%}else{ %>
					<P align=center><IMG SRC="Images/error48.png" WIDTH="48" HEIGHT="48" BORDER="0" ALT=""><br>
						<FONT COLOR="Red" size=5 Face="verdana">The User is not permitted to access the Admin Portal !</FONT>
						<BR>
						<font Face="Comic Sans MS" size=3><A HREF="adminLogin.html">&lt;&lt; Back</A></font>
					</P>
				<%
				}
			}else{
				
				%>
				<P align=center><IMG SRC="Images/error48.png" WIDTH="48" HEIGHT="48" BORDER="0" ALT=""><br>
				<FONT COLOR="Red" size=5 Face="verdana">SORRY! Invalid Email/password please try again</FONT>
				<BR>
				<font Face="Comic Sans MS" size=3><A HREF="adminLogin.html">&lt;&lt; Back</A></font>
				</P>
				<%
			}
		%>
</body>
</html>