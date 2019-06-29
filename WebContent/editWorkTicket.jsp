<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="com.samson.*" %>
<%@page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

	<title>Daily work ticket</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="icon" type="image/png" href="logo.png"/>
	<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="fonts/font-awesome-4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" type="text/css" href="fonts/iconic/css/material-design-iconic-font.min.css">
	<link rel="stylesheet" type="text/css" href="vendor/animate/animate.css">
	<link rel="stylesheet" type="text/css" href="vendor/css-hamburgers/hamburgers.min.css">
	<link rel="stylesheet" type="text/css" href="vendor/animsition/css/animsition.min.css">
	<link rel="stylesheet" type="text/css" href="vendor/select2/select2.min.css">
	<link rel="stylesheet" type="text/css" href="vendor/daterangepicker/daterangepicker.css">
	<link rel="stylesheet" type="text/css" href="css/util.css">
	<link rel="stylesheet" type="text/css" href="css/main.css">	
	
</head>

<body>

<jsp:include page="NavBar.jsp"></jsp:include>

<%
	HttpSession session1 = request.getSession();
	String uname = (String) session1.getAttribute("username");
	
	if(uname == null){
		response.sendRedirect("signIn.jsp");
	}
%>

	<div class="limiter">
		<div class="container-login100" style="background-image: url('background.jpg');">
			<div class="wrap-login100">
				<form class="login100-form validate-form" action="EditWorkTicket" method="POST" name="vform" onsubmit="return Validate()">
									
					<span class="login100-form-title p-b-34 p-t-27">
						Daily Work Ticket
					</span>
					<% 
					
					int id = Integer.parseInt(request.getParameter("id"));
					//get connection to the database
					Connection con = DAOHandler.getConnection();
					String query1 = "SELECT * FROM work_tickets WHERE id=?";
					PreparedStatement stmt1 = con.prepareStatement(query1);
					stmt1.setInt(1, id);
					
					
					ResultSet rs1 = stmt1.executeQuery();
					
					while(rs1.next()){
					
					%>
					
					
					

				<div class="form-group" id="date_filled_div">
				<input type="hidden" name="id" value='<%= rs1.getInt("id") %>'/>
				<input type="hidden" name="number_plate"  value='<%= rs1.getString("number_plate") %>'/>
					<label for="date_filled">Date filled</label>
					<input type="date" id="date_filled" name="date_filled" class="form-control" value='<%= rs1.getString("date_filled") %>'>
					<div id="date_filled_error"></div>
				</div>	
				
			
				<div class="form-group" id="from_div">
					<label for="from">From</label> 
					<input type="Text" name="from" class="form-control" value='<%= rs1.getString("from_place") %>'>
					<div id="from_error"></div>
				</div>
							
				<div class="form-group" id="to_div">
					<label for="to">To</label>
					<input type="text" name="to" class="form-control" value='<%= rs1.getString("to_place") %>'>
					<div id="to_error"></div>
				</div>
				
				<div class="form-group" id="oil_div">
					<label for="oil_drawn">Oil drawn in litres</label>
					<input type="number" name="oil" class="form-control" value='<%= rs1.getInt("oil_drawn") %>'>
					<div id="oil_error"></div>
				</div>	
				
				<div class="form-group" id="fuel_div">
					<label for="fuel">Fuel used in litres</label>
					<input type="number" name="fuel" class="form-control" value='<%= rs1.getInt("fuel") %>'>
					<div id="fuel_error"></div>
				</div>
				
				<div class="form-group" id="cash_receipt_div">
					<label for="cash_receipt">Cash receipt for fuel drawn in cash</label>
					<input type="number" name="cash_receipt" class="form-control" value='<%= rs1.getInt("cash_receipt") %>'>
					<div id="cash_receipt_error"></div>
				</div>
				
				<div class="form-group" id="time_out_div">
					<label for="time_out">Time out</label>
					<input type="time" name="time_out" class="form-control" value='<%= rs1.getString("time_out") %>'>
					<div id="time_out_error"></div>
				</div>
				
				<div class="form-group" id="time_in_div">
					<label for="time_in">Time in</label>
					<input type="time" name="time_in" class="form-control" value='<%= rs1.getString("time_in") %>'>
					<div id="time_in_error"></div>
				</div>
				
				
				
				<div class="form-group" id="speedo_reading_div">
					<label for="speedo_reading">Speedo reading at the end of the journey</label>
					<input type="number" name="speedo_reading" class="form-control" value='<%= rs1.getInt("speedo_reading") %>'>
					<div id="speedo_reading_error"></div>
				</div>
				
				<div class="form-group" id="kilometres_done_div">
					<label for="kilometres_done">Kilometers of journey done</label>
					<input type="number" name="kilometres_done" class="form-control" value='<%= rs1.getInt("kilometres_done") %>'>
					<div id="kilometres_done_error"></div>
				</div>
				
				<div class="form-group" id="defects_div">
					<label for="defects">Defects realized:</label>
					<textArea  name="defects" cols="50" rows="5" class="form-control" value='<%= rs1.getString("defects") %>'></textArea>
					<div id="defects_error"></div>
				</div>
				
					<div class="container-login100-form-btn">
						<input type="submit" class="login100-form-btn" value="Submit">
						</input>
					</div>
				<%
					}
				%>
				</form>
			</div>
		</div>
	</div>
	
	<script src="js/jquery-3.4.1.min.js"></script>
	<script src="vendor/animsition/js/animsition.min.js"></script>
	<script src="vendor/bootstrap/js/popper.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.min.js"></script>
	<script src="vendor/select2/select2.min.js"></script>
	<script src="vendor/daterangepicker/moment.min.js"></script>
	<script src="vendor/daterangepicker/daterangepicker.js"></script>
	<script src="vendor/countdowntime/countdowntime.js"></script>
	<script src="js/main.js"></script>

