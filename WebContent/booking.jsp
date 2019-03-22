<%@page import="java.sql.*,model.*,java.io.File,java.util.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" session="true"%>
    <%! Statement statement=null; 
    	ResultSet resultSetFetch=null;
    	Connection connection=null;
    	List<String> fethTour= new ArrayList<>();%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/theme.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://ajax.aspnetcdn.com/ajax/jquery.ui/1.10.4/themes/hot-sneaks/jquery-ui.css">
<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
<title>Booking Portal</title>
<script type="text/javascript" src="scripts/main.js"></script>
<style type="text/css">
#home{
		width: 300px;
	    padding: 40px;
	    position: absolute;
	    top:20%;
    	left: 50%;
    	transform: translate(-20%, -60%);
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
	<%if(session.getAttribute("name")==null || (int)session.getAttribute("auth")==1){%>
		<P align=center><IMG SRC="Images/error48.png" WIDTH="48" HEIGHT="48" BORDER="0" ALT=""><br>
			<FONT COLOR="Red" size=5 Face="verdana">You are not permitted to Access the Admin Portal !</FONT>
			<BR>
			<font Face="Comic Sans MS" size=3><A HREF="userLogin.jsp">&lt;&lt; Back</A></font>
		</P>
	<%}else{
		String[] part= this.getServletContext().getRealPath(File.separator).replace("\\", "/").split("/.metadata");
		connection=ConnectionFactory.getInstance().getConnection(part[0]+this.getServletContext().getContextPath());
		statement=connection.createStatement();
		resultSetFetch=statement.executeQuery("SELECT * FROM tourInfo");%>
	<h1 id="home"><a href="userHome.jsp">Home</a></h1>
	<h2>Hi, <%=(String)session.getAttribute("name")%></h2>

<% if(((String)request.getParameter("book")).equals("Book now")){ 

	fethTour.clear();
		while(resultSetFetch.next()){
			fethTour.add(resultSetFetch.getString(1));
		}%>
<!-- Book Now -->
<form class="f1" action="bookingFunc.jsp" method="post">
<table>
		<tr>
			<td>Tour ID:</td>
			<td>
				<select id="bID_a" NAME="bID_a">
					<option value="Select-tour" disabled="disabled" selected="selected">Select Tour</option>
					<%for (String s1 : fethTour){%>
						<option value="<%=s1%>">t<%=s1%></option>
					<%} %>
				</select>
				<a href="#" 
					onclick="openPopup('overview.jsp',document.getElementById('bID_a').value,'AB');">overview</a>
			</td>
			
		</tr>
		<tr>
			<td>Tour Date:</td>
			<td><input type="text" id="datepicker" placeholder="YYYY-MM-DD"></td>
		</tr>
		<tr>
			<td>Total Persons:</td>
			<td><input type="number" title="Must be between 1 to 10."
					placeholder="From 3 years of age.">
			</td>
		</tr>
		<tr>
			<td>Room type:</td>
			<td>
				<select NAME="rType">
					<option value="Select-type" disabled="disabled" selected="selected">Select Type</option>
					<option value="ST">Standard</option>
					<option value="SU">Superior</option>
					<option value="DE">Deluxe</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>Pay now:</td>
			<td>
	<input type="radio" name="payment" value="1" required="required"> YES | 
	<input type="radio" name="payment" value="0" required="required"> NO
			</td>
		</tr>
	</table>
	<br>
	<input id="btn" type="submit" value="Book Now">
	</form>
	<!-- Booking History -->
	<%}else  if(((String)request.getParameter("book")).equals("Booking History")){
		//TODO: Search booking.%>
	
	<!-- Cancel Booking -->
	<%}else  if(((String)request.getParameter("book")).equals("Cancel Booking")){
		//TODO: Cancel booking.%>
	
	<!-- Booking Report -->
	<%}else if(((String)request.getParameter("book")).equals("Booking Report")){
		//TODO: Booking Report !%>
	
	<!-- View tours -->
	<%}else if(((String)request.getParameter("book")).equals("View Tours")){ %>
	
	<div class="f1" style="overflow: auto;height: 35%; width: 48%;">
	<table id="t1">
			<tr>
				<th>T_ID</th>
				<th>T_NAME</th>
				<th>T_PLACE_1</th>
				<th>T_PLACE_2</th>
				<th>T_PLACE_3</th>
				<th>T_DAYS</th>
				<th>T_PRICE</th>
			</tr>
	
	<%while(resultSetFetch.next()){%>
			<tr>
				<td><%=resultSetFetch.getInt(1) %></td>
				<td><%=resultSetFetch.getString(2) %></td>
				<td><%=resultSetFetch.getString(3)%></td>
				<td><%=resultSetFetch.getString(4)%></td>
				<td><%=resultSetFetch.getString(5)%></td>
				<td><%=resultSetFetch.getInt(6)%></td>
				<td><%=resultSetFetch.getInt(7)%></td>
			</tr>
		<%} resultSetFetch.close(); %>
		</table>
		</div>
		
	<%}%>
	<br><input id="logout" type="button" value="Logout" onclick="sendAlert();">
	<%} %>
</body>
</html>