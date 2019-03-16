<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" session="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin Home</title>
	<script type="text/javascript">
		function sendAlert(){
			if (confirm("Are you sure you want to logout ?")) {
				location.href='logout.jsp'
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
    	transform: translate(-20%, -105%);
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
	</style>
</head>
<body>
	<%if(session.getAttribute("name")==null || (int)session.getAttribute("auth")==0){%>
		<P align=center><IMG SRC="Images/error48.png" WIDTH="48" HEIGHT="48" BORDER="0" ALT=""><br>
			<FONT COLOR="Red" size=5 Face="verdana">You are not permitted to Access the Admin Portal !</FONT>
			<BR>
			<font Face="Comic Sans MS" size=3><A HREF="adminLogin.html">&lt;&lt; Back</A></font>
		</P>
	<%}else{%>
	<h1 id="home"><a href="home.jsp">Home</a></h1>
	<h1 id="home"><a href="home.jsp">Home</a></h1>
	<div class="f1">
	<h2>Hi, <%=(String)session.getAttribute("name") %></h2><br>
	<h2>Welcome to the admin portal !</h2>
	<table>
		<tr>
			<td><input type="button" value="Add Tour" onclick="location.href='#';"></td>
			<td></td>
			<td><input type="button" value="Delete Tour" onclick="location.href='#';"></td>
		</tr>
		<tr>
			<td><input type="button" value="Update Tour" onclick="location.href='#';"></td>
			<td></td>
			<td><input type="button" value="Add Hotel" onclick="location.href='#';"></td>
		</tr>
		<tr>
			
			<td><input type="button" value="Delete Hotel" onclick="location.href='#';"></td>
			<td></td>
			<td><input type="button" value="Update Hotel" onclick="location.href='#';"></td>
		</tr>
		<tr>
			<td><input type="button" value="Allotment" onclick="location.href='#';"></td>
			<td></td>
			<td><input type="button" value="Logout" onclick="sendAlert();"></td>
		</tr>
	</table>
	</div>
	<%} %>
</body>
</html>