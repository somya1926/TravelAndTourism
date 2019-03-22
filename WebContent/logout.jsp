<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" session="true"%>
    <%! int auth=-1; String name=null;%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Logged out</title>
<link rel="stylesheet" type="text/css" href="css/theme.css">
</head>
<body>
	<%
	if(session.getAttribute("name")!=null){
		auth= (int)session.getAttribute("auth");
		name= (String)session.getAttribute("name");
		session.invalidate();
		
		if(auth==0)
			System.out.println("\nLogged out Successfully! [USER: "+name+"]\n");
		else if(auth==1)
			System.out.println("\nLogged out Successfully! [ADMIN: "+name+"]\n");
	}else{
		System.out.println("\nNothing to log out!\n");
	}

	response.sendRedirect("home.html");%>
</body>
</html>