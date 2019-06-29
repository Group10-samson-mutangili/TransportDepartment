<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.*" %>
    <%@page import="com.samson.*" %>
    <%@page import="java.time.temporal.ChronoUnit" %>
    <%@page import="java.time.format.DateTimeFormatter" %>
    <%@page import="java.time.LocalDate" %>
    <%@page import="java.util.ArrayList" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Schedule Bus</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">


  <!-- Custom fonts for this template-->
  <link href="dash/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

  <!-- Custom styles for this template-->
  <link href="dash/css/sb-admin-2.min.css" rel="stylesheet">
<link rel="stylesheet" href="css/bootstrap.min.css">
<link href="js/modaljs.js">

<!--This script is used for user to confirm before deletion of a record -->

<style>
*p{
	display: block;
	background-color: yellow;
}

.errorWrap {
    padding: 10px;
    margin: 0 0 20px 0;
    background: #fff;
    border-left: 4px solid #dd3d36;
    -webkit-box-shadow: 0 1px 1px 0 rgba(0,0,0,.1);
    box-shadow: 0 1px 1px 0 rgba(0,0,0,.1);
    color: green;
}
.succWrap{
    padding: 10px;
    margin: 0 0 20px 0;
    background: #fff;
    border-left: 4px solid #5cb85c;
    -webkit-box-shadow: 0 1px 1px 0 rgba(0,0,0,.1);
    box-shadow: 0 1px 1px 0 rgba(0,0,0,.1);
    color: red;
}

</style>
</head>
<body id="page-top">

<jsp:include page="dashboardup.jsp"></jsp:include>


			<%
			
				String query1 = "SELECT * FROM buses";
				
				Connection con = DAOHandler.getConnection();
				
			%>

			<table class="table table-hover table-bordered" align="center" cellpadding="5" cellspacing="5" border="1">
			<h3 style="color: green">Schedule bus</h3><br>
			<c:choose>
				<c:when test='${message ne "" }'>
					<%String message = (String) request.getAttribute("message"); 
						if(message == null){
							
						}else{
					%>
					<div class="succWrap"><strong>ERROR</strong>: ${message } </div>
					<%} %>
				</c:when>
			</c:choose>
			<c:choose>
				<c:when test='${message1 ne "" }'>
				<%String message1 = (String) request.getAttribute("message1");
				if(message1 == null){
				} else{
				%>
					<div class="errorWrap"><strong>SUCCESS</strong>: ${message1 }</div>
					<%} %>
				</c:when>
			</c:choose>
			<thead>
				<tr >
					<th scope="col">S/No</th>
					<th scope="col">Capacity</th>
					<th scope="col">Number Plate</th>
					<th scope="col">Condition</th>
					<th class="text-right">Actions</th>
				</tr>
			</thead>
			
			<%
				try{
					//create a statement
					PreparedStatement stmt1 = con.prepareStatement(query1);
					ResultSet rs = stmt1.executeQuery();
					
					int i=1;
					while(rs.next()){
				
					
			%>
									<tbody>
										<tr>
										<td><%= i++%></td>
										<td><%= rs.getInt("capacity")%></td>
										<td><%= rs.getString("number_plate")%></td>
										<td><%= rs.getString("bus_condition")%></td>
										<td class="text-right">
										<%
										String condition =  rs.getString("bus_condition");
										
										if(condition.equals("Bad")){
										%>
										 <button name="reject"  data-toggle="modal" data-target="#reject_modal<%= rs.getInt("id")%>" class="btn btn-success" style="width:80px;" >Reserve</button>
										<%
										} else{
										%>
										<button name="Reserve"  data-toggle="modal" data-target="#reserve_modal<%= rs.getInt("id")%>" class="btn btn-success" style="width:80px;" >Reserve</button>
										<%
										}
										%>
										</td>
									</tr>
									<div class="container">
					<div class="row">
						<div class="col-xs-12">
							<div class="modal" id="reserve_modal<%= rs.getInt("id")%>" tabindex="-1">
								<div class="modal-dialog">
									<div class="modal-content">
										<div class="modal-header">
											<h4 class="modal-title pull-left">Reserve bus</h4>
											<button class="close" data-dismiss="modal">&times;</button>
										</div>
										<div class="modal-body">
											<form action="FinalReserveBus" method = "POST">
										
											<input type="hidden" name="number_plate" value='<%= rs.getString("number_plate")%>'/>
											<input type="hidden" name="bus_capacity" value='<%= rs.getInt("capacity")%>'></input>
											
											<div class="form-group">
												<label for="reference_no">Select the Trip reference number</label><br>
												<select style="width: 180px;" name="reference_no">
												<%
													String query2 = "SELECT reference_no FROM trip_bookings WHERE( bus_allocated=? and trip_status=?)";
													
													PreparedStatement stmt = con.prepareStatement(query2);
													stmt.setString(1, "No");
													stmt.setString(2, "Accepted");
													ResultSet rs1 = stmt.executeQuery();
													while(rs1.next()){
														
														%>
														<option><%= rs1.getInt("reference_no") %></option>
														
														<%
														
													}
												
												%>
												</select>
											</div>
											
											
											
											
											<div class="modal-footer">
														<button type="button" class="btn btn-danger" data-dismiss="modal">Cancel</button>
														<input type="submit" class="btn btn-success" value="Update"></input>
											</div>
											</form>	
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				
				<div class="container">
					<div class="row">
						<div class="col-xs-12">
							<div class="modal" id="reject_modal<%= rs.getInt("id")%>" tabindex="-1">
								<div class="modal-dialog">
									<div class="modal-content">
										<div class="modal-header">
											<h4 class="modal-title pull-left">Reserve not possible</h4>
											<button class="close" data-dismiss="modal">&times;</button>
										</div>
										<div class="modal-body">
											<p>The bus is in bad condition. It can not be reserved for a trip!!</p>
											<div class="modal-footer">
														<button type="button" class="btn btn-danger" data-dismiss="modal">Ok</button>
											</div>	
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
									</tbody>
									
									<% 
								}
									%>
							
									<% 
								
							
					
					
				
				
				} catch(Exception e){
					e.printStackTrace();
				}
				
			%>

</table>

		</div>
		


		
<jsp:include page="dashboarddown.jsp"></jsp:include>

</body>
</html>