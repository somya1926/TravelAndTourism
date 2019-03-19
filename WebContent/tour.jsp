
<%@page import="java.sql.*,model.*,java.io.File,java.util.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" session="true"%>
    <%! Statement statement=null; 
    	ResultSet resultSetFetch=null;
    	ResultSet resultSetPlace=null;
    	ResultSet resultSetTID=null;
    	Connection connection=null;
    	List<String> places= new ArrayList<>();
    	List<Integer> tid= new ArrayList<>();%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/theme.css">
<title>Tour Portal</title>
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
	<h2>Hi, <%=(String)session.getAttribute("name")%></h2>

<% if(((String)request.getParameter("tour")).equals("Add Tour")){ 
	resultSetPlace=statement.executeQuery("SELECT T_PLACE FROM hotelInfo");
	
	places.clear();
		while(resultSetPlace.next()){
			places.add(resultSetPlace.getString(1));
		}resultSetPlace.close();%>
<!-- Add tour -->
<form class="f1" action="#" method="post">
<table>
		<tr>
			<td>Tour ID:</td>
			<td><input type="number" required="required"></td>
		</tr>
		<tr>
			<td>Tour Name:</td>
			<td><input type="text" required="required"></td>
		</tr>
		<tr>
			<td>Tour Place 1:</td>
			<td>
			<SELECT NAME="tPlace" required="required" title="Must be different from 2 and 3">
				<option value="Select Place" disabled="disabled" selected="selected">Select Place</option>
				<%for (String s1 : places){%>
					<option value="<%=s1%>"><%=s1%></option>
				<%} %>
			</select>
			</td>
		</tr>
		<tr>
			<td>Tour Place 2:</td>
			<td>
			<SELECT NAME="tPlace" required="required" title="Must be different from 1 and 3">
			<option value="null">None</option>
				<option value="Select Place" disabled="disabled" selected="selected">Select Place</option>
				<%for (String s2 : places){%>
					<option value="<%=s2%>"><%=s2%></option>
				<%} %>
			</select>
			</td>
		</tr>
		<tr>
			<td>Tour Place 3:</td>
			<td>
			<SELECT NAME="tPlace" required="required" title="Must be different from 1 and 2">
				<option value="Select Place" disabled="disabled" selected="selected">Select Place</option>
				<option value="null">None</option>
				<%for (String s3 : places){%>
					<option value="<%=s3%>"><%=s3%></option>
				<%} %>
			</select>
			</td>
		</tr>
		<tr>
			<td>Total days:</td>
			<td><input type="number" required="required"></td>
		</tr>
		<tr>
			<td>Tour date:</td>
			<td><input type="date" required="required"></td>
		</tr>
		<tr>
			<td>Total price:</td>
			<td><input type="number" required="required"></td>
		</tr>
	</table>
	<br><input id="btn" type="submit" value="ADD">
</form>
<%}else  if(((String)request.getParameter("tour")).equals("Delete Tour")){
resultSetTID=statement.executeQuery("SELECT T_ID FROM tourInfo");
	
	tid.clear();
		while(resultSetTID.next()){
			tid.add(resultSetTID.getInt(1));
		}resultSetTID.close();%>
<!-- Delete tour -->
<form action="#" class="f1" method="post">
	Tour Id : <SELECT NAME="TID_D" required="required">
				<option value="Select-ID" disabled="disabled" selected="selected">Select ID</option>
				<%for (int i2 : tid){%>
					<option value="<%=i2%>">t<%=i2%></option>
				<%} %>
			</select><br><br>
	<input id="btn" type="submit" value="DELETE">
</form>
<%}else if(((String)request.getParameter("tour")).equals("Update Tour")){
	resultSetTID=statement.executeQuery("SELECT T_ID FROM tourInfo");
	
	tid.clear();
		while(resultSetTID.next()){
			tid.add(resultSetTID.getInt(1));
		}resultSetTID.close();%>
<!-- Update tour -->
<form class="f1" action="#" method="post">
<table>
		<tr>
			<td>Tour ID:</td>
			<td>
			<SELECT NAME="TID_U" required="required">
				<option value="Select-ID" disabled="disabled" selected="selected">Select ID</option>
				<%for (int i3 : tid){%>
					<option value="<%=i3%>">t<%=i3%></option>
				<%} %>
			</select>
			</td>
		</tr>
		<tr>
			<td>Total days:</td>
			<td><input type="number" required="required"></td>
		</tr>
		<tr>
			<td>Tour date:</td>
			<td><input type="date" required="required"></td>
		</tr>
		<tr>
			<td>Total price:</td>
			<td><input type="number" required="required"></td>
		</tr>
	</table>
	<br><input id="btn" type="submit" value="UPDATE">
</form>

<!-- View tours -->
<%}else if(((String)request.getParameter("tour")).equals("View Tours")){ 
	resultSetFetch=statement.executeQuery("SELECT * FROM tourInfo");%>
	
	<div class="f1" style="overflow: auto;height: 35%; width: 48%;">
	<table>
			<tr>
				<td>T_ID</td>
				<td>T_NAME</td>
				<td>T_PLACE_1</td>
				<td>T_PLACE_2</td>
				<td>T_PLACE_3</td>
				<td>T_DAYS</td>
				<td>T_PRICE</td>
			</tr>
	
	<%while(resultSetFetch.next()){%>
			<tr>
				<td><%=resultSetFetch.getInt(1) %></td>
				<td><%=resultSetFetch.getString(2) %></td>
				<td><%=resultSetFetch.getString(3)%></td>
				<td><%=resultSetFetch.getString(4)%></td>
				<td><%=resultSetFetch.getString(5)%></td>
				<td><%=resultSetFetch.getInt(6)%></td>
				<td><%=resultSetFetch.getInt(7)%></td>
			</tr>
		<%} resultSetFetch.close(); %>
		</table>
		</div>
		
	<%}%>
	<br><input id="logout" type="button" value="Logout" onclick="sendAlert();">
	<%} %>
	</body>
</html>