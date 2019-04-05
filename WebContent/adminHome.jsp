<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" session="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/theme.css">
<title>Admin Home</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/scripts/main.js"></script>
<style type="text/css">
#home{
		width: 300px;
	    padding: 40px;
	    position: absolute;
	    top:20%;
    	left: 50%;
    	transform: translate(-20%, -105%);
	}
	.f1{
	width: 400px;
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
    	transform: translate(-50%, 700%);
    	font-weight: bold;
    	font-family: sans-serif;
    	font-size: 15px;
	}
	</style>
</head>
<body>
		<%if(!(((String)request.getRequestURI()).contains("/admin/adminHome"))){
			throw new ServletException();
		}%>
		<h1 id="home"><a href="${pageContext.request.contextPath}/home.html">Home</a></h1>
		
		<div class="f1">
		<h2>Hi, ${sessionScope.name}</h2>
		<h2>Welcome to the admin portal !</h2>
		
		<form action="tour" method="post">
		    <input type="submit" name="tour" value="Add Tour">
		    <input type="submit" name="tour" value="Update Tour" >
		    <input type="submit" name="tour" value="Delete Tour" >
		    <input type="submit" name="tour" value="View Tours" >
		</form><br>
		<form action="hotel" method="post">
		    <input type="submit" name="hotel" value="Add Hotel" >
		    <input type="submit" name="hotel" value="Update Hotel" >
		    <input type="submit" name="hotel" value="Delete Hotel" >
		    <input type="submit" name="hotel" value="View Hotels" >
		</form><br>
		<form action="misc" method="post">
			<input type="submit" name="misc" value="Show Bookings">
		    <input type="submit" name="misc" value="Revoke Booking">
		    <input type="submit" name="misc" value="Show Users">
		</form><br>
		
		<input type="button" id="logout" value="Logout" onclick="sendAlert();">
		</div>
</body>
</html>