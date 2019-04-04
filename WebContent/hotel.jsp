<%@page import="java.sql.*,model.*,java.util.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" session="true"%>
    <%! Statement statement=null; 
    	ResultSet resultSet=null;
    	ResultSet resultSetHotel=null;
    	Connection connection=null;
    	List<Integer> hoteList = new ArrayList<>();%>
<!DOCTYPE html>
<html>
<head>

<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/theme.css">
<title>Hotel portal</title>
<script type="text/javascript" src="scripts/main.js"></script>
<style type="text/css">
#home{
		width: 30%;
	    padding: 5%;
	    position: absolute;
	    top:20%;
    	left: 50%;
    	transform: translate(-20%, -75%);
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
		transform: translate(45%, 90%);
	}
	#logout{
		width: 200px;
	    padding: 10px;
	    position: absolute;
	    top:20%;
    	left: 50%;
    	transform: translate(-50%, 900%);
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
		connection=ConnectionFactory.getInstance().getConnection();
		statement=connection.createStatement();%>
		<h1 id="home"><a href="adminHome.jsp">Home</a></h1>
		<h2>Hi, <%=(String)session.getAttribute("name")%></h2><br>

<% if(((String)request.getParameter("hotel")).equals("Add Hotel")){ %>
<!-- Add hotel -->
<form class="f1" action="hotelFunc.jsp" method="post">
<table>
		<tr>
			<td>Hotel ID:</td>
			<td><input type="number" name="hID_a" placeholder="Auto Generated"
					title="Leave it blank for auto generation."></td>
		</tr>
		<tr>
			<td>Hotel Name:</td>
			<td><input name="hName_a" type="text" required="required"></td>
		</tr>
		<tr>
			<td>Tour Place:</td>
			<td><input name="hPlace_a" type="text" required="required"></td>
		</tr>
	</table>
	<br><input id="btn" type="submit" name="hotelFun" value="ADD">
</form>
<%}else if(((String)request.getParameter("hotel")).equals("Delete Hotel")){ 
	resultSetHotel=statement.executeQuery("SELECT * FROM hotelInfo");
	
	hoteList.clear();
		while(resultSetHotel.next()){
			hoteList.add(resultSetHotel.getInt(1));
		}resultSetHotel.close();%>
<!-- Delete hotel -->
<form action="hotelFunc.jsp" class="f1" method="post">
	Hotel Id : <SELECT id="hID_d" NAME="hID_d" required="required">
				<option value="Select-ID" disabled="disabled" selected="selected">Select ID</option>
				<%for(int i : hoteList){%>
					<option value="<%=i%>">h<%=i%></option>
				<%} %>
			</select><br>
			<a href="#" 
				onclick="openPopup('overview.jsp',document.getElementById('hID_d').value,'HD');">overview</a><br><br>
	<input id="btn" type="submit" name="hotelFun" value="DELETE">
</form>
<%}else if(((String)request.getParameter("hotel")).equals("Update Hotel")){ 
	resultSetHotel=statement.executeQuery("SELECT * FROM hotelInfo");
	
	hoteList.clear();
		while(resultSetHotel.next()){
			hoteList.add(resultSetHotel.getInt(1));
		}resultSetHotel.close();%>
<!-- Update hotel -->
<form class="f1" action="hotelFunc.jsp" method="post">
<table>
		<tr>
			<td>Hotel ID:</td>
			<td><SELECT id="hID_u" NAME="hID_u" required="required">
				<option value="Select-ID" disabled="disabled" selected="selected">Select ID</option>
				<%for(int i : hoteList){%>
					<option value="<%=i%>">h<%=i%></option>
				<%} %>
			</select><br>
			<a href="#" 
				onclick="openPopup('overview.jsp',document.getElementById('hID_u').value,'HU');">overview</a>
			</td>
			
		</tr>
		<tr>
			<td>Hotel Name:</td>
			<td><input type="text" name="hName_u" required="required"></td>
		</tr>
		<tr>
			<td>Tour Place:</td>
			<td><input type="text" name="hPalce_u" required="required"></td>
		</tr>
	</table>
	<br><input id="btn" type="submit" name="hotelFun" value="UPDATE">
</form>

<!-- View hotels -->
<%}else if(((String)request.getParameter("hotel")).equals("View Hotels")){
	resultSet=statement.executeQuery("SELECT * FROM hotelInfo");%>
	
	<div class="f1" style="overflow: auto;height: 45%; width: 22%;">
	<table id="t1">
			<tr>
				<th>H_ID</th>
				<th>H_NAME</th>
				<th>T_PLACE</th>
			</tr>
	
	<%while(resultSet.next()){%>
			<tr>
				<td><%=resultSet.getInt(1) %></td>
				<td><%=resultSet.getString(2) %></td>
				<td><%=resultSet.getString(3)%></td>
			</tr>
		<%} resultSet.close(); %>
		</table>
		</div>
<%}%>
<br><input id="logout" type="button" value="Logout" onclick="sendAlert();">
<%} %>

</body>
</html>