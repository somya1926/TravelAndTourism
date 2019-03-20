<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="css/theme.css">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://ajax.aspnetcdn.com/ajax/jquery.ui/1.10.4/themes/hot-sneaks/jquery-ui.css">
<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
<script type="text/javascript" src="scripts/main.js"></script>
<title>Payment Portal</title>
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
    .ui-datepicker-calendar {
    	display: none;
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
<%}else{%>
	<h1 id="home"><a href="userHome.jsp">Home</a></h1>
	<h2>Hi, <%=(String)session.getAttribute("name")%></h2>
	<div class="f1">
		<h4>Net Amount: ₹ 0.000</h4>
		<table>
			<tr>
				<td>Full Name :</td>
				<td><input type="text" placeholder="Card Holder`s Name"></td>
			</tr>
			<tr>
				<td>Card No:</td>
				<td><input type="number"></td>
			</tr>
			<tr>
				<td>Expire Date:</td>
				<td><input type="text" id="expiryDate" placeholder="MM/YY"></td>
			</tr>
			<tr>
				<td>CVV No:</td>
				<td><input type="number"></td>
			</tr>
			<tr>
				<td><input type="submit" value="PAY NOW"></td>
				<td><input type="submit" value="PAY LATER"></td>
			</tr>
		</table>
	</div>
	<br><input id="logout" type="button" value="Logout" onclick="sendAlert();">
<%} %>
</body>
</html>