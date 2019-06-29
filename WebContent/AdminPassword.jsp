<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*" %>
<%@ page import="com.samson.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Bookings</title>
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


<style>
	#success{
		display: block;
		background-color: yellow;
	}
</style>

</head>

<body id="page-top">

	
<jsp:include page="dashboardup.jsp"></jsp:include>
	<c:choose>
		<c:when test='${success ne "" }'>
			<p id="success">${success }</p>
		</c:when>
	</c:choose>
	<div>
	<form action="AdminPassword" method = "POST" name="vform" onsubmit="return Validate()">
<div class="container">
	<div class="row">
		
			<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12"></div>
			
			<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
			<div class="jumbotron">'
		     	 <h1 class="text-center">Change password</h1>
		     	 <c:choose>
		     	 	<c:when test='${password_equal ne "" }'>
		     	 		<p style="color: red" class="text-center">${password_equal }</p>
		     	 	</c:when>
		     	 </c:choose>
		     	 <c:choose>
		     	 	<c:when test='${error ne "" }'>
		     	 		<p style="color: red" class="text-center">${error }</p>
		     	 	</c:when>
		     	 </c:choose>
		     	 
				<div class="form-group" id="password_div">
			 		<label for="password">Enter the old password</label>
				 	<input type="password" id="password" class="form-control" name="password" placeholder="Enter old password">
					<div id="password_error"></div>
				</div>	
				<div class="form-group" id="new_password_div">
			 		<label for="new_password">Enter  password</label>
				 	<input type="password" id="new_password" class="form-control" name="new_password" placeholder="Enter new password">
					<div id="new_password_error"></div>
				</div>
				<div class="form-group" id="confirm_new_password_div">
			 		<label for="confirm_new_password">Confirm the password</label>
				 	<input type="password" id="confirm_new_password" class="form-control" name="confirm_new_password" placeholder="Confirm password">
					<div id="confirm_new_password_error"></div>
				</div>	
			
			<div class="pull-right">
				<input type="submit" class="btn btn-success" value="Submit" onclick="return valdate();"></input>
			</div>
			</div>
			<div class="col-md-3"></div>
		</div>
	</div>
</form>
	</div>

		
<jsp:include page="dashboarddown.jsp"></jsp:include>

</body>
</html>

<script language="javascript">
	
	//get the fields
	var password = document.forms['vform']['password'];
	var new_password = document.forms['vform']['new_password'];
	var confirm_new_password = document.forms['vform']['confirm_new_password'];
	
	
	//get the divs to display the error messages
	var password_error = document.getElementById('password_error');
	var new_password_error = document.getElementById('new_password_error');
	var confirm_new_password = document.getElementById('confirm_new_password');
	
	//add eventlisteners to the fields
	password.addEventListener('blur', passwordVerify, true);
	new_password.addEventListener('blur', new_passwordVerify, true);
	confirm_new_password.addEventListener('blur', confirm_new_passwordVerify, true);
	
	function Validate(){
		
		
		if(password.value == "" || password.value == null){
			password.style.border = "1px solid red";
			document.getElementById('password_div').style.color = "red";
			password_error.textContent = "Password is required";
			password.focus();
			return false;
		}
		
		if(new_password.value == "" || new_password.value == null){
			new_password.style.border = "1px solid red";
			document.getElementById('new_password_div').style.color = "red";
			new_password_error.textContent = "New password is required";
			new_password.focus();
			return false;
		}
		
		if(confirm_new_password.value == "" || confirm_new_password.value == null){
			confirm_new_password.style.border = "1px solid red";
			document.getElementById('confirm_new_password_div').style.color = "red";
			confirm_new_password_error.textContent = "Confirm new password";
			confirm_new_password.focus();
			return false;
		}
		
		if(confirm_new_password.value.length < 6){
			confirm_new_password.style.border = "1px solid red";
			document.getElementById('confirm_new_password_div').style.color = "red";
			confirm_new_password_error.textContent = "Password cannot be less than 6 characters!";
			confirm_new_password.focus();
			return false;
		}
		
		if(password.value == new_password.value){
			new_password.style.border = "1px solid red";
			document.getElementById('new_password_div').style.color = "red";
			new_password_error.textContent = "New password cannot be the same as old password";
			new_password.focus();
			return false;
		}
		
		if(new_password.value != confirm_new_password.value ){
			confirm_new_password.style.border = "1px solid red";
			document.getElementById('confirm_new_password_div').style.color = "red";
			confirm_new_password_error.textContent = "The two new passwords do not match";
			confirm_new_password.focus();
			return false;
		}
		
		
		return true;
	}
	
	
	function passwordVerify(){
		if(password.value != "" ){
			password.style.border = "1px solid #5e6e66";
			document.getElementById('password_div').style.color = "#5e6e66";
			password_error.innerHTML = "";
			return true;
		}
	}
	
	function new_passwordVerify(){
		if(new_password.value != "" ){
			new_password.style.border = "1px solid #5e6e66";
			document.getElementById('new_password_div').style.color = "#5e6e66";
			new_password_error.innerHTML = "";
			return true;
		}
	}
	
	function confirm_new_passwordVerify(){
		if(confirm_new_password.value != "" ){
			confirm_new_password.style.border = "1px solid #5e6e66";
			document.getElementById('confirm_new_password_div').style.color = "#5e6e66";
			confirm_new_password_error.innerHTML = "";
			return true;
		}
	}
	
</script>