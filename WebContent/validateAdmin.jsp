<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"
    import="java.lang.*,java.sql.*,model.ConnectionFactory,java.io.File" session="true"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Validating Admin</title>
</head>
<body>
<%!boolean validAdmin=false;
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
			statement.setString(1, (String)request.getParameter("adminName"));
			statement.setString(2, (String)request.getParameter("adminPass"));
			resultSet=statement.executeQuery();
			
			if(resultSet.next()){
				if(resultSet.getString(3).equals(request.getParameter("adminName"))){
					session.setAttribute("auth", resultSet.getInt(1));
					session.setAttribute("name", resultSet.getString(2));
					validAdmin=true;
				}
				System.out.println("\nauth:"+resultSet.getInt(1)+"\nName: "+resultSet.getString(2)+"\nUName: "+resultSet.getString(3));
			}
		}catch(SQLException e){
			e.printStackTrace();
		}%>
		
		<%
			if(validAdmin){
				validAdmin=false;
				if(resultSet.getInt(1)==1){
					%>
					<P align=center><FONT COLOR="Green" Face="Georgia"><I><B>Welcome <%=request.getParameter("adminName")%></B></I></FONT>
						<BR><BR>
						<jsp:forward page="adminHome.jsp"/>
					</P>
					
				<%}else{ %>
					<P align=center><IMG SRC="Images/error.gif" WIDTH="17" HEIGHT="13" BORDER="0" ALT="">
						<FONT COLOR="Red" Face="Georgia">The User is not permitted to Access the Admin Portal !</FONT>
						<BR>
						<A HREF="adminLogin.html">&lt;&lt;Back</A>
					</P>
				<%
				}
			}else{
				
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