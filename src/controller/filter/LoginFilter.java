package controller.filter;

import java.io.IOException;
import java.sql.*;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.*;

import java.io.File;

/**
 * Servlet Filter implementation class LoginFilter
 */
@WebFilter(
	filterName="login_filter",
	urlPatterns="/validate"
)
public class LoginFilter implements Filter {
	
	boolean validResult=false;
	Connection connection=null;
	String QUERY= "SELECT U_ADMIN, U_NAME,U_EMAIL  FROM userAccount WHERE U_EMAIL=? AND U_PASS=?";
	PreparedStatement statement=null;
	ResultSet resultSet=null;
	HttpSession session=null;

    public LoginFilter() {
    	
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException,
		ServletException {
		session=(HttpSession) ((HttpServletRequest)request).getSession(true);
		
		String[] part= (session.getServletContext().getRealPath(File.separator).replace("\\", "/").split("/.metadata"));
		
		try{
			connection=ConnectionFactory.getInstance().getConnection(
					part[0]+session.getServletContext().getContextPath());
			
			statement= connection.prepareStatement(QUERY);
			statement.setString(1, (String)((HttpServletRequest)request).getParameter("lEmail"));
			statement.setString(2, (String)((HttpServletRequest)request).getParameter("lPass"));
			resultSet=statement.executeQuery();
			
			if(resultSet.next()){
				if(resultSet.getString(3).equals(((HttpServletRequest)request).getParameter("lEmail"))){
					session.setAttribute("auth", resultSet.getInt(1));
					session.setAttribute("name", resultSet.getString(2));
					session.setAttribute("email", resultSet.getString(3));
					validResult=true;
				}
			}
		}catch(SQLException e){
			e.printStackTrace();
		}

		if(validResult){
			validResult=false;
			
				try {
					if(resultSet.getInt(1)==1){
						System.out.println("\nAdmin Logged in : "+resultSet.getString(2)+"\n");
						((HttpServletResponse) response).sendRedirect("adminHome.jsp");
						//chain.doFilter(request, response);
						
					}else if(resultSet.getInt(1)==0){ 
							System.out.println("\nUser Logged in : "+resultSet.getString(2)+"\n");
							((HttpServletResponse) response).sendRedirect("userHome.jsp");
							//chain.doFilter(request, response);
					}
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}else {
				((HttpServletResponse)response).getWriter().
					print("<html><head>\r\n" + 
						"<link rel=\"stylesheet\" type=\"text/css\" href=\"css/theme.css\">\r\n" + 
						"<title>Error Login</title>\r\n" + 
						"</head>\r\n" + 
						"<body>"+
						"<P align=center>"+
						"<IMG SRC=\"Images/error48.png\" WIDTH=\"48\" HEIGHT=\"48\" BORDER=\"0\" ALT=\"\"><br>\r\n" + 
						"<FONT COLOR=\"Red\" size=5 Face=\"verdana\">SORRY! Invalid Email/password please try again</FONT>\r\n" + 
						"<BR>\r\n" + 
						"<font Face=\"Comic Sans MS\" size=3><A HREF=\"home.html\">&lt;&lt; Home</A></font>\r\n" + 
						"</P></body></html>");
			}
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		System.out.print("Login Filter Called !");
	}

}
