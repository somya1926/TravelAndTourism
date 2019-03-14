<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.lang.*,java.sql.*,model.ConnectionFactory,java.io.File" session="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Validating User</title>
</head>
<body>
<%!boolean validUser=false;
	Connection connection=null;%>

	<%
	String QUERY= "SELECT AUTH,NAME,UNAME  FROM userAccount WHERE UNAME=? AND PASSWORD=?";
		PreparedStatement statement=null;
		ResultSet resultSet=null;
		
		String[] part= this.getServletContext().getRealPath(File.separator).replace("\\", "/").split("/.metadata");
		try{
			connection=ConnectionFactory.getInstance().getConnection(
					part[0]+this.getServletContext().getContextPath()+"/database/userInfo.db");
			
			statement= connection.prepareStatement(QUERY);
			statement.setString(1, (String)request.getParameter("userName"));
			statement.setString(2, (String)request.getParameter("userPass"));
			resultSet=statement.executeQuery();
			
			if(resultSet.next()){
				if(resultSet.getString(3).equals(request.getParameter("userName"))){
					session.setAttribute("auth", resultSet.getInt(1));
					session.setAttribute("name", resultSet.getString(2));
					validUser=true;
				}
				System.out.println("\nauth:"+resultSet.getInt(1)+"\nName: "+resultSet.getString(2)+"\nUName: "+resultSet.getString(3));
			}
		}catch(SQLException e){
			e.printStackTrace();
		}%>
		
		<%
			if(validUser){
				validUser=false;
				if(resultSet.getInt(1)==0){
					%>
					<P align=center><FONT COLOR="Green" Face="Georgia"><I><B>Welcome <%=request.getParameter("userName")%></B></I></FONT>
						<BR><BR>
						<jsp:forward page="userHome.jsp"/>
					</P>
					
				<%}else{ %>
					<P align=center><IMG SRC="Images/error.png" WIDTH="17" HEIGHT="17" BORDER="0" ALT="">
						<FONT COLOR="Red" Face="Georgia">Administrators are prohibited from using User Portal !</FONT>
						<BR>
						<A HREF="userLogin.html">&lt;&lt;Back</A>
					</P>
				<%
				}
			}else{
				
				%>
				<P align=center><IMG SRC="Images/error.png" WIDTH="17" HEIGHT="17" BORDER="0" ALT=""><FONT COLOR="Red" Face="Georgia">SORRY! Invalid username/password please try again</FONT>
				<BR>
				<A HREF="userLogin.html">&lt;&lt;Back</A>
				</P>
				<%
			}
		%>
</body>
</html>
</body>
</html>