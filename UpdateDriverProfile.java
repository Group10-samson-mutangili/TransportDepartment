package com.samson;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class UpdateDriverProfile
 */
@WebServlet("/UpdateDriverProfile")
public class UpdateDriverProfile extends HttpServlet {
	private static final long serialVersionUID = 1L;
     
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		//get the details of the driver
		int id = Integer.parseInt(request.getParameter("id"));
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		int phone_no = Integer.parseInt(request.getParameter("phone"));
		
		DAOHandler driverDao = new DAOHandler();
		
		driverDao.update_Driver_profile(id, email, password, phone_no);
		
		request.setAttribute("message", "driver");
		
		request.getRequestDispatcher("welcome.jsp").forward(request, response);
		
		
	}

}
