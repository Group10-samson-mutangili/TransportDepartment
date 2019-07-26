package com.samson;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class DeleteReservedBus
 */
@WebServlet("/DeleteReservedBus")
public class DeleteReservedBus extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	
	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        String search = request.getParameter("search");
        
        request.setAttribute("search", search);
        request.getRequestDispatcher("Busses.jsp").forward(request, response);
    }
	
	
	@Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

	@SuppressWarnings("static-access")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//get the id of the bus record you want to delete
				String id = request.getParameter("id");
				//convert the id to integer type
				int id1 = Integer.parseInt(id);
				
				
				try{
					
					DAOHandler dao = new DAOHandler();
					Connection con = dao.getConnection();
					
					//a query for inserting data to the database
					String query1 = "DELETE FROM reserved_buses WHERE id='"+id1+"'";
					
					//prepare a statement
					PreparedStatement st = con.prepareStatement(query1);
					
					
					//execute the query and return the number of rows affected
					int rows = st.executeUpdate();
					
					System.out.println(rows + "affected");
					
					st.close();
					con.close();
					
					response.sendRedirect("reserved_buses.jsp");
				}
				catch(Exception e){
					e.printStackTrace();
				}
	}

}
