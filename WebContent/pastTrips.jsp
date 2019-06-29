<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*" %>
<%@page import ="com.samson.*" %>
<%@page import ="java.util.Date" %>
<%@page import = "java.text.SimpleDateFormat" %>
<%@page import="java.time.LocalDate" %>
<%@page import="java.time.format.DateTimeFormatter" %>
<%@page import="java.time.temporal.ChronoUnit" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>All Trips</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

  <!-- Custom fonts for this template-->
  <link href="dash/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

  <!-- Custom styles for this template-->
  <link href="dash/css/sb-admin-2.min.css" rel="stylesheet">
<link rel="stylesheet" href="css/bootstrap.min.css">


<style>
	
	*tr[data-href]{
		cursor: pointer;
	}
	
	.delete_message{
		display: block;
		background-color: yellow;		
	}
		
</style>

</head>

<body id="page-top">

	
<jsp:include page="dashboardup.jsp"></jsp:include>

<div class="row">
	<div class="col-md-8">
			<h4 style="color:green" ><font><strong>Past Trips</strong></font></h4>
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
				
				String search = "";
				search = (String)request.getAttribute("search");
				search = request.getParameter("search");
				String query = "SELECT * from scheduled_trips";
				String query2="";
				
				
				
				try{
					Class.forName("com.mysql.jdbc.Driver");
				} catch(Exception e){
					e.printStackTrace();
				}
				
				Statement statement = null;
				ResultSet rs = null;
				
			%>
			
			<%
				try{
					//create a connection
					Connection con = DAOHandler.getConnection();
					//create a statement
					statement = con.createStatement();
					
					rs = statement.executeQuery(query);

					int i= 1;
					
					while(rs.next()){
						
						//get the current date
						Date date1 = new Date();
						SimpleDateFormat dateForm = new SimpleDateFormat("YYYY-MM-dd");
						String dateToday = dateForm.format(date1);
						System.out.println(dateToday);
						
						//get the date from the scheduled trips
						String date_of_trip = rs.getString("date_of_trip");
						DateTimeFormatter formatter = DateTimeFormatter.ofPattern("uuuu-MM-dd");
						LocalDate date2 = LocalDate.parse(dateToday, formatter);
						LocalDate date3 = LocalDate.parse(date_of_trip, formatter);
						
						//get the day between the two dates
						long daysBtn = ChronoUnit.DAYS.between(date3, date2);
						
						if(daysBtn >= 0){
							
							//get all the details of the trip
							int id = rs.getInt("id");
							int reference_no = rs.getInt("reference_no");
							int trip_days = rs.getInt("trip_days");
							String unit_code = rs.getString("unit_code");
							String unit_title = rs.getString("unit_title");
							String trip_date = rs.getString("date_of_trip");
							String bus_assigned = rs.getString("bus_assigned");
							
							//first insert that trip to past trips
							DAOHandler.createTable();
							String query3 = "INSERT INTO past_trips(reference_no, trip_days, unit_code, unit_title, date_of_trip, bus_assigned) VALUES(?,?,?,?,?,?)";
							PreparedStatement stmt3 = con.prepareStatement(query3);
							stmt3.setInt(1, reference_no);
							stmt3.setInt(2, trip_days);
							stmt3.setString(3, unit_code);
							stmt3.setString(4, unit_title);
							stmt3.setString(5, trip_date);
							stmt3.setString(6, bus_assigned);
							
							stmt3.executeUpdate();
							
							//then delete it from scheduled trips
							String query4 = "DELETE FROM scheduled_trips WHERE id = ?";
							PreparedStatement stmt4 = con.prepareStatement(query4);
							stmt4.setInt(1, id);
							stmt4.executeUpdate();
						}
						%>
						

						
						<% 
					}
					
					//query to select past trips
					
					
					if(search == null){
						query2 = "SELECT * FROM past_trips";
					} else{
						query2 = "SELECT * FROM past_trips WHERE reference_no like '%"+search+"%' or trip_days like '%"+search+"%' or unit_code like '%"+search+"%' or unit_title like '%"+search+"%' or date_of_trip like '%"+search+"%' or bus_assigned like '%"+search+"%'";
					}
					PreparedStatement stmt2 = con.prepareStatement(query2);
					ResultSet rs2 = stmt2.executeQuery();
					
					%>
					<c:choose>
						<c:when test='${deleted_successfully ne "" }'>
							<p class="delete_message" style="color: red;">${deleted_successfully }</p>
						</c:when>
					</c:choose>
					<table class="table table-hover table-striped" align="center" >
					<tr>
						
					</tr>
					<thead>
						<tr>
							<th scope="col">S/NO</th>
							<th scope="col">Reference<br>Number</th>
							<th scope="col">Trip days</th>
							<th scope="col">Unit Code</th>
							<th scope="col">Unit Title</th>
							<th scope="col">Date of trip</th>
							<th scope="col">Bus  which<br>had been assigned</th>
						</tr>
					</thead>
					
					<%
					while(rs2.next()){
						%>
						<tbody>	
						<tr data-href='pastTripsDetails.jsp?ref_no=<%= rs2.getInt("reference_no") %>'>	
							<td><%= i++%></td>
							<td><%= rs2.getInt("reference_no") %></td>
							<td><%= rs2.getString("trip_days")%></td>
							<td><%= rs2.getString("unit_code")%></td>
							<td><%= rs2.getString("unit_title")%></td>
							<td><%= rs2.getString("date_of_trip")%></td>
							<td><%= rs2.getString("bus_assigned")%></td>							
						</tr>
						
					</tbody>
						<%
					}
					
				} catch(Exception e){
					e.printStackTrace();
				}
			%>

</table>

<%

	 Connection con = DAOHandler.getConnection();
	PreparedStatement stmt = con.prepareStatement(query2);
	ResultSet rs4 = stmt.executeQuery();
	if(!rs4.next()){
		
		if(search == null){
			%>
			<p style="color: red;" > There are no past trips at the moment</p>
			<%
		} else{
			%>
			<p style="color: red;">There are no results matching your search</p>
			<%
		}
	}
	
%>
 
</div>


 </div>

			</div>
		</div>
	</div>


		
<jsp:include page="dashboarddown.jsp"></jsp:include>

</body>
</html>



<script language="javascript">

// document.addEventListener("DOMContentLoaded", () =>{
// 	const rows = document.querySelectorAll("tr[data-href]");


$(document).ready(function(){
	
	$(document.body).on("click", "tr[data-href]", function(){
		window.location.href = this.dataset.href;
	});
});

	//get the text inputs
	
	var info = document.forms['vform']['information'];
	
	var info_error = document.getElementById("info_error");
	
	//add event listeners
	info.addEventListener('blur', infoVerify, true);
	
	function Validate(){
		//check id there is data in the text area
		if(info.value == ""){
			info.style.border = "1px solid red";
			document.getElementById("info_div").style.color = "red";
			info_error.textContent = "The field is empty.";
			info.focus();
			return false;
		}
		
	}
	
	//event listener function
	function infoVerify(){
		if(info.value !=""){
			info.style.border = "1px solid #5e6e66";
			document.getElementById("info_div").style.color = "#5e6e66";
			info_error.innerHTML = "";
			return true;
		}
	}
</script>