package view.user;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.sql.*;
import model.*;

import org.sqlite.SQLiteException;

/**
 * Servlet implementation class BookingFunc
 */
@WebServlet("/user/BookingFunc")
public class BookingFunc extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	PreparedStatement statement=null;
	ResultSet resultSetFetch=null;
	Connection connection=null;
	int update=-1;
	HttpSession session=null;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BookingFunc() {
        super();
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		session=request.getSession(false);
		connection=ConnectionFactory.getInstance().getConnection();
		if(((String)request.getParameter("uBooking")).equals("Book Now")){
			
			
			try{
				statement=connection.prepareStatement("INSERT INTO bookingInfo (B_DATE, T_ID, T_DATE, U_EMAIL, PERSONS, R_TYPE, T_AMOUNT)"+
						" VALUES((SELECT date('now')),?,?,?,?,?,(SELECT T_PRICE FROM tourInfo WHERE T_ID=?)"+
								"+(SELECT T_PRICE FROM tourInfo WHERE T_ID=?)*0.18)");
				
				statement.setInt(1, Integer.parseInt((String)request.getParameter("bID_a")));
				statement.setString(2, (String)request.getParameter("tDate"));
				statement.setString(3, (String) session.getAttribute("email"));
				statement.setInt(4, Integer.parseInt((String)request.getParameter("pNo")));
				statement.setString(5, (String)request.getParameter("rType"));
				statement.setInt(6, Integer.parseInt((String)request.getParameter("bID_a")));
				statement.setInt(7, Integer.parseInt((String)request.getParameter("bID_a")));
				update= statement.executeUpdate();
				
				if(update>0){
					response.getWriter().
					print("<html><head>\r\n" + 
						"<link rel=\"stylesheet\" type=\"text/css\" href=\"css/theme.css\">\r\n" +
						"<link rel=\"stylesheet\" type=\"text/css\" href=\"css/bookingFunc.css\">\r\n" + 
						"<script type=\"text/javascript\" src=\"scripts/main.js\"></script>"+
						"</head>\r\n" + 
						"<body>"+
						"<P align=center><IMG SRC=\"Images/correct48.png\" WIDTH=\"48\" HEIGHT=\"48\" BORDER=\"0\" ALT=\"\"><br>\r\n" + 
						"<FONT COLOR=\"Green\" size=5 Face=\"verdana\">Booking Successful !</FONT>\r\n" + 
						"<BR>\r\n" + 
						"<font Face=\"Comic Sans MS\" size=3><A HREF=\"userHome\">&lt;&lt; Back</A></font>\r\n" + 
						"</P>"+
						"</body></html>");
				}else {
					response.getWriter().
					print("<html><head>\r\n" + 
						"<link rel=\"stylesheet\" type=\"text/css\" href=\"css/theme.css\">\r\n" +
						"<link rel=\"stylesheet\" type=\"text/css\" href=\"css/bookingFunc.css\">\r\n" + 
						"<script type=\"text/javascript\" src=\"scripts/main.js\"></script>"+
						"</head>\r\n" + 
						"<body>"+
						"<P align=center><IMG SRC=\"Images/error48.png\" WIDTH=\"48\" HEIGHT=\"48\" BORDER=\"0\" ALT=\"\"><br>\r\n" + 
						"<FONT COLOR=\"Red\" size=5 Face=\"verdana\">Booking Unsuccessful !</FONT>\r\n" + 
						"<BR>\r\n" + 
						"<font Face=\"Comic Sans MS\" size=3><A HREF=\"userHome\">&lt;&lt; Try again</A></font>\r\n" + 
						"</P>"+
						"</body></html>");
				}
				
			}catch(SQLiteException s){
				s.printStackTrace();
			}catch(SQLException e){
				e.printStackTrace();
			}finally{
				try {
					statement.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			
		}else if(((String)request.getParameter("uBooking")).equals("CANCEL")){
			
			try{
				statement=connection.prepareStatement("UPDATE bookingInfo SET STATUS=0 WHERE B_ID=?");
				statement.setInt(1, Integer.parseInt((String)request.getParameter("BID_d")));
				update= statement.executeUpdate();
				
				if(update>0){
					response.getWriter().
					print("<html><head>\r\n" + 
						"<link rel=\"stylesheet\" type=\"text/css\" href=\"css/theme.css\">\r\n" + 
						"<link rel=\"stylesheet\" type=\"text/css\" href=\"css/bookingFunc.css\">\r\n" + 
						"<script type=\"text/javascript\" src=\"scripts/main.js\"></script>"+
						"</head>\r\n" + 
						"<body>"+
						"<P align=center><IMG SRC=\"Images/correct48.png\" WIDTH=\"48\" HEIGHT=\"48\" BORDER=\"0\" ALT=\"\"><br>\r\n" + 
						"<FONT COLOR=\"Green\" size=5 Face=\"verdana\">Cancellation Successful !</FONT>\r\n" + 
						"<BR>\r\n" + 
						"<font Face=\"Comic Sans MS\" size=3><A HREF=\"userHome\">&lt;&lt; Back</A></font>\r\n" + 
						"</P>"+
						"</body></html>");
				}else{
					response.getWriter().
					print("<html><head>\r\n" + 
						"<link rel=\"stylesheet\" type=\"text/css\" href=\"css/theme.css\">\r\n" + 
						"<link rel=\"stylesheet\" type=\"text/css\" href=\"css/bookingFunc.css\">\r\n" + 
						"<script type=\"text/javascript\" src=\"scripts/main.js\"></script>"+
						"</head>\r\n" + 
						"<body>"+
						"<P align=center><IMG SRC=\"Images/error48.png\" WIDTH=\"48\" HEIGHT=\"48\" BORDER=\"0\" ALT=\"\"><br>\r\n" + 
						"<FONT COLOR=\"Red\" size=5 Face=\"verdana\">Cancellation Unsuccessful !</FONT>\r\n" + 
						"<BR>\r\n" + 
						"<font Face=\"Comic Sans MS\" size=3><A HREF=\"userHome\">&lt;&lt; Try again</A></font>\r\n" + 
						"</P>"+
						"</body></html>");
				}

			}catch(SQLiteException s){
				s.printStackTrace();
			}catch(SQLException e){
				e.printStackTrace();
			}
			
		}else if(((String)request.getParameter("uBooking")).equals("VIEW REPORT")){
			
			PrintWriter out =response.getWriter();
			try {
			statement=connection.prepareStatement("SELECT b.B_ID, b.B_DATE, b.U_EMAIL, t.T_NAME, t.T_PLACE_1, t.T_PLACE_2,"+
					"T_PLACE_3, t.T_DAYS, b.PERSONS, b.R_TYPE, b.T_AMOUNT FROM "+
					"bookingInfo b INNER JOIN tourInfo t on b.T_ID = t.T_ID WHERE b.B_ID=?");
		
			statement.setInt(1, Integer.parseInt((String)request.getParameter("BID_r")));
			resultSetFetch=statement.executeQuery();
			
			out.
			print("<html><head>\r\n" +
				"<meta charset=\"UTF-8\">"+
				"<link rel=\"stylesheet\" type=\"text/css\" href=\"${pageContext.request.contextPath}/css/theme.css\">\r\n" +
				"<link rel=\"stylesheet\" type=\"text/css\" href=\"${pageContext.request.contextPath}/css/bookingFunc.css\">\r\n" + 
				"<script type=\"text/javascript\" src=\"${pageContext.request.contextPath}/scripts/main.js\"></script>"+
				
				"</head>\r\n" + 
				"<body>"+
					"<div id=\"home\">\r\n" + 
					"		<h1><a href=\"userHome\">Home</a></h1>\r\n" + 
					"		<h2>Hi, "+(String)session.getAttribute("name")+"</h2>\r\n" + 
					"</div>\r\n");
			out.print("<div class=\"f1\" style=\"overflow: auto;height: 35%; width: 48%;\">\r\n" + 
					"	<table id=\"t2\">\r\n" + 
					"			<tr>\r\n" + 
					"				<th>Booking ID:</th>\r\n" + 
					"				<td>"+resultSetFetch.getInt(1)+"</td>\r\n" + 
					"			</tr>\r\n" + 
					"			<tr>\r\n" + 
					"				<th>Booking Date:</th>\r\n" + 
					"				<td>"+resultSetFetch.getString(2)+"</td>\r\n" + 
					"			</tr>\r\n" + 
					"			<tr>\r\n" + 
					"				<th>Email:</th>\r\n" + 
					"				<td>"+resultSetFetch.getString(3)+"</td>\r\n" + 
					"			</tr>\r\n" + 
					"			<tr>\r\n" + 
					"				<td><hr></td>\r\n" + 
					"				<td><hr></td>\r\n" + 
					"			</tr>\r\n" + 
					"			<tr>\r\n" + 
					"				<th>Package Name:</th>\r\n" + 
					"				<td>"+resultSetFetch.getString(4)+"</td>\r\n" + 
					"			</tr>\r\n" + 
					"			<tr>\r\n" + 
					"				<th>Destination 1:</th>\r\n" + 
					"				<td>"+resultSetFetch.getString(5)+"</td>\r\n" + 
					"			</tr>\r\n" + 
					"			<tr>\r\n" + 
					"				<th>Destination 2:</th>\r\n" + 
					"				<td>"+resultSetFetch.getString(6)+"</td>\r\n" + 
					"			</tr>\r\n" + 
					"			<tr>\r\n" + 
					"				<th>Destination 3:</th>\r\n" + 
					"				<td>"+resultSetFetch.getString(7)+"</td>\r\n" + 
					"			</tr>\r\n" + 
					"			<tr>\r\n" + 
					"				<th>Total Days:</th>\r\n" + 
					"				<td>"+resultSetFetch.getInt(8)+"</td>\r\n" + 
					"			</tr>\r\n" + 
					"			<tr>\r\n" + 
					"				<td><hr></td>\r\n" + 
					"				<td><hr></td>\r\n" + 
					"			</tr>\r\n" + 
					"			<tr>\r\n" + 
					"				<th>No of Persons(Age>3+):</th>\r\n" + 
					"				<td>"+resultSetFetch.getInt(9)+"</td>\r\n" + 
					"			</tr>\r\n" + 
					"			<tr>\r\n" + 
					"				<th>Room Type:</th>\r\n");
						if(resultSetFetch.getString(10).equals("DE")) { 
							out.print("<td>DELUXE</td>\n"); 
						}else if(resultSetFetch.getString(10).equals("SU")){ 
							out.print("<td>SUPERIOR</td>\n");
						} else if(resultSetFetch.getString(10).equals("ST")){
							out.print("<td>STANDARD</td>\n");
						}
						
					out.print("</tr>\r\n" + 
					"			<tr>\r\n" + 
					"				<td><hr></td>\r\n" + 
					"				<td><hr></td>\r\n" + 
					"			</tr>\r\n" + 
					"			<tr>\r\n" + 
					"				<th>Total Price:</th>\r\n" + 
					"				<td>₹"+resultSetFetch.getFloat(11)+"</td>\r\n" + 
					"			</tr>\r\n" + 
					"		</table>\r\n" + 
					"		</div></body></html>");
			}catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

}
