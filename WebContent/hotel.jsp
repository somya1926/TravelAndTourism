<%@page import="java.sql.*,model.*,java.io.File,java.util.*"%>
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
<script type="text/javascript">
		function sendAlert(){
			if (confirm("Are you sure you want to logout ?")) {
				location.href='logout.jsp'
			} 
		}
	</script>
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
		font-family: sans-serif;
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
	table, th, td{
        border: 1px solid #666;
    }
    table th, table td{
        padding: 10px; /* Apply cell padding */
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
		<h1 id="home"><a href="adminHome.jsp">Home</a></h1>
		<h2>Hi, <%=(String)session.getAttribute("name")%></h2><br>

<% if(((String)request.getParameter("hotel")).equals("Add Hotel")){ %>
<!-- Add hotel -->
<form class="f1" action="#" method="post">
<table>
		<tr>
			<td>Hotel ID:</td>
			<td><input type="number" placeholder=" May be blank."
					title="Leave it blank for auto generation."></td>
		</tr>
		<tr>
			<td>Hotel Name:</td>
			<td><input type="text" required="required"></td>
		</tr>
		<tr>
			<td>Tour Place:</td>
			<td><input type="text" required="required"></td>
		</tr>
	</table>
	<br><input id="btn" type="submit" value="ADD">
</form>
<%}else if(((String)request.getParameter("hotel")).equals("Delete Hotel")){ 
	resultSetHotel=statement.executeQuery("SELECT * FROM hotelInfo");
	
	hoteList.clear();
		while(resultSetHotel.next()){
			hoteList.add(resultSetHotel.getInt(1));
		}resultSetHotel.close();%>
<!-- Delete hotel -->
<form action="#" class="f1" method="post">
	Hotel Id : <SELECT NAME="HID_D" required="required">
				<option value="Select-ID" disabled="disabled" selected="selected">Select ID</option>
				<%for(int i : hoteList){%>
					<option value="<%=i%>">h<%=i%></option>
				<%} %>
			</select><br><br>
	<input id="btn" type="submit" value="DELETE">
</form>
<%}else if(((String)request.getParameter("hotel")).equals("Update Hotel")){ 
	resultSetHotel=statement.executeQuery("SELECT * FROM hotelInfo");
	
	hoteList.clear();
		while(resultSetHotel.next()){
			hoteList.add(resultSetHotel.getInt(1));
		}resultSetHotel.close();%>
<!-- Update hotel -->
<form class="f1" action="#" method="post">
<table>
		<tr>
			<td>Hotel ID:</td>
			<td><SELECT NAME="HID_U" required="required">
				<option value="Select-ID" disabled="disabled" selected="selected">Select ID</option>
				<%for(int i : hoteList){%>
					<option value="<%=i%>">h<%=i%></option>
				<%} %>
			</select></td>
		</tr>
		<tr>
			<td>Hotel Name:</td>
			<td><input type="text" required="required"></td>
		</tr>
		<tr>
			<td>Tour Place:</td>
			<td><input type="text" required="required"></td>
		</tr>
	</table>
	<br><input id="btn" type="submit" value="UPDATE">
</form>

<!-- View hotels -->
<%}else if(((String)request.getParameter("hotel")).equals("View Hotels")){
	resultSet=statement.executeQuery("SELECT * FROM hotelInfo");%>
	
	<div class="f1" style="overflow: auto;height: 45%; width: 22%;">
	<table>
			<tr>
				<td>H_ID</td>
				<td>H_NAME</td>
				<td>T_PLACE</td>
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