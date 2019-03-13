<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" session="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Logged out</title>
</head>
<body>
	<%
	if(session.getAttribute("name")!=null){
		session.invalidate();
		System.out.println("\nLogged out Successfully!\n");
	}

	response.sendRedirect("adminLogin.html");%>
</body>
</html>