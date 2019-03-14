<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.lang.*,java.sql.*,model.ConnectionFactory,java.io.File"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>UserReg</title>
</head>
<body>
<%!boolean validUser=false;
	Connection connection=null;%>

	<%
		String QUERY= "INSERT INTO userAccount VALUES(?,?,?,?,?,0)";
		PreparedStatement statement=null;
		int updatecode=-1;
		String[] part= this.getServletContext().getRealPath(File.separator).replace("\\", "/").split("/.metadata");
		try{
			connection=ConnectionFactory.getInstance().getConnection(
					part[0]+this.getServletContext().getContextPath()+"/database/userInfo.db");
			statement= connection.prepareStatement(QUERY);
			System.out.println("\n"+(String)request.getParameter("uName"));
			System.out.println((String)request.getParameter("pass"));
			System.out.println((String)request.getParameter("cPass"));
			System.out.println((String)request.getParameter("name"));
			System.out.println((String)request.getParameter("email"));
			System.out.println(Long.parseLong((String)request.getParameter("phone"))+"\n");
			
			statement.setString(1, (String)request.getParameter("uName"));
			if(!(request.getParameter("pass").equals(request.getParameter("cPass")))){%>
				<P align=center><IMG SRC="Images/error.png" WIDTH="17" HEIGHT="17" BORDER="0" ALT="">
					<FONT COLOR="Red" Face="Georgia">Password Mismatch !</FONT>
					<BR>
					<A HREF="userReg.html">&lt;&lt;Retry Again</A>
				</P>
			<%}else{
				statement.setString(2, (String)request.getParameter("pass"));
			}
			statement.setString(2, (String)request.getParameter("pass"));
			statement.setString(3, (String)request.getParameter("name"));
			statement.setString(4, (String)request.getParameter("email"));
			statement.setLong(5, Long.parseLong((String)request.getParameter("phone")));
			updatecode=statement.executeUpdate();
			
		}catch(SQLIntegrityConstraintViolationException e){
			e.printStackTrace();%>
			<P align=center><IMG SRC="Images/error.png" WIDTH="17" HEIGHT="17" BORDER="0" ALT="">
				<FONT COLOR="Red" Face="Georgia">Either of the user name, email or mobile number has be registered !</FONT>
				<BR>
				<A HREF="userReg.html">&lt;&lt;Back</A>
			</P>
		<%}catch(SQLException c){
			c.printStackTrace();
		}
		
		if(updatecode>0){%>
		
		<P align=center><IMG SRC="Images/correct.png" WIDTH="17" HEIGHT="17" BORDER="0" ALT="">
				<FONT COLOR="Green" Face="Georgia">User Registration unsuccessful !</FONT>
				<BR>
				<A HREF="userLogin.html">&lt;&lt;Login Now</A>
		</P>
		
		<%}else{%>
			<P align=center><IMG SRC="Images/error.png" WIDTH="17" HEIGHT="17" BORDER="0" ALT="">
				<FONT COLOR="Red" Face="Georgia">User Registration unsuccessful ! <br> Retry again.</FONT>
				<BR>
				<A HREF="userReg.html">&lt;&lt;Back</A>
			</P>
		<%}%>
</body>
</html>