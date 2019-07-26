package com.samson;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;
/**
 * Servlet implementation class AddDriver
 */
@WebServlet("/AddDriver")
public class AddDriver extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	@SuppressWarnings("static-access")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//get the drivers details
		String firstname = request.getParameter("firstname");
		String lastname = request.getParameter("lastname");
		String emp_id = request.getParameter("emp_id");
		String password = request.getParameter("password");
		
		try{
		//first check if the employee is registered
		DAOHandler dao = new DAOHandler();
		//get database connection
		Connection con = dao.getConnection();
		//create the table if it does not exist		
		dao.createTable();
		
		//the query to check employee in database
		String query1 = "select * from drivers where emp_id = '"+emp_id+"'";
		PreparedStatement stmt = con.prepareStatement(query1);
		ResultSet rs1 = stmt.executeQuery();
		//if there is an employee with the username in the database send error message
		if(rs1.next()){
			
			request.setAttribute("driver_exists","Driver with that employee id is already registered!");
			request.getRequestDispatcher("addDriver.jsp").forward(request, response);
		} else{
			//register the employee
			String query2 = "INSERT INTO drivers(first_name, last_name, emp_id, password) VALUES (?,?,?,?)";
			PreparedStatement stmt2 = con.prepareStatement(query2);
			stmt2.setString(1, firstname);
			stmt2.setString(2, lastname);
			stmt2.setString(3, emp_id);
			stmt2.setString(4, password);
			stmt2.executeUpdate();
			
			request.setAttribute("added_successfully", "Driver has been added successfully");
			request.getRequestDispatcher("addDriver.jsp").forward(request, response);
		}
		
		stmt.close();
		con.close();
		} catch(Exception ex){
			System.out.println(ex);
		} 
	}

}
