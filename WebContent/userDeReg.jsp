<%@page import="org.sqlite.SQLiteException"%>
<%@page import="java.sql.*,model.*,java.io.File,java.util.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%! PreparedStatement statement=null;
    	Connection connection=null;
    	int update=-1;%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="css/theme.css">
<meta charset="ISO-8859-1">
<title>unregister user</title>
</head>
<body>
	<%if(session.getAttribute("name")==null || (int)session.getAttribute("auth")==1 || session.getAttribute("de-reg")==null){%>
		<P align=center><IMG SRC="Images/error48.png" WIDTH="48" HEIGHT="48" BORDER="0" ALT=""><br>
			<FONT COLOR="Red" size=5 Face="verdana">You are not permitted to Access the User Portal !</FONT>
			<BR>
			<font Face="Comic Sans MS" size=3><A HREF="userLogin.jsp">&lt;&lt; Back</A></font>
		</P>
	<%}else{
		if(((String)session.getAttribute("de-reg")).equals("true")){
			session.removeAttribute("de-reg");
			
			String[] part= this.getServletContext().getRealPath(File.separator).replace("\\", "/").split("/.metadata");
			connection=ConnectionFactory.getInstance().getConnection(part[0]+this.getServletContext().getContextPath());
		
			String name= (String) session.getAttribute("name");
			statement=connection.prepareStatement("DELETE FROM userAccount WHERE U_EMAIL=? AND U_ADMIN=0");
			statement.setString(1, (String)session.getAttribute("email"));
			
			try{
				statement.executeUpdate();
				System.out.println("\nUser DEREGISTERED :"+name);
				
				session.invalidate();
				System.out.println("\nLogged out Successfully! [USER: "+name+"]\n");
				%>
					<P align=center><IMG SRC="Images/correct48.png" WIDTH="48" HEIGHT="48" BORDER="0" ALT=""><br>
						<FONT COLOR="Green" size=5 Face="verdana">user De-registered !</FONT>
						<BR>
						<font Face="Comic Sans MS" size=3><A HREF="home.html">&lt;&lt; home</A></font>
					</P>
				<%
			}catch(SQLiteException s){
				s.printStackTrace();
				%>
					<P align=center><IMG SRC="Images/error48.png" WIDTH="48" HEIGHT="48" BORDER="0" ALT=""><br>
						<FONT COLOR="Red" size=5 Face="verdana">user De-registration unsuccessful !</FONT>
						<BR>
						<font Face="Comic Sans MS" size=3><A HREF="userHome.jsp">&lt;&lt; home</A></font>
					</P>
				<%
				}
			}
		}%>
</body>
</html>