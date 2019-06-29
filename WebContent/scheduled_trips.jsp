<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*" %>
<%@ page import="com.samson.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Scheduled academic trips</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="utf-8">
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




</head>

<body id="page-top">

	
<jsp:include page="dashboardup.jsp"></jsp:include>

<div class="row">
		<div class="col-md-8">
			<h2 style="color:green" ><font><strong>Scheduled trips</strong></font></h2>
		</div>
		<div class="col-md-4 text-right">
			<form class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search" action="" method="get">
            <div class="input-group">
              <input type="text" class="form-control" name="search" placeholder="Search here..." aria-label="Search" aria-describedby="basic-addon2">
              <div class="input-group-append">
                <button class="btn btn-primary" type="button">
                  <i class="fas fa-search fa-sm"></i>
                </button>
              </div>
            </div>
          </form>

		</div>
	</div>
	
	<br>
	<div>
			<%
				DAOHandler.createTable();
				String search = "";
				search = (String)request.getAttribute("search");
				search = request.getParameter("search");
				String query;
				
				if(search != null){
					query = "select * from scheduled_trips where reference_no like '%"+search+"%' or unit_code like '%"+search+"%' or unit_title like '%"+search+"%' or date_of_trip like '%"+search+"%' or bus_assigned like '%"+search+"%'";
				}
				else {
					query = "select * from scheduled_trips";
				}
				
				try{
					Class.forName("com.mysql.jdbc.Driver");
				} catch(Exception e){
					e.printStackTrace();
				}
				
				Connection con = DAOHandler.getConnection();
				Statement statement = null;
				ResultSet rs = null;
				
			%>
			<c:choose>
				<c:when test='${message ne ""}'>
					<p style="color: green; align: text-center;">${message }</p>
				</c:when>
			</c:choose>
			<c:choose>
				<c:when test='${message1 ne ""}'>
					<p style="color: red; align: text-center;">${message1 }</p>
				</c:when>
			</c:choose>

			<table class="table table-hover table-bordered" align="center" >
			<tr>
				
			</tr>
			<thead>
				<tr >
					<th scope="col">S/NO</th>
					<th scope="col">Trip reference<br>Number</th>
					<th scope="col">Trip Days</th>
					<th scope="col">Unit code</th>
					<th scope="col">Unit title</th>
					<th scope="col">Date of trip</th>
					<th scope="col">Bus Assigned</th>
					<th scope="col">Bus capacity</th>
					<th class="text-right">Actions</th>
				</tr>
			</thead>
			
			<%
				try{
					//create a statement
					statement = con.createStatement();
					
					rs = statement.executeQuery(query);
					int i=1;
					while(rs.next()){
						%>
						<tbody>
							<tr>
							<td><%= i++ %></td>
							<td><%= rs.getString("reference_no")%></td>
							<td><%= rs.getInt("trip_days")%></td>
							<td><%= rs.getString("unit_code")%></td>
							<td><%= rs.getString("unit_title")%></td>
							<td><%= rs.getString("date_of_trip")%></td>
							<td><%= rs.getString("bus_assigned")%></td>
							<td><%= rs.getString("bus_capacity")%></td>
							
							<td class="text-right">
								<!--  <button name="edit"  class="btn btn-primary" data-toggle="modal" data-target="#edit_modal" style="width:80px;">Edit</button>-->
								<button name="delete"  data-toggle="modal" data-target="#delete_modal<%= rs.getInt("id")%>" class="btn btn-danger" style="width:80px;" >Delete</button>
							</td>
						</tr>
					
						
	<div class="container">
		<div class="row">
			<div class="col-xs-12">
				<div class="modal modal-danger " id="delete_modal<%= rs.getInt("id")%>" tabindex="-1">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<h4 class="modal-title pull-left">Delete trip details</h4>
								<button class="close" data-dismiss="modal">&times;</button>
							</div>
							<div class="modal-body">
							<form action="DeleteTrip" method="POST">
								<input type="hidden" name="id" value='<%=rs.getInt("id") %>'/>
								<div class="form-group">
									<p>Are you sure you want to delete?</p>
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-danger" data-dismiss="modal">Cancel</button>
									<button type="submit" class="btn btn-warning">Yes, Delete</button>
								</div>
							</form>
									
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
				} catch(Exception e){
					e.printStackTrace();
				}
			%>

</table>
<%
PreparedStatement stmt = con.prepareStatement(query);
rs = stmt.executeQuery();
	if(!rs.next()){
		if(search == null){
	%>
	<p style="color: red;">There are no scheduled trips at the moment.</p>
	
	<%
		} else{
			%>
			<p style="color: red;">There are no search results</p>
			<%
		}
	}
%>	


</div>

		
<jsp:include page="dashboarddown.jsp"></jsp:include>

</body>
</html>

<script language="javascript" >
	//select all  text elements
	var destination = document.forms['vform']['destination'];
	var departure_date= document.forms['vform']['departure_date'];
	var return_date = document.forms['vform']['return_date'];
	var passengers = document.forms['vform']['passengers'];
	var faculty = document.forms['vform']['faculty'];
	var department = document.forms['vform']['department'];

	//selecting all error display elements
	var destination_error = document.getElementById('destination_error');
	var departure_error = document.getElementById('departure_error');
	var return_error = document.getElementById('return_error');
	var passengers_error = document.getElementById('passengers_error');
	var faculty_error = document.getElementById('faculty_error');
	var department_error = document.getElementById('department_error');

	//setting all event listners
	destination.addEventListener('blur', destinationVerify, true);
	departure_date.addEventListener('blur', departureVerify, true);
	return_date.addEventListener('blur', returnVerify, true);
	passengers.addEventListener('blur', passengersVerify, true);
	faculty.addEventListener('blur', facultyVerify, true);
	department.addEventListener('blur', departmentVerify, true);

	function Validate(){
		if(destination.value == ""){
			destination.style.border = "1px solid red";
			document.getElementById('destination_div').style.color = "red";
			destination_error.textContent = " Destination is required";
			destination.focus();
			return false;
		}

		if(departure_date.value == ""){
			departure_date.style.border = "1px solid red";
			document.getElementById('departure_div').style.color = "red";
			departure_error.textContent = "Departure date is required";
			departure_date.focus();
			return false;
		}
		
		if(return_date.value == ""){
			return_date.style.border = "1px solid red";
			document.getElementById('return_div').style.color = "red";
			return_error.textContent = "Return date is required";
			return_date.focus();
			return false;
		}
		
		if(passengers.value == ""){
			passengers.style.border = "1px solid red";
			document.getElementById('passengers_div').style.color = "red";
			passengers_error.textContent = "Number of passengers is required";
			passengers.focus();
			return false;
		}

		if(faculty.value == ""){
			faculty.style.border = "1px solid red";
			document.getElementById('condition_div').style.color = "red";
			faculty_error.textContent = "The faculty is required";
			faculty.focus();
			return false;
		}
		
		if(department.value == ""){
			department.style.border = "1px solid red";
			document.getElementById('department_div').style.color = "red";
			department_error.textContent = "Department is required";
			department.focus();
			return false;
		}
	}

	//event handler functions
	function destinationVerify(){
		if(destination.value != ""){
			destination.style.border = "1px solid #5e6e66";
			document.getElementById('destination_div').style.color = "#5e6e66";
			destination_error.innerHTML = "";
			return true;
		}
	}

	function departureVerify(){
		if(departure_date.value != ""){
			departure_date.style.border = "1px solid #5e6e66";
			document.getElementById('departure_div').style.color = "#5e6e66";
			departure_error.innerHTML = "";
			return true;
		}
	}
	
	function returnVerify(){
		if(return_date.value != ""){
			return_date.style.border = "1px solid #5e6e66";
			document.getElementById('return_div').style.color = "#5e6e66";
			return_error.innerHTML = "";
			return true;
		}
	}
	
	function passengersVerify(){
		if(passengers.value != ""){
			passengers.style.border = "1px solid #5e6e66";
			document.getElementById('passengers_div').style.color = "#5e6e66";
			passengers_error.innerHTML = "";
			return true;
		}
	}
	
	function facultyVerify(){
		if(faculty.value != ""){
			faculty.style.border = "1px solid #5e6e66";
			document.getElementById('faculty_div').style.color = "#5e6e66";
			faculty_error.innerHTML = "";
			return true;
		}
	}
	
	function departmentVerify(){
		if(department.value != ""){
			department.style.border = "1px solid #5e6e66";
			document.getElementById('department_div').style.color = "#5e6e66";
			department_error.innerHTML = "";
			return true;
		}
	}
	
</script>