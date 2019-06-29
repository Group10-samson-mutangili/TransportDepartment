package com.samson;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class EditWorkTicket
 */
@WebServlet("/EditWorkTicket")
public class EditWorkTicket extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


		//get the data from the from
		int id = Integer.parseInt(request.getParameter("id"));
		String number_plate = request.getParameter("number_plate");
		String date_filled = request.getParameter("date_filled");
		String from = request.getParameter("from");
		String to = request.getParameter("to");
		int oil = Integer.parseInt(request.getParameter("oil"));
		int fuel = Integer.parseInt(request.getParameter("fuel"));
		int cash_receipt = Integer.parseInt(request.getParameter("cash_receipt"));
		String time_out = request.getParameter("time_out");
		String time_in = request.getParameter("time_in");
		int speedo_reading = Integer.parseInt(request.getParameter("speedo_reading"));
		int kilometres_done = Integer.parseInt(request.getParameter("kilometres_done"));
		String defects = request.getParameter("defects");
		
		DAOHandler workTicketDao = new DAOHandler();
		DAOHandler.createTable();
		workTicketDao.update_work_ticket(id, date_filled, from, to, oil, fuel, cash_receipt, time_out, time_in, speedo_reading, kilometres_done, defects);              
		
		
		request.setAttribute("updated_successfully", "Work ticket updated sucessfully");
		request.setAttribute("number_plate", number_plate);
		request.getRequestDispatcher("viewWorkTicket.jsp").forward(request, response);
		
	}

}
