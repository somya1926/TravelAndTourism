<%@page import="org.sqlite.*"%>
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
		String QUERY= "INSERT INTO userAccount (U_PASS,U_NAME,U_EMAIL,U_MOB) VALUES(?,?,?,?)";
		PreparedStatement statement=null;
		int updatecode=-1;
		String[] part= this.getServletContext().getRealPath(File.separator).replace("\\", "/").split("/.metadata");
		try{
			connection=ConnectionFactory.getInstance().getConnection(
					part[0]+this.getServletContext().getContextPath());
			statement= connection.prepareStatement(QUERY);
			
			System.out.println("\n REGISTRATION INFO:");
			System.out.println((String)request.getParameter("name"));
			System.out.println((String)request.getParameter("pass"));
			System.out.println((String)request.getParameter("cPass"));
			System.out.println((String)request.getParameter("email"));
			System.out.println(Long.parseLong((String)request.getParameter("phone")));
			
			if(!(request.getParameter("pass").equals(request.getParameter("cPass")))){%>
				<P align=center><IMG SRC="Images/error.png" WIDTH="17" HEIGHT="17" BORDER="0" ALT="">
					<FONT COLOR="Red" Face="Georgia">Password Mismatch !</FONT>
					<BR>
					<A HREF="userReg.html">&lt;&lt;Retry Again</A>
				</P>
			<%}else{
				statement.setString(1, (String)request.getParameter("pass"));
			}
			statement.setString(2, (String)request.getParameter("name"));
			statement.setString(3, (String)request.getParameter("email"));
			statement.setLong(4, Long.parseLong((String)request.getParameter("phone")));
			updatecode=statement.executeUpdate();
			
			if(updatecode>0){
				System.out.println("Registration Successful !\n");%>
			
			<P align=center><IMG SRC="Images/correct48.png" WIDTH="48" HEIGHT="48" BORDER="0" ALT=""><br>
					<FONT COLOR="Green" size=5 Face="verdana">User Registration Successful !</FONT>
					<BR>
					<font Face="Comic Sans MS" size=3><A HREF="userLogin.html">&lt;&lt; Login Now</A></font>
			</P>
			
			<%}else{%>
				<P align=center><IMG SRC="Images/error48.png" WIDTH="48" HEIGHT="48" BORDER="0" ALT=""><br>
					<FONT COLOR="Red" size=5 Face="verdana">User Registration Unsuccessful ! <br> Retry again.</FONT>
					<BR>
					<font Face="Comic Sans MS" size=3><A HREF="userReg.html">&lt;&lt; Back</A></font>
				</P>
			<%}
			
		}catch(SQLIntegrityConstraintViolationException e){
			e.printStackTrace();%>
			<P align=center><IMG SRC="Images/error48.png" WIDTH="48" HEIGHT="48" BORDER="0" ALT=""><br>
				<FONT COLOR="Red" size=5 Face="verdana">Either Email or Mobile number has already been registered !</FONT>
				<BR>
				<font Face="Comic Sans MS" size=3><A HREF="userReg.html">&lt;&lt; Back</A></font>
			</P>
		<%}catch(SQLiteException e){
			e.printStackTrace();%>
			<P align=center><IMG SRC="Images/error48.png" WIDTH="48" HEIGHT="48" BORDER="0" ALT=""><br>
				<FONT COLOR="Red" size=5 Face="verdana">Either Email or Mobile number has already been registered !</FONT>
				<BR>
				<font Face="Comic Sans MS" size=3><A HREF="userReg.html">&lt;&lt; Back</A></font>
			</P>
		<%
		}catch(SQLException c){
			c.printStackTrace();
		}%>
</body>
</html>