<%@page import="java.sql.*,model.*,java.util.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%! PreparedStatement statement=null; 
    	ResultSet resultSetFetch=null;
    	Connection connection=null;
    	int update=-1;%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Miscellaneous Function</title>
<link rel="stylesheet" type="text/css" href="css/theme.css">
<script type="text/javascript" src="scripts/main.js"></script>
</head>
<body>
<%if(session.getAttribute("name")==null || (int)session.getAttribute("auth")==0){%>
		<P align=center><IMG SRC="Images/error48.png" WIDTH="48" HEIGHT="48" BORDER="0" ALT=""><br>
			<FONT COLOR="Red" size=5 Face="verdana">You are not permitted to Access the Admin Portal !</FONT>
			<BR>
			<font Face="Comic Sans MS" size=3><A HREF="adminLogin.jsp">&lt;&lt; Back</A></font>
		</P>
	<%}else{
		connection=ConnectionFactory.getInstance().getConnection();
			try{
				if(((String)request.getParameter("miscFun")).equals("REVOKE")){
					statement=connection.prepareStatement("UPDATE bookingInfo SET STATUS=0 WHERE B_ID=?;");
					statement.setInt(1, Integer.parseInt((String)request.getParameter("MB_r")));
					update=statement.executeUpdate();
					
					if(update>0){
						%>
						<P align=center><IMG SRC="Images/correct48.png" WIDTH="48" HEIGHT="48" BORDER="0" ALT=""><br>
							<FONT COLOR="Green" size=5 Face="verdana">Booking Revocation Successful !</FONT>
							<BR>
							<font Face="Comic Sans MS" size=3><A HREF="adminHome.jsp">&lt;&lt; Back</A></font>
						</P>
						<%
					}else{
						%>
						<P align=center><IMG SRC="Images/error48.png" WIDTH="48" HEIGHT="48" BORDER="0" ALT=""><br>
							<FONT COLOR="Red" size=5 Face="verdana">Booking Revocation Unsuccessful !</FONT>
							<BR>
							<font Face="Comic Sans MS" size=3><A HREF="adminHome.jsp">&lt;&lt; Try again</A></font>
						</P>
						<%
					}
					
				}
			}catch(SQLException s){
				s.printStackTrace();
			}finally{
				statement.close();
			}
		}%>
</body>
</html>