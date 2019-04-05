<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" session="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/theme.css">
<title>User Home</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/scripts/main.js"></script>
<style type="text/css">
#home{
		width: 300px;
	    padding: 40px;
	    position: absolute;
	    top:20%;
    	left: 50%;
    	transform: translate(-20%, -50%);
	}
	.f1{
	width: 350px;
    padding: 40px;
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    background: silver;
    text-align: center;

	}
	#logout{
		width: 200px;
	    padding: 10px;
	    position: absolute;
	    top:20%;
    	left: 50%;
    	transform: translate(-50%, 500%);
    	font-weight: bold;
    	font-family: sans-serif;
    	font-size: 15px;
	}
	</style>
</head>
<body>
		
		<h1 id="home"><a href="${pageContext.request.contextPath}/home.html">Home</a></h1>
		
		<div class="f1">
		<h2>Hi, <%=(String)session.getAttribute("name") %></h2>
		<h2>Welcome to the User portal !</h2>
		
		<form action="booking" method="post">
			<input type="submit" name="book" value="Book now">
			<input type="submit" name="book" value="Booking History">
			<input type="submit" name="book" value="Booking Report">
			<br>
			<input type="submit" name="book" value="View Tours">
			<input type="submit" name="book" value="Cancel Booking">
			<input type="submit" name="book" value="De-register" title="Delete your user account.">
		</form>
		<input type="button" id="logout" value="Logout" onclick="sendAlert();">
		</div>
</body>
</html>