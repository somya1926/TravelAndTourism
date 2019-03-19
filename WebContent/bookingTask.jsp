<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Booking Now...</title>
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
	To be implemented.....
	<jsp:forward page="payment.jsp"></jsp:forward>
<%} %>
</body>
</html>