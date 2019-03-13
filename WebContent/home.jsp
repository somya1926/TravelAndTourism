<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.io.File,java.lang.*"%>
    <%! private static final String URI=null; %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Travel and Tour</title>
<style type="text/css">
	.f1{
	width: 300px;
    padding: 40px;
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    background: silver;
    text-align: center;

	},
	h2 {
		font-family: sans-serif;
	}
</style>
</head>
<%
		//Setting SQLite DATABASE path
		String[] part= this.getServletContext().getRealPath(File.separator).replace("\\", "/").split("/.metadata");
		String URL= part[0]+this.getServletContext().getContextPath()+"/database/userAuth.db";
%>
<body>
	<form method="post" class="f1">
	<h2>Welcome to travel and Tour</h2>
	<input type="button" value="User Login" onclick="location.href='userLogin.html';"><br>
	<input type="button" value="admin Login" onclick="location.href='adminLogin.html';">
	</form>
</body>
</html>