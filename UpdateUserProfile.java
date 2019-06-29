package com.samson;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class UpdateProfile
 */
@WebServlet("/UpdateUserProfile")
public class UpdateUserProfile extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//get the details from the form
		int id = Integer.parseInt(request.getParameter("id"));
		String firstname = request.getParameter("firstname");
		String lastname = request.getParameter("lastname");
		String username = request.getParameter("username");
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		
		DAOHandler profileDao = new DAOHandler();
		profileDao.update_user_profile(id, firstname, lastname, username, email, password);
		
		request.setAttribute("updated_profile", "Profile updated successfully");
		request.getRequestDispatcher("editUserProfile.jsp").forward(request, response);
		
		
	}

}
