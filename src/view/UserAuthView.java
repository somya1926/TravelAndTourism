package view;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class UserAuthView extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//Setting SQLite DATABASE path
				String[] part= this.getServletContext().getRealPath(File.separator).replace("\\", "/").split("/.metadata");
				req.setAttribute("URI", part[0]+this.getServletContext().getContextPath()+"/database/userAuth.db");
				
				//req.getRequestDispatcher("loginController").forward(req, resp);
	}
	
}
