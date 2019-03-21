<%@page import="java.sql.*,model.*,java.io.File,java.util.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%! PreparedStatement statement=null;
    	ResultSet resultSetFetch=null;
    	Connection connection=null;
    	String key=null;
    	int val=-1;%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Overview Window</title>
<link rel="stylesheet" type="text/css" href="css/theme.css">
<script type="text/javascript" src="scripts/main.js"></script>
<style type="text/css">
	#logout{
		width: 100px;
	    padding: 5px;
	    position: absolute;
	    top:20%;
    	left: 50%;
    	transform: translate(-50%, 700%);
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
		key=(String)request.getParameter("key");
		
		try{
			val=Integer.parseInt((String)request.getParameter("val"));
		
		
		if(key.equals("TU") || key.equals("TD")){
		statement=connection.prepareStatement("SELECT * FROM tourInfo WHERE T_ID=?");
		statement.setInt(1, val);
		resultSetFetch=statement.executeQuery();
		%>
	<table id="t1" style="font-size: 14px; font-family: sans-serif;">
			<tr>
				<th>T_ID</th>
				<td><%=resultSetFetch.getInt(1) %></td>
			</tr>
			<tr>
				<th>T_NAME</th>
				<td><%=resultSetFetch.getString(2) %></td>
			</tr>
			<tr>
				<th>T_PLACE_1</th>
				<td><%=resultSetFetch.getString(3)%></td>
			</tr>
			<tr>
				<th>T_PLACE_2</th>
				<td><%=resultSetFetch.getString(4)%></td>
			</tr>
			<tr>
				<th>T_PLACE_3</th>
				<td><%=resultSetFetch.getString(5)%></td>
			</tr>
			<tr>
				<th>T_DAYS</th>
				<td><%=resultSetFetch.getInt(6)%></td>
			</tr>
			<tr>
				<th>T_PRICE</th>
				<td><%=resultSetFetch.getInt(7)%></td>
			</tr>
		</table>
		<%}
		}catch(NumberFormatException e){
			%>
			<P align=center style="background-color:#eeff41;">
			<IMG SRC="Images/warning48.png" WIDTH="48" HEIGHT="48" BORDER="0" ALT=""><br>
			<FONT size=5 Face="verdana">Select the tour correctly !</FONT>
			<BR>
			<font Face="Comic Sans MS" size=3><A HREF="adminLogin.jsp">&lt;&lt; Back</A></font>
		</P>
			<%
		}
	}%>
<button id="logout" type="button" onclick="closePopup();">close</button>
</body>
</html>