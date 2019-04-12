<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" session="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/theme.css">
<title>User Home</title>
<link rel="shortcut icon" type="image/png" href="${pageContext.request.contextPath}/Images/fabicon.png">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/press.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/scripts/main.js"></script>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/dialog-mobile.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/scripts/mcx-dialog.js"></script>

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
    padding-right: 140px;
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
	    top:35%;
    	left: 50%;
    	transform: translate(-50%, 500%);
    	font-weight: bold;
    	font-family: sans-serif;
    	font-size: 15px;
	}
	th,td{
		padding: 5px;
	}
	input[type=submit], #dereg {
   		height: 2.5em;
   		font-weight: bold;
    	font-family: sans-serif;
	}
	h2{
		transform: translate(50px, 0px);
	}
	</style>
</head>
<body>
		<%if(!(((String)request.getRequestURI()).contains("/user/userHome"))){
			throw new ServletException();
		}%>
		
		<a href="${pageContext.request.contextPath}/home.html">
		<img alt="" src="${pageContext.request.contextPath}/Images/banner.png" width="52%" height="22%" 
		style="position: absolute; border-radius: 20px; left: 24%; top: 2%;"></a>
		
		<div class="f1">
		<h2>Hi, ${sessionScope.name}</h2>
		<h2>Welcome to the User portal !</h2>
		
		<form action="booking" method="post" style="width: 130%">
		<table>
			<tr>
				<td><input class="press press-blue press-round press-raised "
					type="submit" name="book" value="Book now"></td>
				<td><input class="press press-pink press-round press-raised "
					type="submit" name="book" value="Booking History"></td>
				<td><input class="press press-lightgreen press-round press-raised "
					type="submit" name="book" value="Booking Report"></td>
			</tr>
			<tr>
				<td><input class="press press-lightgreen press-round press-raised "
					type="submit" name="book" value="View Tours"></td>
				<td><input class="press press-blue press-round press-raised " 
					type="submit" name="book" value="Cancel Booking"></td>
				<td><input id="dereg" class="press press-pink press-round press-raised"
					type="button" name="book" value="De-register" title="Delete your user account."
						onclick="mcxDialog.showBottom({
					         title: 'Are you sure you want to Deregister?',
					         btn: ['Deregister Now'],
					         btnColor: ['#d50000',],
					         cancelText: 'CANCEL',
					         btnClick: function(){
					        	 <%session.setAttribute("de-reg", "true"); %>
					        	 var form = document.createElement('form');
					 		    form.setAttribute('method', 'post');
					 		    form.setAttribute('action', 'UserDeReg');
					 	        document.body.appendChild(form);
					 		    form.submit();
					       }
					  });"></td>
			</tr>
		</table>
			
		</form>
		<input type="button" class="press press-green press-pill press-ghost"
			id="logout" style="color: black;" value="Logout" onclick="sendAlert();">
		</div>
</body>
</html>