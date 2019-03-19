<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/theme.css">
<title>User Login</title>
<style type="text/css">
	#home{
		width: 300px;
	    padding: 40px;
	    position: absolute;
	    top:20%;
    	left: 50%;
    	transform: translate(-20%, -40%);
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
		font-family: sans-serif;
	}
	#login{
		width: 150px;
    	padding: 5px;
    	font-weight: bold;
    	font-family: sans-serif;
    	font-size: 15px;
	}
	</style>
</head>
<body>
<%if(session.getAttribute("name")!=null && (int)session.getAttribute("auth")==0){
	response.sendRedirect("userHome.jsp");
}else{%>
<h1 id="home"><a href="home.html">Home</a></h1>
	<form action="validateUser.jsp" class="f1" method="post">
		<h2>User Login Portal</h2>
		<table>
			<tr>
				<td>Email:</td>
				<td><input type="text" name="userEmail"
					required="required"
					pattern="^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$"
					title="Required field !"><br></td>
				<td></td>
			</tr>
			<tr>
				<td>Password:</td>
				<td><input type="password" name="userPass"
					required="required"
					title="Required field !"><br></td>
				<td></td>
			</tr>
			<tr>
				<td></td>
				<td><br><input id="login" type="submit" value="Login"></td>
				<td></td>
			</tr>
			<tr>
				<td></td>
				<td><a href="userReg.html">Register Now</a></td>
				<td></td>
			</tr>
		</table>
	</form>
	<%} %>
</body>
</html>