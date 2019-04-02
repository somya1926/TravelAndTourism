<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/theme.css">
<title>Admin Login portal</title>
<style type="text/css">
#home{
		width: 300px;
	    padding: 40px;
	    position: absolute;
	    top:20%;
    	left: 50%;
    	transform: translate(-20%, -70%);
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
<%if(session.getAttribute("name")!=null){
	if((int)session.getAttribute("auth")==1)
		response.sendRedirect("adminHome.jsp");
	else{
		%>
			<P align=center><IMG SRC="Images/warning48.png" WIDTH="48" HEIGHT="48" BORDER="0" ALT=""><br>
			<FONT COLOR="#fb8c00" size=5 Face="verdana">User already logged in !</FONT>
			<BR>
			<font Face="Comic Sans MS" size=3><A HREF="home.html">&lt;&lt; Back</A></font>
		</P>
		<%
	}
}else{%>
	<h1 id="home"><a href="home.html">Home</a></h1>
	<form action="validate" class="f1" method="post">
		<h2>Admin Login Portal</h2>
		<table>
			<tr>
				<td>Email:</td>
				<td><input type="text" name="lEmail"
					pattern="^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$"
					required="required"
					title="Enter a valid emailID !"><br></td>
			</tr>
			<tr>
				<td>Password:</td>
				<td><input type="password" name="lPass"
				required="required" title="Required field !"><br></td>

			</tr>
		</table>
		<input id="login" type="submit" value="Login">
	</form>
	<%} %>
</body>
</html>