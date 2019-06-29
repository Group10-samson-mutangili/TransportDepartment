<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
   <%@page import="java.sql.*" %>
   <%@page import="com.samson.*" %>
   <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Sign Up</title>
<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
<!--===============================================================================================-->	
	<link rel="icon" type="image/png" href="logo.png"/>
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="fonts/iconic/css/material-design-iconic-font.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/animate/animate.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="vendor/css-hamburgers/hamburgers.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/animsition/css/animsition.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/select2/select2.min.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="vendor/daterangepicker/daterangepicker.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="css/util.css">
	<link rel="stylesheet" type="text/css" href="css/main.css">
<!--===============================================================================================-->

<style>
	#profile_div{
	background-color: white;
	width: 100%;
	height: 100%;
	padding: 100px auto;
	}
	
	#user_details{
		margin-left: 100px;
		padding-top: 50px;
		
	}
	
	input{
		background-color: grey;
		width: 350px;
		height: 35px;
	}
	
	label{
		font-size: 20px;
		font-family: Sans-serif;
	}
	
	#update_info{
		dispay: block;
		color: green;
		background-color: yellow;
	}
</style>
</head>
<body>

<jsp:include page="NavBar.jsp"></jsp:include>

<%
	
	HttpSession session1 = request.getSession();
	String username = (String) session1.getAttribute("username");
	
	try{
		Connection con = DAOHandler.getConnection();
		String query = "SELECT * FROM users WHERE username=?";
		PreparedStatement stmt = con.prepareStatement(query);
		stmt.setString(1, username);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()){
			%>	
				
<div id="profile_div">

	<div id="user_details">
	<c:choose>
		<c:when test='${updated_profile ne  "" }'>
			<p id="update_info">${updated_profile }</p>
		</c:when>
	</c:choose>
		<h3>User profile</h3><br>
		<div class="form">
			<form name="vform" action="UpdateUserProfile" method="POST" onsubmit="return Validate()">
				<div id="firstname_div">
					<input type="hidden" name="id" value='<%= rs.getInt("id") %>'/>
					<Label for="firstname">First name</Label>
					<input type="text" name="firstname" value='<%= rs.getString("firstname") %>'><br><br>
					<div id="firstname_error"></div>
				</div>
				<div id="lastname_div">
					<Label for="lastname">Last name</Label>
					<input type="text" name="lastname" value='<%= rs.getString("lastname") %>'><br><br>
					<div id="lastname_error"></div>
				</div>
				<div id="username_div">
					<Label for="username">Username</Label>
					<input type="text" name="username" value='<%= rs.getString("username") %>' readonly><br><br>
					<div id="username_error"></div>
				</div>
				<div id="email_div">
					<Label for="email">Email</Label>
					<input type="email" name="email" value='<%= rs.getString("email") %>'><br><br>
					<div id="email_error"></div>
				</div>
				<div id="password_div">
					<Label for="passoword">password</Label>
					<input type="password" name="password" value='<%= rs.getString("password") %>'><br><br>
					<div id="password_error"></div>
				</div>
				
				<button type="submit" class="btn btn-success">
					Update
				</button>
				
			</form>
		</div>
	</div>
	
</div>
				
			
			<%
			
		}
	} catch(Exception ex){
		System.out.println(ex);
	}
		
%>


	<div id="dropDownSelect1"></div>
	
<!--===============================================================================================-->
	<script src="vendor/jquery/jquery-3.2.1.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/animsition/js/animsition.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/bootstrap/js/popper.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/select2/select2.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/daterangepicker/moment.min.js"></script>
	<script src="vendor/daterangepicker/daterangepicker.js"></script>
<!--===============================================================================================-->
	<script src="vendor/countdowntime/countdowntime.js"></script>
<!--===============================================================================================-->
	<script src="js/main.js"></script>

</body>
</html>

