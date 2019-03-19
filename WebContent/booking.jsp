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
<title>Booking Portal</title>
<script type="text/javascript">
		function sendAlert(){
			if (confirm("Are you sure you want to logout ?")) {
				location.href='logout.jsp';
			} 
		};
		function sendPrompt() {
			if (confirm("Book Now ?")) {
				location.href='booking.jsp';
			} 
		}
	</script>
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
<form class="f1" action="bookingTask.jsp" method="post">
<table>
		<tr>
			<td>Tour ID:</td>
			<td>
				<select NAME="tID">
					<option value="Select Place" disabled="disabled" selected="selected">Select Place</option>
					<%for (String s1 : fethTour){%>
						<option value="<%=s1%>">t<%=s1%></option>
					<%} %>
				</select>
				<input type="button" value="Overview" onclick="location.href('');">
			</td>
			
		</tr>
		<tr>
			<td>Tour Date:</td>
			<td><input type="date"></td>
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
	<table>
			<tr>
				<td>T_ID</td>
				<td>T_NAME</td>
				<td>T_PLACE_1</td>
				<td>T_PLACE_2</td>
				<td>T_PLACE_3</td>
				<td>T_DAYS</td>
				<td>T_PRICE</td>
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