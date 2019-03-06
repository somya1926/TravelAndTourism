<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="java.lang.*,java.sql.*,model.ConnectionFactory" session="true"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Validating</title>
</head>
<body>
<%!boolean validUser=false;
	Connection connection=null;%>

	<%
	String QUERY= "SELECT auth  FROM login WHERE userid=? AND password=?";
		PreparedStatement statement=null;
		ResultSet resultSet=null;
		try{
			connection=ConnectionFactory.getInstance().getConnection();
			
			statement= connection.prepareStatement(QUERY);
			statement.setString(1, (String)request.getParameter("adminName"));
			statement.setString(2, (String)request.getParameter("adminPass"));
			resultSet=statement.executeQuery();
			
			if(resultSet.next()){
				if(!(resultSet.getInt(1)<0)){
					session.setAttribute("auth", resultSet.getInt(1));
					session.setAttribute("connection", connection);
					validUser=true;
				}
				System.out.println("auth:"+resultSet.getInt(1));
			}
		}catch(SQLException e){
			e.printStackTrace();
		}%>
		
		<%
			if(validUser){
				validUser=false;
				%>
				<P align=center><FONT COLOR="Green" Face="Georgia"><I><B>Welcome <%=request.getParameter("adminName")%></B></I></FONT>
		<BR><BR>
			<jsp:forward page="adminHome.html"/>
		</P>
				<%
			}
			else{
				
				%>
				<P align=center><IMG SRC="Images/error.gif" WIDTH="17" HEIGHT="13" BORDER="0" ALT=""><FONT COLOR="Red" Face="Georgia">SORRY! Invalid username/password please try again</FONT>
				<BR>
				<A HREF="adminLogin.html">&lt;&lt;Back</A>
				</P>
				<%
			}
		%>
</body>
</html>