<!-- Script for validating sign up page -->
<script language="javascript" >
	//select all  text elements
	var firstname = document.forms['vform']['firstname'];
	var lastname = document.forms['vform']['lastname'];
	var username = document.forms['vform']['username'];
	var email = document.forms['vform']['email'];
	var password = document.forms['vform']['password'];
	
	//regugar expression for validation of password
	var regularExpression = /^([a-zA-Z0-9\.-]+)@([a-zA-Z0-9-]+)\.([a-zA-Z]{2,8})(\.[a-zA-Z]{2,8})?$/;

	//selecting all error display elements
	var firstname_error = document.getElementById('firstname_error');
	var lastname_error = document.getElementById('lastname_error');
	var username_error = document.getElementById('username_error');
	var email_error = document.getElementById('email_error');
	var password_error = document.getElementById('password_error');
	
	//setting all event listners
	firstname.addEventListener('blur', firstnameVerify, true);
	lastname.addEventListener('blur', lastnameVerify, true);
	username.addEventListener('blur', usernameVerify, true);
	email.addEventListener('blur', emailVerify, true);
	password.addEventListener('blur', passwordVerify, true);
	
	//validation function
	function Validate(){
		if(firstname.value == ""){
			firstname.style.border = "1px solid red";
			document.getElementById('firstname_div').style.color = "red";
			firstname_error.textContent = "First name is required";
			firstname.focus();
			return false;
		}

		if(lastname.value == ""){
			lastname.style.border = "1px solid red";
			document.getElementById('lastname_div').style.color = "red";
			lastname_error.textContent = "Last name  is required";
			lastname.focus();
			return false;
		}
		
		if(username.value == ""){
			username.style.border = "1px solid red";
			document.getElementById('username_div').style.color = "red";
			username_error.textContent = "Username  is required";
			username.focus();
			return false;
		}
		
		if(email.value == ""){
			email.style.border = "1px solid red";
			document.getElementById('email_div').style.color = "red";
			email_error.textContent = "Email  is required";
			email.focus();
			return false;
		}
		
		if(password.value == ""){
			password.style.border = "1px solid red";
			document.getElementById('password_div').style.color = "red";
			password_error.textContent = "Password  is required";
			password.focus();
			return false;
		}
		
		if(password.value.length < 6){
			password.style.border = "1px solid red";
			document.getElementById('password_div').style.color = "red";
			password_error.textContent = "Password can not be less than 6 characters";
			password.focus();
			return false;
		}
		
		
		//chech if the email is valid
		if(regularExpression.test(email.value)){			
			return true;
		} else {
			//if the password is not in the correct format
			
			email.style.border = "1px solid red";
			document.getElementById('email_div').style.color = "red";
			email_error.textContent = "Invalid  email";
			email.focus();
			return false;
		}

		
	}

	//event handler functions
	function firstnameVerify(){
		if(firstname.value != null){
			username.style.border = "1px solid #5e6e66";
			document.getElementById('firstname_div').style.color = "#5e6e66";
			firstname_error.innerHTML = "";
			return true;
		}
	}

	function lastnameVerify(){
		if(lastname.value != null){
			lastname.style.border = "1px solid #5e6e66";
			document.getElementById('lastname_div').style.color = "#5e6e66";
			lastname_error.innerHTML = "";
			return true;
		}
	}
	
	function usernameVerify(){
		if(username.value != null){
			username.style.border = "1px solid #5e6e66";
			document.getElementById('username_div').style.color = "#5e6e66";
			username_error.innerHTML = "";
			return true;
		}
	}
	
	function emailVerify(){
		if(email.value != null){
			email.style.border = "1px solid #5e6e66";
			document.getElementById('email_div').style.color = "#5e6e66";
			email_error.innerHTML = "";
			return true;
		}
	}
	
	function passwordVerify(){
		if(password.value != null){
			password.style.border = "1px solid #5e6e66";
			document.getElementById('password_div').style.color = "#5e6e66";
			password_error.innerHTML = "";
			return true;
		}
	}
	
</script>