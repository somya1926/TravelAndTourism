<%@page import="java.sql.*,model.*,java.io.File,java.util.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" session="true"%>
    <%! Statement statement=null; 
    	ResultSet resultSetFetch=null;
    	ResultSet resultSetUID=null;
    	ResultSet resultSetUEmail=null;
    	Connection connection=null;
    	List<Integer> uid= new ArrayList<>();
    	List<String> uEmail= new ArrayList<>();%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/theme.css">
<title>Miscellaneous Tasks</title>
<script type="text/javascript" src="scripts/main.js"></script>
<style type="text/css">
#home{
		width: 300px;
	    padding: 20px;
	    position: absolute;
	    top:60px;
    	left: 44%;
    	transform: translate(-20%, -60%);
    	align-items: center;
    	text-align: center;
	}
	.f1{
	width: 300px;
    padding: 40px;
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    background: silver;
    text-align: center;
	}
	h2 {
		align-content:center;
	}
	#logout{
		width: 200px;
	    padding: 10px;
	    position: absolute;
	    top:20%;
    	left: 50%;
    	transform: translate(-50%, 1000%);
    	font-weight: bold;
    	font-family: sans-serif;
    	font-size: 15px;
	}
	#btn{
		width: 100px;
	    padding: 5px;
		font-weight: bold;
    	font-family: sans-serif;
    	font-size: 15px;
	}#reg{
		width: 150px;
    	padding: 10px;
    	font-weight: bold;
    	font-family: sans-serif;
    	font-size: 15px;
	}
	</style>
</head>
<body>
	  <%if(session.getAttribute("name")==null || (int)session.getAttribute("auth")==0){%>
		<P align=center><IMG SRC="Images/error48.png" WIDTH="48" HEIGHT="48" BORDER="0" ALT=""><br>
			<FONT COLOR="Red" size=5 Face="verdana">You are not permitted to Access the Admin Portal !</FONT>
			<BR>
			<font Face="Comic Sans MS" size=3><A HREF="adminLogin.jsp">&lt;&lt; Back</A></font>
		</P>
	<%}else{
		String[] part= this.getServletContext().getRealPath(File.separator).replace("\\", "/").split("/.metadata");
		connection=ConnectionFactory.getInstance().getConnection(part[0]+this.getServletContext().getContextPath());
		statement=connection.createStatement();%>
	<div id="home">
			<h1><a href="adminHome.jsp">Home</a></h1>
			<h2>Hi, <%=(String)session.getAttribute("name")%></h2>
		</div>
	
		<% if(((String)request.getParameter("misc")).equals("Show Bookings")){ %>
		<!-- Show Bookings -->
		
		<%}else  if(((String)request.getParameter("misc")).equals("Revoke Booking")){%>
		<!-- Revoke Bookings -->
			
		<%}else if(((String)request.getParameter("misc")).equals("Show Payments")){%>
		<!-- Show Payments -->
			
		<!-- Show Users. -->
		<%}else if(((String)request.getParameter("misc")).equals("Show Users")){
		
		resultSetFetch=statement.executeQuery("SELECT U_ID, U_NAME, U_EMAIL, U_MOB, U_ADMIN FROM userAccount");%>
		
		<div class="f1" style="overflow: auto;height: 39%; width: 39%;">
		<table id="t1">
				<tr>
					<th>U_ID</th>
					<th>U_NAME</th>
					<th>U_EMAIL</th>
					<th>U_MOB</th>
					<th>U_ADMIN</th>
				</tr>
		
		<%while(resultSetFetch.next()){%>
				<tr>
					<td><%=resultSetFetch.getInt(1) %></td>
					<td><%=resultSetFetch.getString(2) %></td>
					<td><%=resultSetFetch.getString(3)%></td>
					<td><%=resultSetFetch.getLong(4)%></td>
					<td><%=resultSetFetch.getInt(5)%></td>
				</tr>
			<%} resultSetFetch.close(); %>
			</table>
			</div>
			<p style="font-size: 12px;  width: 600px;  position: absolute ;
				top:75%; left: 28%;font-family: cursive; background-color:#eeff41;" >
				<mark><b>*NOTE:</b></mark> Administrators are prohibited form accessing the passwords due to privacy concern.
			</p>
		<%} %>
		<br><input id="logout" type="button" value="Logout" onclick="sendAlert();">
	<%} %>
	
</body>
</html>