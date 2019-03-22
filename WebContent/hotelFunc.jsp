<%@page import="org.sqlite.SQLiteException"%>
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
<title>Hotel Function</title>
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
		
		if(((String)request.getParameter("hotelFun")).equals("ADD")){
			
			statement=connection.prepareStatement(
					"INSERT INTO hotelInfo (H_NAME, T_PLACE) VALUES (?,?)");
			statement.setString(1, (String)request.getParameter("hName_a"));
			statement.setString(2, (String)request.getParameter("hPlace_a"));
			
			try{
				update= statement.executeUpdate();
				
				if(update>0){
					%>
				<P align=center><IMG SRC="Images/correct48.png" WIDTH="48" HEIGHT="48" BORDER="0" ALT=""><br>
					<FONT COLOR="Green" size=5 Face="verdana">Hotel Insertion Successful !</FONT>
					<BR>
					<font Face="Comic Sans MS" size=3><A HREF="adminHome.jsp">&lt;&lt; Back</A></font>
				</P>
					<%
				}else{
					%>
					<P align=center><IMG SRC="Images/error48.png" WIDTH="48" HEIGHT="48" BORDER="0" ALT=""><br>
						<FONT COLOR="Red" size=5 Face="verdana">Hotel Insertion Unsuccessful !</FONT>
						<BR>
						<font Face="Comic Sans MS" size=3><A HREF="adminHome.jsp">&lt;&lt; Back</A></font>
					</P>
					<%
				}
				
			}catch(SQLiteException s){
				s.printStackTrace();
				%>
			<P align=center><IMG SRC="Images/error48.png" WIDTH="48" HEIGHT="48" BORDER="0" ALT=""><br>
				<FONT COLOR="Red" size=5 Face="verdana">Tour Place already exists !</FONT>
				<BR>
				<font Face="Comic Sans MS" size=3><A HREF="adminLogin.jsp">&lt;&lt; Back</A></font>
			</P>
				<%
			}catch(SQLException e){
				e.printStackTrace();
			}
	}else if(((String)request.getParameter("hotelFun")).equals("UPDATE")){
		
		String hname=(String)request.getParameter("hName_u");
		String hplace=(String)request.getParameter("hPalce_u");
			
			statement=connection.prepareStatement(
					"UPDATE hotelInfo SET H_NAME=? ,T_PLACE=? WHERE H_ID=?");
			
			statement.setString(1, (String)request.getParameter("hName_u"));
			statement.setString(2, (String)request.getParameter("hPalce_u"));
			statement.setInt(3, Integer.parseInt((String)request.getParameter("hID_u")));
			
			try{
				update= statement.executeUpdate();
				
				if(update>0){
					%>
				<P align=center><IMG SRC="Images/correct48.png" WIDTH="48" HEIGHT="48" BORDER="0" ALT=""><br>
					<FONT COLOR="Green" size=5 Face="verdana">Hotel Updation Successful !</FONT>
					<BR>
					<font Face="Comic Sans MS" size=3><A HREF="adminHome.jsp">&lt;&lt; Back</A></font>
				</P>
					<%
				}else{
					%>
					<P align=center><IMG SRC="Images/error48.png" WIDTH="48" HEIGHT="48" BORDER="0" ALT=""><br>
						<FONT COLOR="Red" size=5 Face="verdana">Hotel Updation Unsuccessful !</FONT>
						<BR>
						<font Face="Comic Sans MS" size=3><A HREF="adminHome.jsp">&lt;&lt; Back</A></font>
					</P>
					<%
				}
				
			}catch(SQLiteException s){
				s.printStackTrace();
				%>
			<P align=center><IMG SRC="Images/error48.png" WIDTH="48" HEIGHT="48" BORDER="0" ALT=""><br>
				<FONT COLOR="Red" size=5 Face="verdana">Tour Place already exists !</FONT>
				<BR>
				<font Face="Comic Sans MS" size=3><A HREF="adminLogin.jsp">&lt;&lt; Back</A></font>
			</P>
				<%
			}catch(SQLException e){
				e.printStackTrace();
			}
		}else if(((String)request.getParameter("hotelFun")).equals("DELETE")){
			
			statement=connection.prepareStatement(
					"DELETE FROM hotelInfo WHERE H_ID=?");
			
			statement.setInt(1, Integer.parseInt((String)request.getParameter("hID_d")));
			
			try{
				update= statement.executeUpdate();
				
				if(update>0){
					%>
				<P align=center><IMG SRC="Images/correct48.png" WIDTH="48" HEIGHT="48" BORDER="0" ALT=""><br>
					<FONT COLOR="Green" size=5 Face="verdana">Hotel Deletion Successful !</FONT>
					<BR>
					<font Face="Comic Sans MS" size=3><A HREF="adminHome.jsp">&lt;&lt; Back</A></font>
				</P>
					<%
				}else{
					%>
					<P align=center><IMG SRC="Images/error48.png" WIDTH="48" HEIGHT="48" BORDER="0" ALT=""><br>
						<FONT COLOR="Red" size=5 Face="verdana">Hotel Deletion Unsuccessful !</FONT>
						<BR>
						<font Face="Comic Sans MS" size=3><A HREF="adminHome.jsp">&lt;&lt; Back</A></font>
					</P>
					<%
				}
			}catch(SQLException e){
				e.printStackTrace();
			}
		}	
	}%>
</body>
</html>