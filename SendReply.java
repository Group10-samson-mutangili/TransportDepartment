package com.samson;

import java.io.IOException;

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
import java.sql.*;
import java.util.Properties;
/**
 * Servlet implementation class SendReply
 */
@WebServlet("/SendReply")
public class SendReply extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
  
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//get the data from the form
		String toEmail = request.getParameter("email");
		String subject = request.getParameter("subject");
		String message = request.getParameter("message");
		int id = Integer.parseInt(request.getParameter("id"));
		
		
		
		try{
			Connection con = DAOHandler.getConnection();
			//check to ensure that the fields are not empty
			if(toEmail.equals("") || subject.equals("") || message.equals("")){
				request.setAttribute("message1", "Error!! Could not send reply. Some fields are empty.");
				request.getRequestDispatcher("trip_details.jsp").forward(request, response);
			} else {
				
				if(subject.equals("Request Accepted")){
					String query1 = "UPDATE trip_bookings set replied=?, trip_status=? WHERE id=?";
					PreparedStatement stmt1 = con.prepareStatement(query1);
					stmt1.setString(1, "YES");
					stmt1.setString(2, "Accepted");
					stmt1.setInt(3, id);
					stmt1.executeUpdate();
				} else{
					String query2 = "UPDATE trip_bookings set replied=?, trip_status=? WHERE id=?";
					PreparedStatement stmt2 = con.prepareStatement(query2);
					stmt2.setString(1, "YES");
					stmt2.setString(2, "Rejected");
					stmt2.setInt(3, id);
					stmt2.executeUpdate();
				}

			//Email to send from
			String fromEmail = "samsonkimole@gmail.com";
			String username = "samsonkimole@gmail.com";
			String password = "fyhzxflylrzviztl";
			
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
            mailMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));
            
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
            
            request.setAttribute("message", "Response send successfully");
            request.getRequestDispatcher("trip_details.jsp").forward(request, response);
		        
			}
			
		} catch(Exception ex){
			System.out.println(ex);
		}
	}

}
