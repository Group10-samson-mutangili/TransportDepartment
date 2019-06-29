package com.samson;
import java.util.Date;
import java.util.Properties;
import java.io.IOException;
import java.util.Random;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class LocalBooking
 */
@WebServlet("/TripBooking")
public class TripBooking extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//get the details from the form
		String destination = request.getParameter("destination");
		String departure_date = request.getParameter("departure_date");
		int trip_days = Integer.parseInt(request.getParameter("trip_days"))	;
		String department = request.getParameter("department");
		String course_title = request.getParameter("course_title");
		String unit_code = request.getParameter("unit_code");
		String unit_title = request.getParameter("unit_title");
		int lecturers = Integer.parseInt(request.getParameter("lecturers"));
		int students = Integer.parseInt(request.getParameter("students"));
		String purpose = request.getParameter("purpose");
		String email = request.getParameter("email");
		
		
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("uuuu-MM-dd");
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String currentDate = dateFormat.format(date);
		
		LocalDate date1 = LocalDate.parse(currentDate, formatter);
		LocalDate date2 = LocalDate.parse(departure_date, formatter);

		//get the difference between the two dates
		long daysBtn = ChronoUnit.DAYS.between(date1, date2);
		System.out.println(daysBtn);           
		
		if(daysBtn < 3){
			//return error to the person doing the booking
			request.setAttribute("date_error", "Booking should be done three days before the date of trip!!");
			request.getRequestDispatcher("book_trip.jsp").forward(request, response);
		} else{
		
		DAOHandler.createTable();
		int ref = reference_no();
		
		DAOHandler tripDao = new DAOHandler();
		tripDao.trip_bookings(ref, destination, departure_date, trip_days, department, course_title, unit_code, unit_title, lecturers, students, purpose, email);
		
		//Email to send from
		String fromEmail = "samsonkimole@gmail.com";
		String username = "samsonkimole@gmail.com";
		String password = "fyhzxflylrzviztl";
		
		String message = "Your trip id is " +ref+ ". You will be notified of the progress";
		String subject = "Request received";
		
		try{
		//we have to modify some properities so that we can be able to send email
        Properties props = System.getProperties();
        
        //configure some properties
        //configure the host
        props.put("mail.smtp.host", "smtp.gmail.com");
        //authenticating the email we have to use
        props.put("mail.smtp.auth", "true");
        //sendind the email via secure socket layer
        props.put("mail.smtp.port", "465");
        
        props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        
        props.put("mail.smtp.socketFactory.port", "465");
        
        props.put("mail.smtp.socketFactory.fallback", "false");
        
        Session mailSession = Session.getDefaultInstance(props, null);
        mailSession.setDebug(true);
        
        //use the java API inorder to send or receive messages
        Message mailMessage = new MimeMessage(mailSession);
        
        mailMessage.setFrom(new InternetAddress(fromEmail));
        //set the recipient
        mailMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(email));
        
        //set the content to be send
        mailMessage.setContent(message, "text/html");
        
        //set the subject
        mailMessage.setSubject(subject);
        mailMessage.saveChanges();
        
        //set a transport instance which will enable us to send messages
        Transport transport = mailSession.getTransport("smtp");
        
        //get a connection
        transport.connect("smtp.gmail.com", username, password);
        
        //send the message
        transport.sendMessage(mailMessage, mailMessage.getAllRecipients());
        
		request.setAttribute("booked_successfully", "Your request has been submitted. Keep checking your email for progress!");
		request.getRequestDispatcher("welcome.jsp").forward(request, response);
		
		
		} catch(Exception ex){
			System.out.println(ex);
		}
		}
	}
	
	public int reference_no(){
		
		Random rand = new Random();
		int ref = 180 + rand.nextInt(1000000);
		
		try{
			Connection con = DAOHandler.getConnection();
			String query1 = "SELECT ref FROM all_trips";
			String query2 = "SELECT ref FROM trip_bookings";
			PreparedStatement stmt = con.prepareStatement(query1);
			ResultSet rs = stmt.executeQuery();
			
			PreparedStatement stmt1 = con.prepareStatement(query2);
			ResultSet rs2 = stmt1.executeQuery();
			if(rs.next()){
				reference_no();
			}
			if(rs2.next()){
				reference_no();
			}
		} catch(Exception ex){
			System.out.println(ex);
		}
		
		return ref;
	
	}
	
}
