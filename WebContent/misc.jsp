<%@page import="java.sql.*,model.*,java.io.File,java.util.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" session="true"%>
    <%! Statement statement=null; 
    	ResultSet resultSetFetch=null;
    	ResultSet resultSetUID=null;
    	ResultSet resultSetUEmail=null;
    	Connection connection=null;
    	List<Integer> uid= new ArrayList<>();
    	List<String> uEmail= new ArrayList<>();%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/theme.css">
<title>Miscellaneous Tasks</title>
<script type="text/javascript" src="scripts/main.js"></script>
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
		transform: translate(45%, 90%);
	}
	#logout{
		width: 200px;
	    padding: 10px;
	    position: absolute;
	    top:20%;
    	left: 50%;
    	transform: translate(-50%, 1000%);
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
	}#reg{
		width: 150px;
    	padding: 10px;
    	font-weight: bold;
    	font-family: sans-serif;
    	font-size: 15px;
	}
	</style>
</head>
<body>
	  <%if(session.getAttribute("name")==null || (int)session.getAttribute("auth")==0){%>
		<P align=center><IMG SRC="Images/error48.png" WIDTH="48" HEIGHT="48" BORDER="0" ALT=""><br>
			<FONT COLOR="Red" size=5 Face="verdana">You are not permitted to Access the Admin Portal !</FONT>
			<BR>
			<font Face="Comic Sans MS" size=3><A HREF="adminLogin.jsp">&lt;&lt; Back</A></font>
		</P>
	<%}else{
		String[] part= this.getServletContext().getRealPath(File.separator).replace("\\", "/").split("/.metadata");
		connection=ConnectionFactory.getInstance().getConnection(part[0]+this.getServletContext().getContextPath());
		statement=connection.createStatement();%>
	<h1 id="home"><a href="adminHome.jsp">Home</a></h1>
	<h2>Hi, <%=(String)session.getAttribute("name") %></h2><br>
	
		<% if(((String)request.getParameter("misc")).equals("Register User")){ %>
		<!-- Register users -->
		
	<form action="#" class="f1" method="post">
		<table>
			<tr>
				<td>Email:</td>
				<td><input type="text" name="email"
						title="Enter a valid Email Address!"
						pattern="^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$"
						required="required">
				</td>

			</tr>
			<tr>
				<td>Password:</td>
				<td><input type="password"
					name="pass"
					required="required"
					title="Required field !">
				</td>
			</tr>
			<tr>
				<td> Confirm Password:</td>
				<td><input type="password"
						name="cPass"
						required="required"
						title="Required field !">
				</td>
			</tr>
			<tr>
				<td>Name:</td>
				<td><input type="text" name="name"
						required="required"
						title="Required field !">
				</td>
			</tr>
			<tr>
				<td>Mobile No:</td>
				<td><input type="text"
						name="phone" 
						pattern="[1-9]{1}[0-9]{9}"
						required="required"
						title="Enter a valid 10 digit Mobile Number !">
				</td>
			<tr>
				<td>Account type:</td>
				<td>
				<SELECT NAME="AUTH" required="required">
					<option value="perm" disabled="disabled" selected="selected">Permission</option>
					<option value="0">User</option>
					<option value="1">Admin</option>
				</select>
				</td>
			</tr>
		</table>
		<br>
		<input type="submit" id="reg" value="Register">
	</form>
		
		<%}else  if(((String)request.getParameter("misc")).equals("Update User")){
		resultSetUID=statement.executeQuery("SELECT U_ID FROM userAccount");
	
		uid.clear();
			while(resultSetUID.next()){
				uid.add(resultSetUID.getInt(1));
			}resultSetUID.close();%>
		<!-- Update Users -->
			<form action="#" class="f1" method="post">
		<table>
			<tr>
				<td>User ID:</td>
				<td>
					<SELECT NAME="UID_U" required="required" title="Must be different from 2 and 3">
					<option value="Select Place" disabled="disabled" selected="selected">Select Place</option>
					<%for (int i1 : uid){%>
						<option value="<%=i1%>">u<%=i1%></option>
					<%} %>
					</select>
				</td>
			</tr>
			<tr>
				<td>Email:</td>
				<td><input type="text" name="email"
						title="Enter a valid Email Address!"
						pattern="^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$"
						required="required">
				</td>

			</tr>
			<tr>
				<td>Password:</td>
				<td><input type="password"
						name="pass"
						required="required"
						title="Required field !">
				</td>
			</tr>
			<tr>
				<td>Name:</td>
				<td><input type="text" name="name"
						required="required"
						title="Required field !">
				</td>
			</tr>
			<tr>
				<td>Mobile No:</td>
				<td><input type="text"
						name="phone" 
						pattern="[1-9]{1}[0-9]{9}"
						required="required"
						title="Enter a valid 10 digit Mobile Number !">
				</td>
			<tr>
				<td>Account type:</td>
				<td>
				<SELECT NAME="AUTH" required="required">
					<option value="perm" disabled="disabled" selected="selected">Permission</option>
					<option value="0">User</option>
					<option value="1">Admin</option>
				</select>
				</td>
			</tr>
		</table>
		<br>
		<input type="submit" id="reg" value="Register">
	</form>
		<%}else if(((String)request.getParameter("misc")).equals("Delete User")){
		resultSetUEmail=statement.executeQuery("SELECT U_EMAIL FROM userAccount");
	
		uEmail.clear();
		while(resultSetUEmail.next()){
			uEmail.add(resultSetUEmail.getString(1));
		}resultSetUEmail.close();%>
		<!-- Delete users -->
			<form action="#" class="f1" method="post">
				User Email : <SELECT NAME="UID_D" required="required">
				<option value="select-mail" disabled="disabled" selected="selected">Select Email</option>
				<%for (String s1 : uEmail){%>
					<option value="<%=s1%>"><%=s1%></option>
				<%} %>
			</select><br><br>
		<input id="btn" type="submit" value="DELETE">
	</form>
		<!-- Show Users. -->
		<%}else if(((String)request.getParameter("misc")).equals("Show Users")){
		
		resultSetFetch=statement.executeQuery("SELECT U_ID, U_NAME, U_EMAIL, U_MOB, U_ADMIN FROM userAccount");%>
		
		<div class="f1" style="overflow: auto;height: 39%; width: 39%;">
		<table>
				<tr>
					<td>U_ID</td>
					<td>U_NAME</td>
					<td>U_EMAIL</td>
					<td>U_MOB</td>
					<td>U_ADMIN</td>
				</tr>
		
		<%while(resultSetFetch.next()){%>
				<tr>
					<td><%=resultSetFetch.getInt(1) %></td>
					<td><%=resultSetFetch.getString(2) %></td>
					<td><%=resultSetFetch.getString(3)%></td>
					<td><%=resultSetFetch.getInt(4)%></td>
					<td><%=resultSetFetch.getInt(5)%></td>
				</tr>
			<%} resultSetFetch.close(); %>
			</table>
			</div>
			<p style="font-size: 12px;  width: 600px; padding: 10px; position: absolute; top:75%; left: 30%;font-family: cursive;">
				<mark><b>*NOTE:</b></mark> Administrators are prohibited form acessing the passwords due to privacy concern.
			</p>
		<%} %>
		<br><input id="logout" type="button" value="Logout" onclick="sendAlert();">
	<%} %>
	
</body>
</html>