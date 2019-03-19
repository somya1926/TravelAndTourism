<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Payment Portal</title>
<link rel="stylesheet" type="text/css" href="css/theme.css">
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
<link rel="stylesheet" type="text/css" href="css/theme.css">
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
				<td><input type="date"></td>
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