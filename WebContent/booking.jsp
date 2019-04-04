<%@page import="org.sqlite.SQLiteException"%>
<%@page import="java.sql.*,model.*,java.util.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" session="true"%>
    <%! Statement statement=null;
    PreparedStatement statement2=null;
    	ResultSet resultSetFetch=null;
    	Connection connection=null;
    	List<Integer> bid= new ArrayList<>();%>
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
	    padding: 20px;
	    position: absolute;
	    top:60px;
    	left: 44%;
    	transform: translate(-20%, -60%);
    	align-items: center;
    	text-align: center;
	}
	.f1{
	width: 600px;
	height:250px;
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
    	transform: translate(-50%, 900%);
    	font-weight: bold;
    	font-family: sans-serif;
    	font-size: 15px;
	}
	#btn{
		width: 100px;
	    padding: 5px;
	    margin:40px;
		font-weight: bold;
    	font-family: sans-serif;
    	font-size: 15px;
	}
	</style>
</head>
<body>
	<%if(session.getAttribute("name")==null || (int)session.getAttribute("auth")==1){%>
		<P align=center><IMG SRC="Images/error48.png" WIDTH="48" HEIGHT="48" BORDER="0" ALT=""><br>
			<FONT COLOR="Red" size=5 Face="verdana">You are not permitted to Access the User Portal !</FONT>
			<BR>
			<font Face="Comic Sans MS" size=3><A HREF="userLogin.jsp">&lt;&lt; Back</A></font>
		</P>
	<%}else{
		connection=ConnectionFactory.getInstance().getConnection();
		statement=connection.createStatement();%>
		<div id="home">
			<h1><a href="userHome.jsp">Home</a></h1>
			<h2>Hi, <%=(String)session.getAttribute("name")%></h2>
		</div>

<% if(((String)request.getParameter("book")).equals("Book now")){
	resultSetFetch=statement.executeQuery("SELECT T_ID FROM tourInfo");

	bid.clear();
		while(resultSetFetch.next()){
			bid.add(resultSetFetch.getInt(1));
		}%>
<!-- Book Now -->
<form class="f1" action="bookingFunc.jsp" method="post">
<table style="display: inline-block; float: left; width: 300px; height: 200px; padding: 10px">
		<tr>
			<td>Tour ID:</td>
			<td>
				<select id="bID_a" NAME="bID_a">
					<option value="Select-tour" disabled="disabled" selected="selected">Select Tour</option>
					<%for (int t1 : bid){%>
						<option value="<%=t1%>">t<%=t1%></option>
					<%} %>
				</select>
				<a href="#" 
					onclick="openPopup('overview.jsp',document.getElementById('bID_a').value,'AB');">overview</a>
			</td>
			
		</tr>
		<tr>
			<td>Tour Date:</td>
			<td><input type="text" id="datepicker" placeholder="YYYY-MM-DD" name="tDate"></td>
		</tr>
		<tr>
			<td>Total Persons:</td>
			<td><input type="number" title="Must be between 1 to 10."
					name="pNo" placeholder="From 3 years of age.">
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
	</table>
	
	<table style="display: inline-block; width:300px; height: 200px; float: right;  padding: 1px;">
			<tr>
				<td>Full Name :</td>
				<td><input type="text" name="cName" placeholder="Card Holder`s Name"></td>
			</tr>
			<tr>
				<td>Card No:</td>
				<td><input type="number" name="cNo"></td>
			</tr>
			<tr>
				<td>Expire Date:</td>
				<td><input type="text"  id="expiryDate" name="cExp" placeholder="MM/YY"></td>
			</tr>
			<tr>
				<td>CVV No:</td>
				<td><input type="number" name="cvv"></td>
			</tr>
		</table>
	<br>
	<input id="btn" class="cal" type="submit" name="uBooking" value="Book Now">
	</form>
	<!-- Booking History -->
	<%}else  if(((String)request.getParameter("book")).equals("Booking History")){
		statement2=connection.prepareStatement("SELECT * FROM bookingInfo WHERE U_EMAIL=?");
		statement2.setString(1, (String)session.getAttribute("email"));
		resultSetFetch=statement2.executeQuery();%>
		
		<div class="f1" style="overflow: auto;height: 49%; width: 65%;">
		<table id="t1">
				<tr>
					<th>B_ID</th>
					<th>B_DATE</th>
					<th>T_ID</th>
					<th>T_DATE</th>
					<th>U_EMAIL</th>
					<th>PERSONS</th>
					<th>R_TYPE</th>
					<th>T_AMOUNT</th>
					<th>STATUS</th>
				</tr>
		
		<%while(resultSetFetch.next()){%>
				<tr>
					<td><%=resultSetFetch.getInt(1) %></td>
					<td><%=resultSetFetch.getString(2) %></td>
					<td><a href="#" 
						onclick="openPopup('overview.jsp',<%=resultSetFetch.getInt(3)%>,'UCB');">
						<%=resultSetFetch.getInt(3)%></a></td>
					<td><%=resultSetFetch.getString(4)%></td>
					<td><%=resultSetFetch.getString(5)%></td>
					<td><%=resultSetFetch.getInt(6) %></td>
					
					<%if(resultSetFetch.getString(7).equals("DE")) {%>
						<td>DELUXE</td>
					<%}else if(resultSetFetch.getString(7).equals("SU")){ %>
						<td>SUPERIOR</td>
					<%} else if(resultSetFetch.getString(7).equals("ST")){ %>
						<td>STANDARD</td>
					<%} %>
					<td><%=resultSetFetch.getInt(8)%></td>
					
					<%if(resultSetFetch.getInt(9)==1) {%>
						<td>AVAILABLE</td>
					<%}else if(resultSetFetch.getInt(9)==0){ %>
						<td>CANCELLED</td>
					<%} %>
				</tr>
			<%} resultSetFetch.close(); %>
			</table>
			</div>
	
	<!-- Cancel Booking -->
	<%}else  if(((String)request.getParameter("book")).equals("Cancel Booking")){
		statement2=connection.prepareStatement("SELECT B_ID FROM bookingInfo WHERE U_EMAIL=? AND STATUS=1");
		statement2.setString(1, (String)session.getAttribute("email"));
		resultSetFetch=statement2.executeQuery();

		bid.clear();
		while(resultSetFetch.next()){
			bid.add(resultSetFetch.getInt(1));
		}%>
		<form action="bookingFunc.jsp" class="f1" method="post">
		Booking Id : <SELECT id="BID_d" NAME="BID_d" required="required">
				<option value="Select-ID" disabled="disabled" selected="selected">Select ID</option>
				<%for (int i2 : bid){%>
					<option value="<%=i2%>">t<%=i2%></option>
				<%} %>
			</select><br>
			<a href="#" 
				onclick="openPopup('overview.jsp',document.getElementById('BID_d').value,'CB');">overview</a>
				<br><br>
			<input id="btn" type="submit" name="uBooking" value="CANCEL">
		</form>
	
	<!-- Booking Report -->
	<%}else if(((String)request.getParameter("book")).equals("Booking Report")){
	
		statement2=connection.prepareStatement("SELECT B_ID FROM bookingInfo WHERE U_EMAIL=? AND STATUS=1");
		statement2.setString(1, (String)session.getAttribute("email"));
		resultSetFetch=statement2.executeQuery();

		bid.clear();
		while(resultSetFetch.next()){
			bid.add(resultSetFetch.getInt(1));
		}%>
		<form action="bookingFunc.jsp" class="f1" style="width: 300px; height: auto;" method="post">
		Booking Id : <SELECT id="BID_r" NAME="BID_r" required="required">
				<option value="Select-ID" disabled="disabled" selected="selected">Select ID</option>
				<%for (int i2 : bid){%>
					<option value="<%=i2%>">t<%=i2%></option>
				<%} %>
			</select>
				<br>
			<input id="btn" style="width: 150px;" type="submit" name="uBooking" value="VIEW REPORT">
		</form>
	
	<!-- View tours -->
	<%}else if(((String)request.getParameter("book")).equals("View Tours")){ 
	resultSetFetch=statement.executeQuery("SELECT * FROM tourInfo");%>
	
	<div class="f1" style="overflow: auto;height: 35%; width: 48%; ">
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
		
		<!-- User De-register -->	
		<%}else if(((String)request.getParameter("book")).equals("De-register")){
			session.setAttribute("de-reg", "true");%>
			<form id="dereg" action="UserDeReg" method="post"></form>
			<script type="text/javascript">unregister();</script>
		<%}%>
	<br><input id="logout" type="button" value="Logout" onclick="sendAlert();">
	<%} %>
</body>
</html>