package view.admin;

import java.io.IOException;
import org.sqlite.SQLiteException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;
import model.*;
/**
 * Servlet implementation class HotelFunc
 */
@WebServlet("/HotelFunc")
public class HotelFunc extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	PreparedStatement statement=null; 
	ResultSet resultSetFetch=null;
	Connection connection=null;
	int update=-1;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HotelFunc() {
        super();
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
connection=ConnectionFactory.getInstance().getConnection();
		
		if(((String)request.getParameter("hotelFun")).equals("ADD")){

			try{
				statement=connection.prepareStatement("INSERT INTO hotelInfo (H_NAME, T_PLACE) VALUES (?,?)");
				statement.setString(1, (String)request.getParameter("hName_a"));
				statement.setString(2, (String)request.getParameter("hPlace_a"));
				update= statement.executeUpdate();
				
				if(update>0){
					response.getWriter().
					print("<html><head>\r\n" + 
						"<link rel=\"stylesheet\" type=\"text/css\" href=\"css/theme.css\">\r\n" + 
						"<title>Not Permitted</title>\r\n" + 
						"</head>\r\n" + 
						"<body>"+
						"<P align=center><IMG SRC=\"Images/correct48.png\" WIDTH=\"48\" HEIGHT=\"48\" BORDER=\"0\" ALT=\"\"><br>\r\n" + 
						"<FONT COLOR=\"Green\" size=5 Face=\"verdana\">Hotel Insertion Successful !</FONT>\r\n" + 
						"<BR>\r\n" + 
						"<font Face=\"Comic Sans MS\" size=3><A HREF=\"admin/adminHome\">&lt;&lt; Back</A></font>\r\n" + 
						"</P>"+
						"</body></html>");
				}else{
					response.getWriter().
					print("<html><head>\r\n" + 
						"<link rel=\"stylesheet\" type=\"text/css\" href=\"css/theme.css\">\r\n" + 
						"<title>Not Permitted</title>\r\n" + 
						"</head>\r\n" + 
						"<body>"+
						"<P align=center><IMG SRC=\"Images/error48.png\" WIDTH=\"48\" HEIGHT=\"48\" BORDER=\"0\" ALT=\"\"><br>\r\n" + 
						"<FONT COLOR=\"Red\" size=5 Face=\"verdana\">Hotel Insertion Unsuccessful !</FONT>\r\n" + 
						"<BR>\r\n" + 
						"<font Face=\"Comic Sans MS\" size=3><A HREF=\"admin/adminHome\">&lt;&lt; Back</A></font>\r\n" + 
						"</P>"+
						"</body></html>");
				}
			}catch(SQLiteException s){
				s.printStackTrace();
				
				response.getWriter().
				print("<html><head>\r\n" + 
					"<link rel=\"stylesheet\" type=\"text/css\" href=\"css/theme.css\">\r\n" + 
					"<title>Not Permitted</title>\r\n" + 
					"</head>\r\n" + 
					"<body>"+
					"<P align=center><IMG SRC=\"Images/error48.png\" WIDTH=\"48\" HEIGHT=\"48\" BORDER=\"0\" ALT=\"\"><br>\r\n" + 
					"<FONT COLOR=\"Red\" size=5 Face=\"verdana\">Tour Place already exists !</FONT>\r\n" + 
					"<BR>\r\n" + 
					"<font Face=\"Comic Sans MS\" size=3><A HREF=\"admin/adminHome\">&lt;&lt; Back</A></font>\r\n" + 
					"</P>"+
					"</body></html>");
			}catch(SQLException e){
				e.printStackTrace();
			}
	}else if(((String)request.getParameter("hotelFun")).equals("UPDATE")){
		
			try{
				statement=connection.prepareStatement("UPDATE hotelInfo SET H_NAME=? ,T_PLACE=? WHERE H_ID=?");
				
				statement.setString(1, (String)request.getParameter("hName_u"));
				statement.setString(2, (String)request.getParameter("hPalce_u"));
				statement.setInt(3, Integer.parseInt((String)request.getParameter("hID_u")));
				update= statement.executeUpdate();
				
				if(update>0){
					response.getWriter().
					print("<html><head>\r\n" + 
						"<link rel=\"stylesheet\" type=\"text/css\" href=\"css/theme.css\">\r\n" + 
						"<title>Not Permitted</title>\r\n" + 
						"</head>\r\n" + 
						"<body>"+
						"<P align=center><IMG SRC=\"Images/correct48.png\" WIDTH=\"48\" HEIGHT=\"48\" BORDER=\"0\" ALT=\"\"><br>\r\n" + 
						"<FONT COLOR=\"Green\" size=5 Face=\"verdana\">Hotel Updation Successful !</FONT>\r\n" + 
						"<BR>\r\n" + 
						"<font Face=\"Comic Sans MS\" size=3><A HREF=\"admin/adminHome\">&lt;&lt; Back</A></font>\r\n" + 
						"</P>"+
						"</body></html>");
				}else {
					response.getWriter().
					print("<html><head>\r\n" + 
						"<link rel=\"stylesheet\" type=\"text/css\" href=\"css/theme.css\">\r\n" + 
						"<title>Not Permitted</title>\r\n" + 
						"</head>\r\n" + 
						"<body>"+
						"<P align=center><IMG SRC=\"Images/error48.png\" WIDTH=\"48\" HEIGHT=\"48\" BORDER=\"0\" ALT=\"\"><br>\r\n" + 
						"<FONT COLOR=\"Red\" size=5 Face=\"verdana\">Hotel Updation Unsuccessful !</FONT>\r\n" + 
						"<BR>\r\n" + 
						"<font Face=\"Comic Sans MS\" size=3><A HREF=\"admin/adminHome\">&lt;&lt; Back</A></font>\r\n" + 
						"</P>"+
						"</body></html>");
				}
			}catch(SQLiteException s){
				s.printStackTrace();
				
				response.getWriter().
				print("<html><head>\r\n" + 
					"<link rel=\"stylesheet\" type=\"text/css\" href=\"css/theme.css\">\r\n" + 
					"<title>Not Permitted</title>\r\n" + 
					"</head>\r\n" + 
					"<body>"+
					"<P align=center><IMG SRC=\"Images/error48.png\" WIDTH=\"48\" HEIGHT=\"48\" BORDER=\"0\" ALT=\"\"><br>\r\n" + 
					"<FONT COLOR=\"Red\" size=5 Face=\"verdana\">Tour Place already exists !</FONT>\r\n" + 
					"<BR>\r\n" + 
					"<font Face=\"Comic Sans MS\" size=3><A HREF=\"admin/adminHome\">&lt;&lt; Back</A></font>\r\n" + 
					"</P>"+
					"</body></html>");
			}catch(SQLException e){
				e.printStackTrace();
			}
			
		}else if(((String)request.getParameter("hotelFun")).equals("DELETE")){
			
			try{
				statement=connection.prepareStatement("DELETE FROM hotelInfo WHERE H_ID=?");
				statement.setInt(1, Integer.parseInt((String)request.getParameter("hID_d")));
				update= statement.executeUpdate();
				
				if(update>0){
					response.getWriter().
					print("<html><head>\r\n" + 
						"<link rel=\"stylesheet\" type=\"text/css\" href=\"css/theme.css\">\r\n" + 
						"<title>Not Permitted</title>\r\n" + 
						"</head>\r\n" + 
						"<body>"+
						"<P align=center><IMG SRC=\"Images/correct48.png\" WIDTH=\"48\" HEIGHT=\"48\" BORDER=\"0\" ALT=\"\"><br>\r\n" + 
						"<FONT COLOR=\"Green\" size=5 Face=\"verdana\">Hotel Deletion Successful !</FONT>\r\n" + 
						"<BR>\r\n" + 
						"<font Face=\"Comic Sans MS\" size=3><A HREF=\"admin/adminHome\">&lt;&lt; Back</A></font>\r\n" + 
						"</P>"+
						"</body></html>");
				}else{
					response.getWriter().
					print("<html><head>\r\n" + 
						"<link rel=\"stylesheet\" type=\"text/css\" href=\"css/theme.css\">\r\n" + 
						"<title>Not Permitted</title>\r\n" + 
						"</head>\r\n" + 
						"<body>"+
						"<P align=center><IMG SRC=\"Images/error48.png\" WIDTH=\"48\" HEIGHT=\"48\" BORDER=\"0\" ALT=\"\"><br>\r\n" + 
						"<FONT COLOR=\"Red\" size=5 Face=\"verdana\">Hotel Deletion Unsuccessful !</FONT>\r\n" + 
						"<BR>\r\n" + 
						"<font Face=\"Comic Sans MS\" size=3><A HREF=\"admin/adminHome\">&lt;&lt; Back</A></font>\r\n" + 
						"</P>"+
						"</body></html>");
				}
			}catch(SQLException e){
				e.printStackTrace();
			}
		}
	}
}