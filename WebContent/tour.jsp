
<%@page import="java.sql.*,model.*,java.util.*"%>
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
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/theme.css">
<title>Tour Portal</title>
<link rel="shortcut icon" type="image/png" href="${pageContext.request.contextPath}/Images/fabicon.png">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/press.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/scripts/main.js"></script>
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
	width: 320px;
    padding: 40px;

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
	    top:90%;
    	left: 580px;
    	
    	font-weight: bold;
    	font-family: sans-serif;
    	font-size: 15px;
    	color: black;
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
		<%if(!(((String)request.getRequestURI()).contains("/admin/tour"))){
			throw new ServletException();
		}
		
		connection=ConnectionFactory.getInstance().getConnection();
		statement=connection.createStatement();
		statement2=connection.createStatement();%>
		<div id="home">
			<h1><a href="adminHome">Home</a></h1>
			<h2>Hi, ${sessionScope.name}</h2>
		</div>
			
<% if(((String)request.getParameter("tour")).equals("Add Tour")){ 
	resultSetPlace=statement.executeQuery("SELECT T_PLACE FROM hotelInfo");
	
	places.clear();
		while(resultSetPlace.next()){
			places.add(resultSetPlace.getString(1));
		}resultSetPlace.close();%>
<!-- Add tour -->
<form class="f1" action="TourFunc" method="post">
<table>
		<tr>
			<td>Tour ID:</td>
			<td><input NAME="tID_a" type="number" placeholder="Auto generated"></td>
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
				<option value="Select Place" disabled="disabled" selected="selected">Select Place</option>
				<option value="NULL">None</option>
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
				<option value="NULL">None</option>
				<option value="Select Place" disabled="disabled" selected="selected">Select Place</option>
				<%for (String s3 : places){%>
					<option value="<%=s3%>"><%=s3%></option>
				<%} %>
			</select>
			</td>
		</tr>
		<tr>
			<td>Total days:
			<div class="tooltip" >
				<img alt="" style="margin-bottom: -4px;" 
					src="${pageContext.request.contextPath}/Images/info.png" >
						<span style="width: 160px">Not more than 10 days</span>
			</div></td>
			<td><input NAME="tDays_a" type="number" required="required" style="width: 30%"></td>
		</tr>
		<tr>
			<td>Total price:
				<div class="tooltip" >
				<img alt="" style="margin-bottom: -4px" 
					src="${pageContext.request.contextPath}/Images/info.png" >
						<span>minimun ₹10000</span>
			</div>
			</td>
			<td><input NAME="tPrice_a" type="number" required="required" style="width: 50%"></td>
		</tr>
	</table>
	<br><input id="btn" class="press press-cyan press-teal press-raised press-round"
		type="submit" name="tourFun" value="ADD">
</form>
<%}else  if(((String)request.getParameter("tour")).equals("Delete Tour")){
resultSetTID=statement.executeQuery("SELECT T_ID FROM tourInfo");
	
	tid.clear();
		while(resultSetTID.next()){
			tid.add(resultSetTID.getInt(1));
		}resultSetTID.close();%>
<!-- Delete tour -->
<form action="TourFunc" class="f1" method="post">
	Tour Id : <SELECT id="TID_d" NAME="TID_D" required="required">
				<option value="Select-ID" disabled="disabled" selected="selected">Select ID</option>
				<%for (int i2 : tid){%>
					<option value="<%=i2%>">t<%=i2%></option>
				<%} %>
			</select><br>
			<a href="#" 
				onclick="openPopup('overview',document.getElementById('TID_d').value,'TD');">overview</a>
				<br><br>
	<input id="btn" class="press press-cyan press-teal press-raised press-round"
		type="submit" name="tourFun" value="DELETE">
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
<form class="f1" action="TourFunc" method="post">
<table>
		<tr>
			<td>Tour ID:</td>
			<td>
			<select id="TID_u" NAME="TID_U" required="required">
				<option value="Select-ID" disabled="disabled" selected="selected">Select ID</option>
				<%for (int i4 : tid){%>
					<option value="<%=i4%>">t<%=i4%></option>
				<%} %>
			</select><br>
			<a href="#" 
				onclick="openPopup('overview',document.getElementById('TID_u').value,'TU');">overview</a>
			</td>
		</tr>
		<tr>
			<td>Tour Name:</td>
			<td><input NAME="tName_u" type="text" required="required"></td>
		</tr>
		<tr>
			<td>Tour Place 1:</td>
			<td>
			<SELECT NAME="tPlace_u1" title="Must be different from 2 and 3" required="required">
				<option value="Select Place" disabled="disabled" selected="selected" >Select Place</option>
				<%for (String s1 : places){%>
					<option value="<%=s1%>"><%=s1%></option>
				<%} %>
			</select>
			</td>
		</tr>
		<tr>
			<td>Tour Place 2:</td>
			<td>
			<SELECT NAME="tPlace_u2" title="Must be different from 1 and 3" required="required">
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
			<SELECT NAME="tPlace_u3" title="Must be different from 1 and 2" required="required">
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
			<td>Total days:
			<div class="tooltip" >
				<img alt="" style="margin-bottom: -4px" 
					src="${pageContext.request.contextPath}/Images/info.png" >
						<span style="width: 160px">Not more than 10 days</span>
			</div>
			</td>
			<td><input type="number" name="tDays_u" required="required" style="width: 30%"></td>
		</tr>
		<tr>
			<td>Total price:
			<div class="tooltip" >
				<img alt="" style="margin-bottom: -4px" 
					src="${pageContext.request.contextPath}/Images/info.png" >
						<span>minimun ₹10000</span>
			</div>
			</td>
			<td><input type="number" NAME="tPrice_u" required="required" style="width: 50%"></td>
		</tr>
	</table>
	<br><input id="btn" class="press press-cyan press-teal press-raised press-round"
		type="submit" name="tourFun" value="UPDATE">
</form>

<!-- View tours -->
<%}else if(((String)request.getParameter("tour")).equals("View Tours")){ 
	resultSetFetch=statement.executeQuery("SELECT * FROM tourInfo");%>
	
	<div class="f1" style="overflow: auto;height: 35%; width: 48%;">
	<table id="t1">
			<tr>
				<th>T_ID</th>
				<th>T_NAME</th>
				<th>T_PLACE_1</th>
				<th>T_PLACE_2</th>
				<th>T_PLACE_3</th>
				<th>T_DAYS</th>
				<th>T_PRICE</th>
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
	<br><input id="logout" class="press press-green press-pill press-ghost"
		type="button" value="Logout" onclick="sendAlert();">
	</body>
</html>