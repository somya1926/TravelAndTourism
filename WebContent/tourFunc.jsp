<%@page import="java.sql.*,model.*,java.io.File,java.util.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
     <%! PreparedStatement statement=null; 
    	ResultSet resultSetFetch=null;
    	Connection connection=null;
    	int update=-1;%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/theme.css">
<script type="text/javascript" src="scripts/main.js"></script>
<title>Tour Function</title>
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
		
		if(((String)request.getParameter("tourFun")).equals("ADD")){
			String place_1= (String) request.getParameter("tPlace_a1");
			String place_2= (String) request.getParameter("tPlace_a2");
			String place_3= (String) request.getParameter("tPlace_a3");
			
			if(place_1.equals(place_2) || place_1.equals(place_3) || place_2.equals(place_3)){
				%>
				<P align=center><IMG SRC="Images/warning48.png" WIDTH="48" HEIGHT="48" BORDER="0" ALT=""><br>
					<FONT COLOR="#fb8c00" size=5 Face="verdana">All three places must be unique !</FONT>
					<BR>
					<font Face="Comic Sans MS" size=3><A HREF="adminHome.jsp">&lt;&lt; Back</A></font>
				</P>
				<%
			}else{
				statement=connection.prepareStatement(
						"INSERT INTO tourInfo (T_NAME, T_PLACE_1, T_PLACE_2, T_PLACE_3, T_DAYS, T_PRICE) VALUES(?,?,?,?,?,?)");
				statement.setString(1, (String)request.getParameter("tName_a"));
				statement.setString(2, (String)request.getParameter("tPlace_a1"));
				statement.setString(3, (String)request.getParameter("tPlace_a2"));
				statement.setString(4, (String)request.getParameter("tPlace_a3"));
				statement.setInt(5, Integer.parseInt((String)request.getParameter("tDays_a")));
				statement.setInt(6, Integer.parseInt(request.getParameter("tPrice_a")));
				
				try{
					update= statement.executeUpdate();
					
					if(update>0){
						%>
					<P align=center><IMG SRC="Images/correct48.png" WIDTH="48" HEIGHT="48" BORDER="0" ALT=""><br>
						<FONT COLOR="Green" size=5 Face="verdana">Tour Insertion Successful !</FONT>
						<BR>
						<font Face="Comic Sans MS" size=3><A HREF="adminHome.jsp">&lt;&lt; Back</A></font>
					</P>
						<%
					}else{
						%>
						<P align=center><IMG SRC="Images/error48.png" WIDTH="48" HEIGHT="48" BORDER="0" ALT=""><br>
							<FONT COLOR="Red" size=5 Face="verdana">Tour Insertion Unsuccessful !</FONT>
							<BR>
							<font Face="Comic Sans MS" size=3><A HREF="adminHome.jsp">&lt;&lt; Try again</A></font>
						</P>
						<%
					}
					
				}catch(SQLException e){
					e.printStackTrace();
				}finally{
					statement.close();
				}
			}
			
		}else if(((String)request.getParameter("tourFun")).equals("UPDATE")){
			
			String place_1= (String) request.getParameter("tPlace_u1");
			String place_2= (String) request.getParameter("tPlace_u2");
			String place_3= (String) request.getParameter("tPlace_u3");

			if(place_1.equals(place_2) || place_1.equals(place_3) || place_2.equals(place_3)){
				%>
				<P align=center><IMG SRC="Images/warning48.png" WIDTH="48" HEIGHT="48" BORDER="0" ALT=""><br>
					<FONT COLOR="#fb8c00" size=5 Face="verdana">All three places must be unique !</FONT>
					<BR>
					<font Face="Comic Sans MS" size=3><A HREF="adminHome.jsp">&lt;&lt; Back</A></font>
				</P>
				<%
			}else{
			statement=connection.prepareStatement(
					"UPDATE tourInfo SET T_NAME=?, T_PLACE_1=?, T_PLACE_2=?, T_PLACE_3=?, T_DAYS=?,T_PRICE=? WHERE T_ID=?");
			statement.setString(1, (String)request.getParameter("tName_u"));
			statement.setString(2, (String)request.getParameter("tPlace_u1"));
			statement.setString(3, (String)request.getParameter("tPlace_u2"));
			statement.setString(4, (String)request.getParameter("tPlace_u3"));
			statement.setInt(5, Integer.parseInt((String)request.getParameter("tDays_u")));
			statement.setInt(6, Integer.parseInt(request.getParameter("tPrice_u")));
			statement.setInt(7, Integer.parseInt(request.getParameter("TID_U")));
			
			try{
				update= statement.executeUpdate();
				
				if(update>0){
					%>
				<P align=center><IMG SRC="Images/correct48.png" WIDTH="48" HEIGHT="48" BORDER="0" ALT=""><br>
					<FONT COLOR="Green" size=5 Face="verdana">Tour Updation Successful !</FONT>
					<BR>
					<font Face="Comic Sans MS" size=3><A HREF="adminHome.jsp">&lt;&lt; Back</A></font>
				</P>
					<%
				}else{
					%>
					<P align=center><IMG SRC="Images/error48.png" WIDTH="48" HEIGHT="48" BORDER="0" ALT=""><br>
						<FONT COLOR="Red" size=5 Face="verdana">Tour Updation Unsuccessful !</FONT>
						<BR>
						<font Face="Comic Sans MS" size=3><A HREF="adminHome.jsp">&lt;&lt; Back</A></font>
					</P>
					<%
				}
				
			}catch(SQLException e){
				e.printStackTrace();
			}finally{
				statement.close();
			}
			}
			
		}else if(((String)request.getParameter("tourFun")).equals("DELETE")){
			statement=connection.prepareStatement("DELETE FROM tourInfo WHERE T_ID=?");
			statement.setInt(1, Integer.parseInt(request.getParameter("TID_D")));
			
			try{
				update= statement.executeUpdate();
				
				if(update>0){
					%>
				<P align=center><IMG SRC="Images/correct48.png" WIDTH="48" HEIGHT="48" BORDER="0" ALT=""><br>
					<FONT COLOR="Green" size=5 Face="verdana">Tour Deletion Successful !</FONT>
					<BR>
					<font Face="Comic Sans MS" size=3><A HREF="adminHome.jsp">&lt;&lt; Back</A></font>
				</P>
					<%
				}else{
					%>
					<P align=center><IMG SRC="Images/error48.png" WIDTH="48" HEIGHT="48" BORDER="0" ALT=""><br>
						<FONT COLOR="Red" size=5 Face="verdana">Tour Deletion Unsuccessful !</FONT>
						<BR>
						<font Face="Comic Sans MS" size=3><A HREF="adminHome.jsp">&lt;&lt; Back</A></font>
					</P>
					<%
				}
				
			}catch(SQLException e){
				e.printStackTrace();
			}finally{
				statement.close();
			}
		}
	} %>
</body>
</html>