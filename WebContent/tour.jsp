
<%@page import="java.sql.*,model.*,java.io.File,java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="true"%>
    <%! Statement statement=null;
    	Statement statement2=null;
    	ResultSet resultSetFetch=null;
    	ResultSet resultSetPlace=null;
    	ResultSet resultSetTID=null;
    	Connection connection=null;
    	List<String> places= new ArrayList<>();
    	List<Integer> tid= new ArrayList<>();%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="css/theme.css">
<title>Tour Portal</title>
<script type="text/javascript" src="scripts/main.js"></script>
<style type="text/css">
#home{
		width: 300px;
	    padding: 20px;
	    position: absolute;
	    top:60px;
    	left: 44%;
    	transform: translate(-20%, -60%);
    	align-items: center;
    	text-align: center;
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
	#logout{
		width: 200px;
	    padding: 10px;
	    position: absolute;
	    top:90%;
    	left: 580px;
    	
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
		statement=connection.createStatement();
		statement2=connection.createStatement();%>
		<div id="home">
			<h1><a href="adminHome.jsp">Home</a></h1>
			<h2>Hi, <%=(String)session.getAttribute("name")%></h2>
		</div>
			
<% if(((String)request.getParameter("tour")).equals("Add Tour")){ 
	resultSetPlace=statement.executeQuery("SELECT T_PLACE FROM hotelInfo");
	
	places.clear();
		while(resultSetPlace.next()){
			places.add(resultSetPlace.getString(1));
		}resultSetPlace.close();%>
<!-- Add tour -->
<form class="f1" action="tourFunc.jsp" method="post">
<table>
		<tr>
			<td>Tour ID:</td>
			<td><input NAME="tID_a" type="number" placeholder="Auto genetated"></td>
		</tr>
		<tr>
			<td>Tour Name:</td>
			<td><input NAME="tName_a" type="text" required="required"></td>
		</tr>
		<tr>
			<td>Tour Place 1:</td>
			<td>
			<SELECT NAME="tPlace_a1" required="required" title="Must be different from 2 and 3">
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
			<SELECT NAME="tPlace_a2" required="required" title="Must be different from 1 and 3">
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
			<SELECT NAME="tPlace_a3" required="required" title="Must be different from 1 and 2">
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
			<td><input NAME="tDays_a" type="number" required="required"></td>
		</tr>
		<tr>
			<td>Total price:</td>
			<td><input NAME="tPrice_a" type="number" required="required"></td>
		</tr>
	</table>
	<br><input id="btn" type="submit" name="tourFun" value="ADD">
</form>
<%}else  if(((String)request.getParameter("tour")).equals("Delete Tour")){
resultSetTID=statement.executeQuery("SELECT T_ID FROM tourInfo");
	
	tid.clear();
		while(resultSetTID.next()){
			tid.add(resultSetTID.getInt(1));
		}resultSetTID.close();%>
<!-- Delete tour -->
<form action="tourFunc.jsp" class="f1" method="post">
	Tour Id : <SELECT NAME="TID_D" required="required">
				<option value="Select-ID" disabled="disabled" selected="selected">Select ID</option>
				<%for (int i2 : tid){%>
					<option value="<%=i2%>">t<%=i2%></option>
				<%} %>
			</select><br>
			<input type="submit" value="Overview"><br><br>
	<input id="btn" type="submit" name="tourFun" value="DELETE">
</form>
<%}else if(((String)request.getParameter("tour")).equals("Update Tour")){
	resultSetTID=statement2.executeQuery("SELECT T_ID FROM tourInfo");
	resultSetPlace=statement.executeQuery("SELECT T_PLACE FROM hotelInfo");
	
		places.clear();
		while(resultSetPlace.next()){
			places.add(resultSetPlace.getString(1));
		}
		resultSetPlace.close();
	
		tid.clear();
		while(resultSetTID.next()){
			tid.add(resultSetTID.getInt(1));
		}
		resultSetTID.close();%>
<!-- Update tour -->
<form class="f1" action="tourFunc.jsp" method="post">
<table>
		<tr>
			<td>Tour ID:</td>
			<td>
			<select NAME="TID_U" required="required">
				<option value="Select-ID" disabled="disabled" selected="selected">Select ID</option>
				<%for (int i4 : tid){%>
					<option value="<%=i4%>">t<%=i4%></option>
				<%} %>
			</select><br>
			<input type="submit" value="Overview" >
			</td>
		</tr>
		<tr>
			<td>Tour Name:</td>
			<td><input NAME="tName_u" type="text" required="required"></td>
		</tr>
		<tr>
			<td>Tour Place 1:</td>
			<td>
			<SELECT NAME="tPlace_u1" required="required" title="Must be different from 2 and 3">
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
			<SELECT NAME="tPlace_u2" required="required" title="Must be different from 1 and 3">
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
			<SELECT NAME="tPlace_u3" required="required" title="Must be different from 1 and 2">
				<option value="Select Place" disabled="disabled" selected="selected">Select Place</option>
				<option value="null">None</option>
				<%for (String s3 : places){%>
					<option value="<%=s3%>"><%=s3%></option>
				<%} %>
			</select>
			</td>
		</tr>
		<tr>
		<tr>
			<td>Total days:</td>
			<td><input type="number" name="tDays_u" required="required"></td>
		</tr>
		<tr>
			<td>Total price:</td>
			<td><input type="number" NAME="tPrice_u" required="required"></td>
		</tr>
	</table>
	<br><input id="btn" type="submit" name="tourFun" value="UPDATE">
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