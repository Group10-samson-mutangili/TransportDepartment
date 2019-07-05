<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import = "java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Edit Car details</title>
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


<div class="container">

<%
			String url="jdbc:mysql://localhost:3306/group_project";
			String dbname = "root";
			String pass = "";
			
			try{
				Class.forName("com.mysql.jdbc.Driver");
			} catch(Exception e){
				e.printStackTrace();
			}
			
			Connection connection = null;
			PreparedStatement statement = null;
			ResultSet rs = null;
			%>
	<div class="row">
		
			<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12"></div>
			
			<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
			<div class="jumbotron">
			<form action="EditLorry" method = "POST">
			
			<%
			try{
			String query = "select * from local_vehicles where id = ?";
				connection = DriverManager.getConnection(url, dbname, pass);
				statement = connection.prepareStatement(query);
				int num = Integer.parseInt(request.getParameter("u"));
				statement.setInt(1, num);
				rs = statement.executeQuery();
				
				while(rs.next()){
			%>
				<h1 class="text-center">Edit Lorry Details</h1>
				<input type="hidden" name="id" value='<%=rs.getInt("id") %>'/>
			
				<div class="form-group">
					<label class="control-table" for="number_plate">Number Plate</label>
					<input type="text" name="number_plate" id="number_plate" class="form-control" value='<%=rs.getString("number_plate") %>'>
					
			</div>	
			
				<div class="form-group">
					<label class="control-table" for="insurance_company">Insurance Company</label>
					<input type="text" name="insurance_company" id="insurance_company" class="form-control" value='<%=rs.getString("insurance_company") %>'>
					
			</div>	
			
			<div class="form-group">
					<label class="control-table" for="premium">Premium amount per annum for insurance</label>
					<input type="number" name="premium" id="premium" class="form-control" value='<%=rs.getInt("premium") %>'>
					
			</div>
			<div class="form-group">
				<label for="condition">Condition</label>
				<select id="condition" name="condition" class="form-control" value='<%=rs.getString("vehicle_condition") %>'>
					<option>New</option>
					 <option>Good</option>
					 <option>Fair</option>
					 <option>Bad</option>
				</select>
			</div>
			<div class="form-group">
				<label for="purchase_date">Date of purchase</label>
				<input type="date" id="purchase_date" class="form-control" name="purchase_date" value='<%=rs.getString("purchase_date") %>'">
			</div>
			
			<div class="form-group">
				<label for="assigned_driver">Assigned Driver</label>
				<select id="assigned_driver" name="assigned_driver" class="form-control" value='<%=rs.getString("assigned_driver") %>'>
				<%
				String query2 = "select * from drivers_details";
				
				try{
					Class.forName("com.mysql.jdbc.Driver");
				} catch(Exception e){
					e.printStackTrace();
				}
				
				PreparedStatement statement2 = null;
				ResultSet rs2 = null;
				
			%>
			<%
				try{
					//create a connection
					Connection con = DriverManager.getConnection(url, dbname, pass);
					//create a statement
					statement2 = con.prepareStatement(query2);
					System.out.println("I have reached here");
					
					rs2 = statement2.executeQuery();
					
					while(rs2.next()){
						%>
						<option><%= rs2.getString("first_name")%></option>						
						<% 
					}
				} catch(Exception e){
					e.printStackTrace();
				}
			%>
					
				</select>
			</div>
			<%
				}
			%>
			
			<%
			} catch (Exception ex){
				System.out.println(ex);
			}
			%>
			
			
			<div class="pull-right">
			<input type="submit" class="btn btn-warning">Update</button>
			
			</div>
		</form>	
			
			</div>
		</div>
	</div>
</div>
		

<script type="text/javascript" src="js/bootstrap.js"></script>
<script type="text/javascript" src="js/jquery.js"></script>
</body>
</html>