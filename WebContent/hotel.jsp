<%@page import="java.sql.*,model.*,java.io.File"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%! Statement statement=null; 
    	ResultSet resultSet=null;
    	Connection connection=null;%>
<!DOCTYPE html>
<html>
<head>

<meta charset="ISO-8859-1">
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
<h1 id="home"><a href="adminHome.jsp">Home</a></h1>
	  <%if(session.getAttribute("name")==null || (int)session.getAttribute("auth")==0){%>
		<P align=center><IMG SRC="Images/error48.png" WIDTH="48" HEIGHT="48" BORDER="0" ALT=""><br>
			<FONT COLOR="Red" size=5 Face="verdana">You are not permitted to Access the Admin Portal !</FONT>
			<BR>
			<font Face="Comic Sans MS" size=3><A HREF="adminLogin.html">&lt;&lt; Back</A></font>
		</P>
	<%}else{ System.out.println("hotel: "+(String)request.getParameter("hotel"));%>
	<h2>Hi, <%=(String)session.getAttribute("name") %></h2><br>

<% if(((String)request.getParameter("hotel")).equals("Add Hotel")){ %>
<!-- Add hotel -->
<form class="f1" action="#" method="post">
<table>
		<tr>
			<td>Hotel ID:</td>
			<td><input type="number" required="required"></td>
		</tr>
		<tr>
			<td>Hotel Name:</td>
			<td><input type="text" required="required"></td>
		</tr>
		<tr>
			<td>Tour Place:</td>
			<td>
			<SELECT NAME="tPlace" required="required">
				<option value="Select Place" disabled="disabled" selected="selected">Select Place</option>
				<option value="A.S.Peta">A.S.Peta</option>
				<option value="Ahmedabad">Ahmedabad</option>
				<option value="Amalapuram">Amalapuram</option>
				<option value="Ambaji">Ambaji</option>
				<option value="Anakapalli">Anakapalli</option>
				<option value="Anantapur">Anantapur</option>
				<option value="Annavaram">Annavaram</option>
				<option value="Atmakur">Atmakur</option>
				<option value="Aurangabad">Aurangabad </option>
				<option value="Bangalore">Bangalore</option>
				<option value="Bapatla">Bapatla</option>
				<option value="Bhopal">Bhopal</option>
				<option value="Bhuj">Bhuj</option>
				<option value="Chandigarh">Chandigarh </option>
				<option value="Chennai">Chennai</option>
				<option value="Chilakaluripet">Chilakaluripet</option>
				<option value="Chirala">Chirala</option>
				<option value="Cochin">Cochin</option>
				<option value="Delhi">Delhi</option>
				<option value="Devarpalli">Devarpalli</option>
				<option value="Gandhidham">Gandhidham </option>
				<option value="Goa">Goa</option>
				<option value="Gokavaram">Gokavaram</option>
				<option value="Guduru">Guduru</option>
				<option value="Guntur">Guntur</option>
				<option value="Hubli">Hubli</option>
				<option value="Hyderabad">Hyderabad</option>
				<option value="Indore">Indore </option>
				<option value="Inkollu">Inkollu</option>
				<option value="Jaggampet">Jaggampet</option>
				<option value="Jaipur">Jaipur</option>
				<option value="Jammu">Jammu</option>
				<option value="Jamnagar">Jamnagar </option>
				<option value="Jangareddy Gudem">Jangareddy Gudem</option>
				<option value="Kadapa">Kadapa</option>
				<option value="Kakinada">Kakinada</option>
				<option value="Kaligiri">Kaligiri</option>
				<option value="Karimnagar">Karimnagar</option>
				<option value="Kathipudi">Kathipudi</option>
				<option value="Katra">Katra </option>
				<option value="Kavali">Kavali</option>
				<option value="Kolhapur">Kolhapur </option>
				<option value="Kovvuru">Kovvuru</option>
				<option value="Kurnool">Kurnool</option>
				<option value="Mahabaleshwar">Mahabaleshwar</option>
				<option value="Mahabalipuram">Mahabalipuram </option>
				<option value="Manali">Manali </option>
				<option value="Mangalore">Mangalore </option>
				<option value="MountAbu">MountAbu</option>
				<option value="Mumbai">Mumbai</option>
				<option value="Naidupeta">Naidupeta</option>
				<option value="Narasaraopet">Narasaraopet</option>
				<option value="Nasik">Nasik</option>
				<option value="Nellore">Nellore</option>
				<option value="Ongole">Ongole</option>
				<option value="Palitana">Palitana </option>
				<option value="Pangidi">Pangidi</option>
				<option value="Peddapuram">Peddapuram</option>
				<option value="Ponnur">Ponnur</option>
				<option value="Pune">Pune</option>
				<option value="Railway Koduru">Railway Koduru</option>
				<option value="Raja Nagaram">Raja Nagaram</option>
				<option value="Rajampet">Rajampet</option>
				<option value="Rajamundry">Rajamundry</option>
				<option value="Rajkot">Rajkot</option>
				<option value="Rangampeta">Rangampeta</option>
				<option value="Razole">Razole</option>
				<option value="S.Konda">S.Konda</option>
				<option value="Samarla Kota">Samarla Kota</option>
				<option value="Sathenpalli">Sathenpalli</option>
				<option value="Shiridi">Shiridi</option>
				<option value="Shreenathji">Shreenathji </option>
				<option value="Srikakulam">Srikakulam</option>
				<option value="Srinagar">Srinagar </option>
				<option value="Sullurupeta">Sullurupeta</option>
				<option value="Surat">Surat</option>
				<option value="Tenali">Tenali</option>
				<option value="Thrissur">Thrissur </option>
				<option value="Tiruchirapally">Tiruchirapally </option>
				<option value="Tirupathi">Tirupathi</option>
				<option value="Tuni">Tuni</option>
				<option value="Udaipur">Udaipur</option>
				<option value="Ujjain">Ujjain</option>
				<option value="Ulavapadu">Ulavapadu</option>
				<option value="Vadodara">Vadodara</option>
				<option value="Vetapalem">Vetapalem</option>
				<option value="Vijayanagaram">Vijayanagaram</option>
				<option value="Vijayawada">Vijayawada</option>
				<option value="Vinjamoor">Vinjamoor</option>
				<option value="Vizag">Vizag</option>
				<option value="Warangal">Warangal</option>
			</select>
			</td>
		</tr>
	</table>
	<br><input id="btn" type="submit" value="ADD">
</form>
<%}else if(((String)request.getParameter("hotel")).equals("Delete Hotel")){ %>
<!-- Delete hotel -->
<form action="#" class="f1" method="post">
	Hotel Id : <input type="number" required="required"><br><br>
	<input id="btn" type="submit" value="DELETE">
</form>
<%}else if(((String)request.getParameter("hotel")).equals("Update Hotel")){ %>
<!-- Update hotel -->
<form class="f1" action="#" method="post">
<table>
		<tr>
			<td>Hotel ID:</td>
			<td><input type="number" required="required"></td>
		</tr>
		<tr>
			<td>Hotel Name:</td>
			<td><input type="text" required="required"></td>
		</tr>
		<tr>
			<td>Tour Place:</td>
			<td>
			<SELECT NAME="tPlace" required="required">
				<option value="Select Place" disabled="disabled" selected="selected">Select Place</option>
				<option value="A.S.Peta">A.S.Peta</option>
				<option value="Ahmedabad">Ahmedabad</option>
				<option value="Amalapuram">Amalapuram</option>
				<option value="Ambaji">Ambaji</option>
				<option value="Anakapalli">Anakapalli</option>
				<option value="Anantapur">Anantapur</option>
				<option value="Annavaram">Annavaram</option>
				<option value="Atmakur">Atmakur</option>
				<option value="Aurangabad">Aurangabad </option>
				<option value="Bangalore">Bangalore</option>
				<option value="Bapatla">Bapatla</option>
				<option value="Bhopal">Bhopal</option>
				<option value="Bhuj">Bhuj</option>
				<option value="Chandigarh">Chandigarh </option>
				<option value="Chennai">Chennai</option>
				<option value="Chilakaluripet">Chilakaluripet</option>
				<option value="Chirala">Chirala</option>
				<option value="Cochin">Cochin</option>
				<option value="Delhi">Delhi</option>
				<option value="Devarpalli">Devarpalli</option>
				<option value="Gandhidham">Gandhidham </option>
				<option value="Goa">Goa</option>
				<option value="Gokavaram">Gokavaram</option>
				<option value="Guduru">Guduru</option>
				<option value="Guntur">Guntur</option>
				<option value="Hubli">Hubli</option>
				<option value="Hyderabad">Hyderabad</option>
				<option value="Indore">Indore </option>
				<option value="Inkollu">Inkollu</option>
				<option value="Jaggampet">Jaggampet</option>
				<option value="Jaipur">Jaipur</option>
				<option value="Jammu">Jammu</option>
				<option value="Jamnagar">Jamnagar </option>
				<option value="Jangareddy Gudem">Jangareddy Gudem</option>
				<option value="Kadapa">Kadapa</option>
				<option value="Kakinada">Kakinada</option>
				<option value="Kaligiri">Kaligiri</option>
				<option value="Karimnagar">Karimnagar</option>
				<option value="Kathipudi">Kathipudi</option>
				<option value="Katra">Katra </option>
				<option value="Kavali">Kavali</option>
				<option value="Kolhapur">Kolhapur </option>
				<option value="Kovvuru">Kovvuru</option>
				<option value="Kurnool">Kurnool</option>
				<option value="Mahabaleshwar">Mahabaleshwar</option>
				<option value="Mahabalipuram">Mahabalipuram </option>
				<option value="Manali">Manali </option>
				<option value="Mangalore">Mangalore </option>
				<option value="MountAbu">MountAbu</option>
				<option value="Mumbai">Mumbai</option>
				<option value="Naidupeta">Naidupeta</option>
				<option value="Narasaraopet">Narasaraopet</option>
				<option value="Nasik">Nasik</option>
				<option value="Nellore">Nellore</option>
				<option value="Ongole">Ongole</option>
				<option value="Palitana">Palitana </option>
				<option value="Pangidi">Pangidi</option>
				<option value="Peddapuram">Peddapuram</option>
				<option value="Ponnur">Ponnur</option>
				<option value="Pune">Pune</option>
				<option value="Railway Koduru">Railway Koduru</option>
				<option value="Raja Nagaram">Raja Nagaram</option>
				<option value="Rajampet">Rajampet</option>
				<option value="Rajamundry">Rajamundry</option>
				<option value="Rajkot">Rajkot</option>
				<option value="Rangampeta">Rangampeta</option>
				<option value="Razole">Razole</option>
				<option value="S.Konda">S.Konda</option>
				<option value="Samarla Kota">Samarla Kota</option>
				<option value="Sathenpalli">Sathenpalli</option>
				<option value="Shiridi">Shiridi</option>
				<option value="Shreenathji">Shreenathji </option>
				<option value="Srikakulam">Srikakulam</option>
				<option value="Srinagar">Srinagar </option>
				<option value="Sullurupeta">Sullurupeta</option>
				<option value="Surat">Surat</option>
				<option value="Tenali">Tenali</option>
				<option value="Thrissur">Thrissur </option>
				<option value="Tiruchirapally">Tiruchirapally </option>
				<option value="Tirupathi">Tirupathi</option>
				<option value="Tuni">Tuni</option>
				<option value="Udaipur">Udaipur</option>
				<option value="Ujjain">Ujjain</option>
				<option value="Ulavapadu">Ulavapadu</option>
				<option value="Vadodara">Vadodara</option>
				<option value="Vetapalem">Vetapalem</option>
				<option value="Vijayanagaram">Vijayanagaram</option>
				<option value="Vijayawada">Vijayawada</option>
				<option value="Vinjamoor">Vinjamoor</option>
				<option value="Vizag">Vizag</option>
				<option value="Warangal">Warangal</option>
			</select>
			</td>
		</tr>
	</table>
	<br><input id="btn" type="submit" value="UPDATE">
</form>

<!-- View hotels -->
<%}else if(((String)request.getParameter("hotel")).equals("View Hotels")){

	String[] part= this.getServletContext().getRealPath(File.separator).replace("\\", "/").split("/.metadata");
	connection=ConnectionFactory.getInstance().getConnection(part[0]+this.getServletContext().getContextPath());
	statement=connection.createStatement();
	
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
<%}
} %>
<br><input id="logout" type="button" value="Logout" onclick="sendAlert();">
</body>
</html>