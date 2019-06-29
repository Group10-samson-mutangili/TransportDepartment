package com.samson;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class FinalReserveBus
 */
@WebServlet("/FinalReserveBus")
public class FinalReserveBus extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//get the details 
		String number_plate = request.getParameter("number_plate");
		int bus_capacity = Integer.parseInt(request.getParameter("bus_capacity"));
		int reference_no = Integer.parseInt(request.getParameter("reference_no"));
		
		try{
			
			String query1 = "SELECT * FROM scheduled_trips where bus_assigned = ?";
			Connection con = DAOHandler.getConnection();
			PreparedStatement stmt1 = con.prepareStatement(query1);
			stmt1.setString(1, number_plate); 
			ResultSet rs1 = stmt1.executeQuery();
			
			ArrayList<Integer> days = new ArrayList<Integer>();
			ArrayList<String> date_of_trip = new ArrayList<String>();
			while(rs1.next()){
				days.add(rs1.getInt("trip_days"));
				date_of_trip.add(rs1.getString("date_of_trip"));
			}
			
			if(days.size() >= 1){
					String query2 = "SELECT * FROM trip_bookings WHERE reference_no=?";
					PreparedStatement stmt2 = con.prepareStatement(query2);
					stmt2.setInt(1,  reference_no);
					ResultSet rs2 = stmt2.executeQuery();
					String departure_date = "";
					if(rs2.next()){
						departure_date = rs2.getString("departure_date");
					}
					
					for(int i =0; i< date_of_trip.size(); i++){
						
						String date_trip = date_of_trip.get(i);
						
						DateTimeFormatter formatter = DateTimeFormatter.ofPattern("uuuu-MM-dd");
						
						LocalDate date1 = LocalDate.parse(date_trip, formatter);
						LocalDate date2 = LocalDate.parse(departure_date, formatter);
		
						//get the difference between the two dates
						long daysBtn = ChronoUnit.DAYS.between(date1, date2);
						
						if(daysBtn>-2 && daysBtn < days.get(i)){
							request.setAttribute("message", "The bus has been scheduled for that date. Please consider another bus!!");
							request.getRequestDispatcher("finalBusScheduling.jsp").forward(request, response);
						}
						System.out.println("days btn are " +daysBtn);
						
					}
			} else{
				
				System.out.println("Am done here!!");
				//create table if it does not exist
				DAOHandler.createTable();
				
				int passengers;
				int buses_capacity = 0;
				
				String query2 = "SELECT * FROM trip_bookings where reference_no='"+reference_no+"'";
				PreparedStatement stmt = con.prepareStatement(query2);
				ResultSet rs = stmt.executeQuery();
				
				PrintWriter out = response.getWriter();
				while(rs.next()){
					int reference_no1 = rs.getInt("reference_no");
					String unit_code = rs.getString("unit_code");
					String unit_title = rs.getString("unit_title");
					String date_of_trip2 = rs.getString("departure_date");
					int trip_days = rs.getInt("trip_days");
					
					//Insert the details of the trip to scheduled trips
					String query3 = "INSERT INTO scheduled_trips(reference_no, trip_days, unit_code, unit_title, date_of_trip, bus_assigned, bus_capacity) VALUES(?,?,?,?,?,?,?)";
					PreparedStatement stmt2 = con.prepareStatement(query3);
					stmt2.setInt(1, reference_no1);
					stmt2.setInt(2, trip_days);
					stmt2.setString(3, unit_code);
					stmt2.setString(4, unit_title);
					stmt2.setString(5, date_of_trip2);
					stmt2.setString(6, number_plate);
					stmt2.setInt(7, bus_capacity);
					
					
					stmt2.executeUpdate();
					
					passengers = rs.getInt("students");
					//select the number of students that have been allocated to buses
					
					String query6 = "SELECT bus_capacity FROM scheduled_trips WHERE reference_no =?";
					PreparedStatement stmt6 = con.prepareStatement(query6);
					stmt6.setInt(1, reference_no);
					ResultSet rs6 = stmt6.executeQuery();
					while(rs6.next()){
						 buses_capacity = buses_capacity + rs6.getInt("bus_capacity");
						 
					}
					
					
					if(passengers > buses_capacity){
											
					} else{
						
						// update that the trip has been assigned a bus
						String query4 = "UPDATE trip_bookings SET bus_allocated=? WHERE reference_no=?";
						PreparedStatement stmt3 = con.prepareStatement(query4);
						stmt3.setString(1, "YES");
						stmt3.setInt(2, reference_no);
						stmt3.executeUpdate();
						
					}
					
					
					
					
						out.println("<script src='https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.11.4/sweetalert2.all.js'></script>");
						out.println("<script src='https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>");
						out.println("<script>");
						out.println("$(document).ready(function(){");
						out.println("swal('', 'The bus has been scheduled successfully', 'success')");
						out.println("});");
						out.println("</script>");
						
						request.setAttribute("message1", "Reserving has been done successfully");
						request.getRequestDispatcher("finalBusScheduling.jsp").forward(request, response);
						
				
					//else{
//						//insert the data to the reserved vehicles
//						String query3 = "INSERT INTO reserved_buses(number_plate, capacity, reserved_date) VALUES(?,?,?)";
//						PreparedStatement stmt3 = con.prepareStatement(query3);
//						stmt3.setString(1, plate_no);
//						stmt3.setInt(2, capacity);
//						stmt3.setString(3, date1);
//						int row = stmt3.executeUpdate();
//						System.out.println(row +" affected");
//					}
				}
			}
			
		} catch(Exception ex){
			System.out.println(ex);
		}
	}

}
