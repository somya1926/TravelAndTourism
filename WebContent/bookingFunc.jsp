<%@page import="org.sqlite.SQLiteException"%>
<%@page import="java.sql.*,model.*,java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="true"%>
    <%! PreparedStatement statement=null;
    	ResultSet resultSetFetch=null;
    	Connection connection=null;
    	int update=-1;%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Booking Now...</title>
<link rel="stylesheet" type="text/css" href="css/theme.css">
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
	},
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
		connection=ConnectionFactory.getInstance().getConnection();%>
	
	<%if(((String)request.getParameter("uBooking")).equals("Book Now")){
		statement=connection.prepareStatement("INSERT INTO bookingInfo (B_DATE, T_ID, T_DATE, U_EMAIL, PERSONS, R_TYPE, T_AMOUNT)"+
				" VALUES((SELECT date('now')),?,?,?,?,?,(SELECT T_PRICE FROM tourInfo WHERE T_ID=?)"+
						"+(SELECT T_PRICE FROM tourInfo WHERE T_ID=?)*0.18)");
		
		statement.setInt(1, Integer.parseInt((String)request.getParameter("bID_a")));
		statement.setString(2, (String)request.getParameter("tDate"));
		statement.setString(3, (String) session.getAttribute("email"));
		statement.setInt(4, Integer.parseInt((String)request.getParameter("pNo")));
		statement.setString(5, (String)request.getParameter("rType"));
		statement.setInt(6, Integer.parseInt((String)request.getParameter("bID_a")));
		statement.setInt(7, Integer.parseInt((String)request.getParameter("bID_a")));
		
		try{
			update= statement.executeUpdate();
			
			if(update>0){
				%>
			<P align=center><IMG SRC="Images/correct48.png" WIDTH="48" HEIGHT="48" BORDER="0" ALT=""><br>
				<FONT COLOR="Green" size=5 Face="verdana">Booking Successful !</FONT>
				<BR>
				<font Face="Comic Sans MS" size=3><A HREF="userHome.jsp">&lt;&lt; Back</A></font>
			</P>
				<%
			}else{
				%>
				<P align=center><IMG SRC="Images/error48.png" WIDTH="48" HEIGHT="48" BORDER="0" ALT=""><br>
					<FONT COLOR="Red" size=5 Face="verdana">Booking Unsuccessful !</FONT>
					<BR>
					<font Face="Comic Sans MS" size=3><A HREF="userHome.jsp">&lt;&lt; Try again</A></font>
				</P>
				<%
			}
			
		}catch(SQLiteException s){
			s.printStackTrace();
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			statement.close();
		}
		
	}else if(((String)request.getParameter("uBooking")).equals("CANCEL")){
		statement=connection.prepareStatement("UPDATE bookingInfo SET STATUS=0 WHERE B_ID=?");
		statement.setInt(1, Integer.parseInt((String)request.getParameter("BID_d")));
		
		try{
			update= statement.executeUpdate();
			
			if(update>0){
				%>
			<P align=center><IMG SRC="Images/correct48.png" WIDTH="48" HEIGHT="48" BORDER="0" ALT=""><br>
				<FONT COLOR="Green" size=5 Face="verdana">Cancellation Successful !</FONT>
				<BR>
				<font Face="Comic Sans MS" size=3><A HREF="userHome.jsp">&lt;&lt; Back</A></font>
			</P>
				<%
			}else{
				%>
				<P align=center><IMG SRC="Images/error48.png" WIDTH="48" HEIGHT="48" BORDER="0" ALT=""><br>
					<FONT COLOR="Red" size=5 Face="verdana">Cancellation Unsuccessful !</FONT>
					<BR>
					<font Face="Comic Sans MS" size=3><A HREF="userHome.jsp">&lt;&lt; Try again</A></font>
				</P>
				<%
			}
			
		}catch(SQLiteException s){
			s.printStackTrace();
		}catch(SQLException e){
			e.printStackTrace();
		}
		
	}else if(((String)request.getParameter("uBooking")).equals("VIEW REPORT")){
		statement=connection.prepareStatement("SELECT b.B_ID, b.B_DATE, b.U_EMAIL, t.T_NAME, t.T_PLACE_1, t.T_PLACE_2,"+
				"T_PLACE_3, t.T_DAYS, b.PERSONS, b.R_TYPE, b.T_AMOUNT FROM "+
				"bookingInfo b INNER JOIN tourInfo t on b.T_ID = t.T_ID WHERE b.B_ID=?");
	
		statement.setInt(1, Integer.parseInt((String)request.getParameter("BID_r")));
		resultSetFetch=statement.executeQuery();%>
		<div id="home">
			<h1><a href="userHome.jsp">Home</a></h1>
			<h2>Hi, <%=(String)session.getAttribute("name")%></h2>
		</div>
		<div class="f1" style="overflow: auto;height: 35%; width: 48%;">
	<table id="t2">
			<tr>
				<th>Booking ID:</th>
				<td><%=resultSetFetch.getInt(1)%></td>
			</tr>
			<tr>
				<th>Booking Date:</th>
				<td><%=resultSetFetch.getString(2)%></td>
			</tr>
			<tr>
				<th>Email:</th>
				<td><%=resultSetFetch.getString(3)%></td>
			</tr>
			<tr>
				<td><hr></td>
				<td><hr></td>
			</tr>
			<tr>
				<th>Package Name:</th>
				<td><%=resultSetFetch.getString(4)%></td>
			</tr>
			<tr>
				<th>Destination 1:</th>
				<td><%=resultSetFetch.getString(5)%></td>
			</tr>
			<tr>
				<th>Destination 2:</th>
				<td><%=resultSetFetch.getString(6)%></td>
			</tr>
			<tr>
				<th>Destination 3:</th>
				<td><%=resultSetFetch.getString(7)%></td>
			</tr>
			<tr>
				<th>Total Days:</th>
				<td><%=resultSetFetch.getInt(8)%></td>
			</tr>
			<tr>
				<td><hr></td>
				<td><hr></td>
			</tr>
			<tr>
				<th>No of Persons(Age>3+):</th>
				<td><%=resultSetFetch.getInt(9)%></td>
			</tr>
			<tr>
				<th>Room Type:</th>
				<%if(resultSetFetch.getString(10).equals("DE")) {%>
						<td>DELUXE</td>
					<%}else if(resultSetFetch.getString(10).equals("SU")){ %>
						<td>SUPERIOR</td>
					<%} else if(resultSetFetch.getString(10).equals("ST")){ %>
						<td>STANDARD</td>
					<%} %>
			</tr>
			<tr>
				<td><hr></td>
				<td><hr></td>
			</tr>
			<tr>
				<th>Total Price:</th>
				<td>₹<%=resultSetFetch.getFloat(11)%></td>
			</tr>
		</table>
		</div>
		
	<%}
	} %>
</body>
</html>