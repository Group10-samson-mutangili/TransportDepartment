package com.samson;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class AdminPassword
 */
@WebServlet("/AdminPassword")
public class AdminPassword extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		//get the data from the form
		String old_password = request.getParameter("password");
		String new_password = request.getParameter("new_password");
		
		try{
			String old_password1;
			Connection con = DAOHandler.getConnection();
			String query = "SELECT password from users WHERE username=? AND password=?";
			PreparedStatement stmt1 = con.prepareStatement(query);
			stmt1.setString(1, "admin");
			stmt1.setString(2, old_password);
			ResultSet rs1 = stmt1.executeQuery();
			if(rs1.next()){
				
					String query2 = "UPDATE users SET password=? WHERE username=?";
					PreparedStatement stmt2 = con.prepareStatement(query2);
					stmt2.setString(1, new_password);
					stmt2.setString(2, "admin");
					stmt2.executeUpdate();
					
					stmt2.close();
					stmt1.close();
					
					request.setAttribute("success", "Password changed successfully");
					request.getRequestDispatcher("AdminPassword.jsp").forward(request, response);
				
			}
			else{
			request.setAttribute("error", "The old password was wrong");
			request.getRequestDispatcher("AdminPassword.jsp").forward(request, response);
			}
			con.close();
			
			
		}catch(Exception ex){
			System.out.println(ex);
		}
	}

}
