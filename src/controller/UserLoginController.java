package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class UserLoginController
 */
@WebServlet("/UserLoginController")
public class UserLoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	HttpSession session =null;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserLoginController() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		session= request.getSession(true);
		
		if(session.getAttribute("name")!=null){
			if((int)session.getAttribute("auth")==0)
				response.sendRedirect("userHome.jsp");
			else{
				response.getWriter().
				print("<html><head>\r\n" + 
					"<link rel=\"stylesheet\" type=\"text/css\" href=\"css/theme.css\">\r\n" + 
					"<title>Not Permitted</title>\r\n" + 
					"</head>\r\n" + 
					"<body>"+
					"<P align=center><IMG SRC=\"Images/warning48.png\" WIDTH=\"48\" HEIGHT=\"48\" BORDER=\"0\" ALT=\"\"><br>\r\n" + 
					"<FONT COLOR=\"#fb8c00\" size=5 Face=\"verdana\">Admin already logged in !</FONT>\r\n" + 
					"<BR>\r\n" + 
					"<font Face=\"Comic Sans MS\" size=3><A HREF=\"home.html\">&lt;&lt; Back</A></font>\r\n" + 
					"</P>"+
					"</body></html>");
			}
		}else{
			response.sendRedirect("userLogin.html");
		}
	}
}