</body>
</html>

<script language="javascript" >
	//select all  text elements
	
	var date_filled = document.forms['vform']['date_filled'];
	var from = document.forms['vform']['from'];
	var to = document.forms['vform']['to'];
	var oil = document.forms['vform']['oil'];
	var fuel = document.forms['vform']['fuel'];
	var cash_receipt = document.forms['vform']['cash_receipt'];
	var time_out = document.forms['vform']['time_out'];
	var time_in = document.forms['vform']['time_in'];
	var speedo_reading = document.forms['vform']['speedo_reading'];
	var kilometres_done = document.forms['vform']['kilometres_done'];
	var defects = document.forms['vform']['defects'];
	

	//selecting all error display elements
	var date_filled_error = document.getElementById('date_filled_error');
	var from_error = document.getElementById('from_error');
	var to_error = document.getElementById('to_error');
	var oil_error = document.getElementById('oil_error');
	var fuel_error = document.getElementById('fuel_error');
	var cash_receipt_error = document.getElementById('cash_receipt_error');
	var time_out_error = document.getElementById('time_out_error');
	var time_in_error = document.getElementById('time_in_error');
	var speedo_reading_error = document.getElementById('speedo_reading_error');
	var kilometres_done_error = document.getElementById('kilometres_done_error');
	var defects_error = document.getElementById('defects_error');
	
	//setting all event listners
	date_filled.addEventListener('blur', date_filledVerify, true);
	from.addEventListener('blur', fromVerify, true);
	to.addEventListener('blur', toVerify, true);
	oil.addEventListener('blur', oilVerify, true);
	fuel.addEventListener('blur', fuelVerify, true);
	cash_receipt.addEventListener('blur', cash_receiptVerify, true);
	time_out.addEventListener('blur', time_outVerify, true);
	time_in.addEventListener('blur', time_inVerify, true);
	speedo_reading.addEventListener('blur', speedo_readingVerify, true);
	kilometres_done.addEventListener('blur', kilometres_doneVerify, true);
	defects.addEventListener('blur', defectsVerify, true);
	
	//validation function
	function Validate(){
		
		
		if(date_filled.value == ""){
			date_filled.style.border = "1px solid red";
			document.getElementById('date_filled_div').style.color = "red";
			date_filled_error.textContent = "Enter the date";
			date_filled.focus();
			return false;
		}

		if(from.value == ""){
			from.style.border = "1px solid red";
			document.getElementById('from_div').style.color = "red";
			from_error.textContent = "Start point of journey is required";
			from.focus();
			return false;
		}
		
		
		
		if(to.value == ""){
			to.style.border = "1px solid red";
			document.getElementById('to_div').style.color = "red";
			to_error.textContent = "Specify the final destination";
			to.focus();
			return false;
		}
		
		if(oil.value == ""){
			oil.style.border = "1px solid red";
			document.getElementById('oil_div').style.color = "red";
			oil_error.textContent = "Enter oil used";
			oil.focus();
			return false;
		}
		
		if(fuel.value == ""){
			fuel.style.border = "1px solid red";
			document.getElementById('fuel_div').style.color = "red";
			fuel_error.textContent = "Amount of fuel used is required";
			fuel.focus();
			return false;
		}
		
		if(cash_receipt.value == ""){
			cash_receipt.style.border = "1px solid red";
			document.getElementById('cash_receipt_div').style.color = "red";
			cash_receipt_error.textContent = "Specify cash used in fuel";
			cash_receipt.focus();
			return false;
		}
		
		if(time_out.value == ""){
			time_out.style.border = "1px solid red";
			document.getElementById('time_out_div').style.color = "red";
			time_out_error.textContent = "Specify the time out";
			time_out.focus();
			return false;
		}
		
		if(time_in.value == ""){
			time_in.style.border = "1px solid red";
			document.getElementById('time_in_div').style.color = "red";
			time_in_error.textContent = "Specify the time in";
			time_in.focus();
			return false;
		}
		if(speedo_reading.value == ""){
			speedo_reading.style.border = "1px solid red";
			document.getElementById('speedo_reading_div').style.color = "red";
			speedo_reading_error.textContent = "Specify oil is used";
			speedo_reading.focus();
			return false;
		}
		if(kilometres_done.value == ""){
			kilometres_done.style.border = "1px solid red";
			document.getElementById('kilometres_done_div').style.color = "red";
			kilometres_done_error.textContent = "Kilometres covered at the end of the journey is required";
			kilometres_done.focus();
			return false;
		}
		if(defects.value == ""){
			defects.style.border = "1px solid red";
			document.getElementById('defects_div').style.color = "red";
			defects_error.textContent = "Specify the defects. If it does not have write none";
			defects.focus();
			return false;
		}		
	}

	//event handler functions
	function date_filledVerify(){
		if(date_filled.value != ""){
			date_filled.style.border = "1px solid #5e6e66";
			document.getElementById('date_filled_div').style.color = "#5e6e66";
			date_filled_error.innerHTML = "";
			return true;
		}
	}

	function fromVerify(){
		if(from.value != ""){
			from.style.border = "1px solid #5e6e66";
			document.getElementById('from_div').style.color = "#5e6e66";
			from_error.innerHTML = "";
			return true;
		}
	}
	
	
	function toVerify(){
		if(to.value != ""){
			to.style.border = "1px solid #5e6e66";
			document.getElementById('to_div').style.color = "#5e6e66";
			to_error.innerHTML = "";
			return true;
		}
	}
	
	function oilVerify(){
		if(oil.value != ""){
			oil.style.border = "1px solid #5e6e66";
			document.getElementById('oil_div').style.color = "#5e6e66";
			oil_error.innerHTML = "";
			return true;
		}
	}
	
	function fuelVerify(){
		if(fuel.value != ""){
			fuel.style.border = "1px solid #5e6e66";
			document.getElementById('fuel_div').style.color = "#5e6e66";
			fuel_error.innerHTML = "";
			return true;
		}
	}
	
	function cash_receiptVerify(){
		if(cash_receipt.value != ""){
			cash_receipt.style.border = "1px solid #5e6e66";
			document.getElementById('cash_receipt_div').style.color = "#5e6e66";
			cash_receipt_error.innerHTML = "";
			return true;
		}
	}
	
	function time_outVerify(){
		if(time_out.value != ""){
			time_out.style.border = "1px solid #5e6e66";
			document.getElementById('time_out_div').style.color = "#5e6e66";
			time_out_error.innerHTML = "";
			return true;
		}
	}
	
	function time_inVerify(){
		if(time_in.value != ""){
			time_in.style.border = "1px solid #5e6e66";
			document.getElementById('time_in_div').style.color = "#5e6e66";
			time_in_error.innerHTML = "";
			return true;
		}
	}
	
	function speedo_readingVerify(){
		if(speedo_reading.value != ""){
			speedo_reading.style.border = "1px solid #5e6e66";
			document.getElementById('speedo_reading_div').style.color = "#5e6e66";
			speedo_reading_error.innerHTML = "";
			return true;
		}
	}
	
	
	function kilometres_doneVerify(){
		if(kilometres_done.value != ""){
			kilometres_done.style.border = "1px solid #5e6e66";
			document.getElementById('kilometres_done_div').style.color = "#5e6e66";
			kilometres_done_error.innerHTML = "";
			return true;
		}
	}
	
	
	function defectsVerify(){
		if(defects.value != ""){
			defects.style.border = "1px solid #5e6e66";
			document.getElementById('defects_div').style.color = "#5e6e66";
			defects_error.innerHTML = "";
			return true;
		}
	}
</script>