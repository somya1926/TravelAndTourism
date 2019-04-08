<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" session="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/theme.css">
<title>Admin Home</title>
<link rel="shortcut icon" type="image/png" href="${pageContext.request.contextPath}/Images/fabicon.png">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/press.css">
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
    padding-right:150px;
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    text-align: center;
	}
	#logout{
		width: 200px;
	    padding: 10px;
	    position: absolute;
	    top:30%;
    	left: 50%;
    	transform: translate(-50%, 700%);
    	font-weight: bold;
    	font-family: sans-serif;
    	font-size: 15px;
    	align-content: center;
	}
	th,td{
		padding: 5px;
	}
	.item{
		width: 200px;
		padding: 10px;
		font-weight: bold;
		font-family: fantasy;
	}
	input[type=submit] {
   		height: 2.5em;
   		font-weight: bold;
    	font-family: sans-serif;
	}
	h2{
		transform: translate(60px, 10px);
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
		
		<table>
		<tr>
			<td>
				<form action="tour" method="post">
				<table >
					<tr>
						<td><input class="press press-blue press-round press-raised"
							type="submit" name="tour" value="Add Tour"></td>
						<td><input class="press press-pink press-round press-raised" 
							type="submit" name="tour" value="Update Tour" ></td>
						<td><input class="press press-teal press-round press-raised" 
							type="submit" name="tour" value="Delete Tour" ></td>
						<td><input class="press press-lightgreen press-round press-raised" 
							type="submit" name="tour" value="View Tours" ></td>
					</tr>
				</table> 
				</form>
			</td>
		</tr>
		<tr>
			<td>
				<form action="hotel" method="post">
				<table >
					<tr>
						<td><input class="press press-orange press-round press-raised" 
							type="submit" name="hotel" value="Add Hotel" ></td>
						<td><input class="press press-blue press-round press-raised" 
							type="submit" name="hotel" value="Update Hotel" ></td>
						<td><input class="press press-pink press-round press-raised" 
							type="submit" name="hotel" value="Delete Hotel" ></td>
						<td><input class="press press-teal press-round press-raised" 
							type="submit" name="hotel" value="View Hotels" ></td>
					</tr>
				</table>
				</form>
			</td>
		</tr>
		<tr>
			<td>
				<form action="misc" method="post">
				<table >
					<tr>
						<td><input class="press press-orange press-round press-raised" 
							type="submit" name="misc" value="Show Bookings"></td>
						<td><input class="press press-blue press-round press-raised" 
							type="submit" name="misc" value="Revoke Booking"></td>
						<td><input class="press press-pink press-round press-raised" 
							type="submit" name="misc" value="Show Users"></td>
					</tr>
				</table>
				</form>
			</td>
		</tr>
		</table>
		
		<input type="button" class="press press-green press-pill press-ghost" 
			id="logout" style="color: black;" value="Logout" onclick="sendAlert();">
		</div>
</body>
</html>