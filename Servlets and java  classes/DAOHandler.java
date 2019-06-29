package com.samson;
/*
 * This class is used to handle all database requests apart from the 
 * log in and sign up databases tables
 */

import java.io.InputStream;
import java.sql.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Date;

public class DAOHandler {
	
	//the database details
	private String url="jdbc:mysql://localhost:3306/group_project";
	private String dbname = "root";
	private String pass = "";
		public static Connection getConnection(){
			
			try{
				String driver = "com.mysql.jdbc.Driver";
				//the database details
				String url="jdbc:mysql://localhost:3306/group_project";
				String dbname = "root";
				String pass = "";
					
				Class.forName(driver);
				Connection con = DriverManager.getConnection(url, dbname, pass);
				return con;
			} catch(Exception ex){
				System.out.println(ex);
			}
			
			return null;
		}
		public static void createTable(){
			try{
				Connection con= getConnection();
//				//Table for scheduled trips
//				String query1 = "CREATE TABLE IF NOT EXISTS scheduled_trips("
//						+ "id int NOT NULL AUTO_INCREMENT PRIMARY KEY, "
//						+ "destination varchar(100) NOT NULL, "
//						+ "departure_date varchar(50) NOT NULL, "
//						+ "return_date varchar(50) NOT NULL, "
//						+ "no_of_students int NOT NULL, "
//						+ "faculty varchar(100) NOT NULL, "
//						+ "department varchar(100) NOT NULL)";		
//				
				//table details for drivers
				String query2 = "CREATE TABLE IF NOT EXISTS drivers("
						+ "id int NOT NULL AUTO_INCREMENT PRIMARY KEY, "
						+ "last_name varchar(100),"
						+ "first_name varchar(100),"
						+ "emp_id varchar(50) NOT NULL, "
						+ "password varchar(100) NOT NULL, "
						+ "email varchar(100), "
						+ "id_no int, "
						+ "phone_no varchar(100))";
				
				String query3 = "CREATE TABLE IF NOT EXISTS cars("
						+ "id int NOT NULL AUTO_INCREMENT PRIMARY KEY, "
						+ "number_plate varchar(30) NOT NULL, "
						+ "insurance_company varchar(100) NOT NULL, "
						+ "premium int NOT NULL, "
						+ "vehicle_condition varchar(50), "
						+ "assigned_driver varchar(100), "
						+ "mileage_covered int, "
						+ "scheduled varchar(30))";
				
				String query4 = "CREATE TABLE IF NOT EXISTS lorries("
						+ "id int NOT NULL AUTO_INCREMENT PRIMARY KEY, "
						+ "number_plate varchar(30) NOT NULL, "
						+ "insurance_company varchar(100) NOT NULL, "
						+ "premium int NOT NULL, "
						+ "vehicle_condition varchar(50), "
						+ "assigned_driver varchar(100), "
						+ "mileage_covered int, "
						+ "scheduled varchar(30))";
				
				String query5 = "CREATE TABLE IF NOT EXISTS tractors("
						+ "id int NOT NULL AUTO_INCREMENT PRIMARY KEY, "
						+ "number_plate varchar(30) NOT NULL, "
						+ "insurance_company varchar(100) NOT NULL, "
						+ "premium int NOT NULL, "
						+ "vehicle_condition varchar(50), "
						+ "assigned_driver varchar(100), "
						+ "mileage_covered int, "
						+ "scheduled varchar(30))";
				
				
				String query6 = "CREATE TABLE IF NOT EXISTS buses("
						+ "id int NOT NULL AUTO_INCREMENT PRIMARY KEY, "
						+ "capacity int NOT NULL, "
						+ "number_plate varchar(30) NOT NULL, "
						+ "insurance_company varchar(100) NOT NULL, "
						+ "premium int NOT NULL, "
						+ "bus_condition varchar(50), "
						+ "purchase_date varchar(100), "
						+ "mileage_covered int, "
						+ "due_repair varchar(100))";
				
				String query7 = "CREATE TABLE IF NOT EXISTS reserved_buses("
						+ "id int NOT NULL AUTO_INCREMENT PRIMARY KEY, "
						+ "number_plate varchar(30) NOT NULL, "
						+ "capacity int NOT NULL, "
						+ "reserved_date varchar (100) NOT NULL)";
				
				String query8 = "CREATE TABLE IF NOT EXISTS users("
						+ "id int NOT NULL AUTO_INCREMENT PRIMARY KEY, "
						+ "firstname varchar(100) NOT NULL, "
						+ "lastname varchar(30) NOT NULL, "
						+ "username varchar(100) NOT NULL, "
						+ "email varchar(100) NOT NULL, "
						+ "password varchar(50) NOT NULL)";
				
				String query9 = "CREATE TABLE IF NOT EXISTS emergency_bookings("
						+ "id int NOT NULL AUTO_INCREMENT PRIMARY KEY, "
						+ "destination varchar(100) NOT NULL, "
						+ "departure_date varchar(30) NOT NULL, "
						+ "return_date varchar(100) NOT NULL, "
						+ "purpose varchar(1200) NOT NULL, "
						+ "email varchar(100) NOT NULL)";
				
				String query10 = "CREATE TABLE IF NOT EXISTS work_tickets("
						+ "id int NOT NULL AUTO_INCREMENT PRIMARY KEY, "
						+ "number_plate varchar(30) NOT NULL, "
						+ "date_filled varchar(30) NOT NULL, "
						+ "Driver varchar(50) NOT NULL, "
						+ "from_place varchar(100) NOT NULL, "
						+ "to_place varchar(100) NOT NULL, "
						+ "oil_drawn int NOT NULL, "
						+ "fuel int NOT NULL, "
						+ "cash_receipt int NOT NULL, "
						+ "time_out varchar(100) NOT NULL, "
						+ "time_in varchar(100) NOT NULL, "
						+ "speedo_reading int NOT NULL, "
						+ "kilometres_done int NOT NULL, "
						+ "defects varchar(100))";
				
				
				String query11 = "CREATE TABLE IF NOT EXISTS trip_bookings("
						+ "id int NOT NULL AUTO_INCREMENT PRIMARY KEY, "
						+ "reference_no int NOT NULL,"
						+ "destination varchar(50) NOT NULL, "
						+ "departure_date varchar(30) NOT NULL, "
						+ "trip_days int NOT NULL, "
						+ "department varchar(100) NOT NULL, "
						+ "course_title varchar(100) NOT NULL, "
						+ "unit_code varchar(100) NOT NULL, "
						+ "unit_title varchar(300) NOT NULL, "
						+ "lecturers int NOT NULL, "
						+ "students int NOT NULL, "
						+ "purpose varchar(500) NOT NULL,"
						+ "email varchar(100) NOT NULL, "
						+ "replied varchar(50) NOT NULL, "
						+ "trip_status varchar(100), "
						+ "bus_allocated varchar(100))";
				
				String query12 = "CREATE TABLE IF NOT EXISTS scheduled_trips("
						+ "id int NOT NULL AUTO_INCREMENT PRIMARY KEY, "
						+ "reference_no int NOT NULL, "
						+ "trip_days int NOT NULL, "
						+ "unit_code varchar(30) NOT NULL, "
						+ "unit_title varchar(100) NOT NULL, "
						+ "date_of_trip varchar(100) NOT NULL, "
						+ "bus_assigned varchar(100) NOT NULL,"
						+ "bus_capacity int NOT NULL)";
				
				String query13 = "CREATE TABLE IF NOT EXISTS past_trips("
						+ "id int NOT NULL AUTO_INCREMENT PRIMARY KEY, "
						+ "reference_no int NOT NULL, "
						+ "trip_days int NOT NULL, "
						+ "unit_code varchar(30) NOT NULL, "
						+ "unit_title varchar(100) NOT NULL, "
						+ "date_of_trip varchar(100) NOT NULL, "
						+ "bus_assigned varchar(100) NOT NULL)";
				String query14 = "CREATE TABLE IF NOT EXISTS maintenance("
						+ "time datetime default CURRENT_TIMESTAMP, "
						+ "plate varchar(100), "
						+ "currentReading double, "
						+ "nextReading double, "
						+ "parts varchar(100) , "
						+ "cost int)";
				
//				
//				PreparedStatement statement1 = con.prepareStatement(query1);
//				statement1.executeUpdate();
				
				PreparedStatement statement2 = con.prepareStatement(query2);
				statement2.executeUpdate();
				
				PreparedStatement statement3 = con.prepareStatement(query3);
				statement3.executeUpdate();
				
				PreparedStatement statement4 = con.prepareStatement(query4);
				statement4.executeUpdate();
				
				PreparedStatement statement5 = con.prepareStatement(query5);
				statement5.executeUpdate();
				
				PreparedStatement statement6 = con.prepareStatement(query6);
				statement6.executeUpdate();
				
				PreparedStatement statement7 = con.prepareStatement(query7);
				statement7.executeUpdate();
				
				PreparedStatement statement8 = con.prepareStatement(query8);
				statement8.executeUpdate();
				
				PreparedStatement statement9 = con.prepareStatement(query9);
				statement9.executeUpdate();
				
				PreparedStatement statement10 = con.prepareStatement(query10);
				statement10.executeUpdate();
				
				PreparedStatement statement11 = con.prepareStatement(query11);
				statement11.executeUpdate();
				
				PreparedStatement statement12 = con.prepareStatement(query12);
				statement12.executeUpdate();
				
				PreparedStatement statement13 = con.prepareStatement(query13);
				statement13.executeUpdate();
				PreparedStatement statement14 = con.prepareStatement(query14);
				statement14.executeUpdate();
				
			} catch(Exception ex){
				System.out.println(ex);
			}
		}
		
		public void trip_bookings(int reference_no, String destination, String departure_date, int trip_days, String department, String 
				course_title, String unit_code, String unit_title, int lecturers, int students,
				String purpose, String email){
			
			try{
				
				Connection con = DAOHandler.getConnection();				
				createTable();
				//a query for inserting data to the database
				String query4 = "INSERT INTO trip_bookings(reference_no, destination, departure_date, trip_days, department, course_title, unit_code, unit_title, lecturers, students, purpose, email, replied, bus_allocated) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
				
				//prepare a statement
				PreparedStatement st = con.prepareStatement(query4);
				
				//set the data
				st.setInt(1, reference_no);
				st.setString(2,  destination);
				st.setString(3, departure_date);
				st.setInt(4, trip_days);
				st.setString(5, department);
				st.setString(6, course_title);
				st.setString(7, unit_code);
				st.setString(8, unit_title);
				st.setInt(9, lecturers);
				st.setInt(10,  students);
				st.setString(11, purpose);
				st.setString(12, email);
				st.setString(13, "NO");
				st.setString(14, "No");
				
				
				//execute the query and return the number of rows affected
				int rows = st.executeUpdate();
				
				System.out.println(rows + "affected");
				
				st.close();
				con.close();
			}
			catch(Exception e){
				e.printStackTrace();
			}
			
		}
		
		
		//a method that is used to insert data from the academic trip details to the database
		public void scheduled_trips(String destination, String departure_date, String return_date,
				int passengers, String faculty, String department){
			
			try{
				
				createTable();
				//create a connection
				Connection con = getConnection();
				
				//a query for inserting data to the database
				String query1 = "INSERT INTO scheduled_trips(destination, departure_date, return_date, no_of_students, faculty, department) VALUES (?,?,?,?,?,?)";
				
				//prepare a statement
				PreparedStatement st = con.prepareStatement(query1);
				
				//set the data
				st.setString(1, destination);
				st.setString(2, departure_date);
				st.setString(3, return_date);
				st.setInt(4, passengers);
				st.setString(5, faculty);
				st.setString(6, department);
				
				//execute the query and return the number of rows affected
				int rows = st.executeUpdate();
				
				System.out.println(rows + "affected");
				
				st.close();
				con.close();
			}
			catch(Exception e){
				e.printStackTrace();
			}
}

		public void register_driver(String first_name, String last_name, int id_no, String emp_id,
				String driving_licence){
			
			try{
				
				//load the drivers
				Class.forName("com.mysql.jdbc.Driver");
				//create a connection
				Connection con = DriverManager.getConnection(url, dbname, pass);
				
				//a query for inserting data to the database
				String query2 = "INSERT INTO drivers_details VALUES (?,?,?,?,?)";
				
				//prepare a statement
				PreparedStatement st = con.prepareStatement(query2);
				
				//set the data
				st.setString(1, first_name);
				st.setString(2, last_name);
				st.setInt(3, id_no);
				st.setString(4, emp_id);
				st.setString(5, driving_licence);
				
				//execute the query and return the number of rows affected
				int rows = st.executeUpdate();
				
				System.out.println(rows + "affected");
				
				st.close();
				con.close();
			}
			catch(Exception e){
				e.printStackTrace();
			}
			
		}
		
		public void insert_bus_details(int capacity, String number_plate, String insurance_company,
				int premium, String condition, String purchase_date){
			
			try{
				//create a connection
				Connection con = getConnection();
				
				//create a table if it does not exist
				createTable(); 
				//a query for inserting data to the database
				String query3 = "INSERT INTO buses(capacity, number_plate, insurance_company, premium, bus_condition, purchase_date) VALUES (?,?,?,?,?,?)";
				
				//prepare a statement
				PreparedStatement st = con.prepareStatement(query3);
				
				//set the data
				st.setInt(1, capacity);
				st.setString(2, number_plate);
				st.setString(3, insurance_company);
				st.setInt(4, premium);
				st.setString(5, condition);
				st.setString(6, purchase_date);
				
				//execute the query and return the number of rows affected
				int rows = st.executeUpdate();
				System.out.println("what about the rows??");
				
				System.out.println(rows + "affected");
				
				st.close();
				con.close();
			}
			catch(Exception e){
				e.printStackTrace();
			}
		}
		
		public int edit_bus_details(int id, int capacity, String number_plate, String insurance_company,
				int premium, String condition, String purchase_date){
			
			try{
				//create a connection
				Connection con = getConnection();
				
				//a query for inserting data to the database
				String query3 = "update buses set capacity = ?, number_plate = ?, insurance_company = ?, premium = ?, bus_condition = ?, purchase_date = ? where id='"+id+"'";
				
				//prepare a statement
				PreparedStatement st = con.prepareStatement(query3);
				
				//set the data
				st.setInt(1, capacity);
				st.setString(2, number_plate);
				st.setString(3, insurance_company);
				st.setInt(4, premium);
				st.setString(5, condition);
				st.setString(6, purchase_date);
				
				
				//execute the query and return the number of rows affected
				int rows = st.executeUpdate();
				
				st.close();
				con.close();
				
				return rows;
			}
			catch(Exception e){
				e.printStackTrace();
			}
			
			return -1;
		}
		
		public void insert_emergency_bookings(String destination, String departure_date, String return_date,
				String purpose, String email){
			
			try{
				
				//load the drivers
				Class.forName("com.mysql.jdbc.Driver");
				//create a connection
				Connection con = DriverManager.getConnection(url, dbname, pass);
				
				createTable();
				//a query for inserting data to the database
				String query4 = "INSERT INTO emergency_bookings(destination, departure_date, return_date, purpose, email) VALUES (?,?,?,?,?)";
				
				//prepare a statement
				PreparedStatement st = con.prepareStatement(query4);
				
				//set the data
				
				st.setString(1,  destination);
				st.setString(2, departure_date);
				st.setString(3, return_date);
				st.setString(4, purpose);
				st.setString(5, email);
				
				//execute the query and return the number of rows affected
				int rows = st.executeUpdate();
				
				System.out.println(rows + "affected");
				
				st.close();
				con.close();
			}
			catch(Exception e){
				e.printStackTrace();
			}
			
		}
		
		
		public void insert_car(String number_plate, String insurance_company,
				int premium, String condition, String purchase_date, String assigned_driver){
			
			try{
				
				//load the drivers
				Class.forName("com.mysql.jdbc.Driver");
				//create a connection
				Connection con = DriverManager.getConnection(url, dbname, pass);
				
				//a query for inserting data to the database
				String query5 = "INSERT INTO cars(number_plate, insurance_company, premium, vehicle_condition, purchase_date, assigned_driver) VALUES (?,?,?,?,?,?)";
				//prepare a statement
				PreparedStatement st = con.prepareStatement(query5);
				
				//set the data
				st.setString(1, number_plate);
				st.setString(2, insurance_company);
				st.setInt(3, premium);
				st.setString(4, condition);
				st.setString(5, purchase_date);
				st.setString(6, assigned_driver);
				
				//execute the query and return the number of rows affected
				int rows = st.executeUpdate();
				
				System.out.println(rows + "affected");
				
				st.close();
				con.close();
			}
			catch(Exception e){
				e.printStackTrace();
			}
		}
		
		public int edit_car(int id, String number_plate, String insurance_company,
				int premium, String condition, String purchase_date, String assigned_driver){
			
			try{
				
				//load the drivers
				Class.forName("com.mysql.jdbc.Driver");
				//create a connection
				Connection con = DriverManager.getConnection(url, dbname, pass);
				
				//a query for inserting data to the database
				String query5 =  "UPDATE cars SET number_plate=?, insurance_company=?, premium=?, vehicle_condition=?, purchase_date=?, assigned_driver=? WHERE id='"+id+"'";
				//prepare a statement
				PreparedStatement st = con.prepareStatement(query5);
				
				//set the data
				st.setString(1, number_plate);
				st.setString(2, insurance_company);
				st.setInt(3, premium);
				st.setString(4, condition);
				st.setString(5, purchase_date);
				st.setString(6, assigned_driver);
				
				
				//execute the query and return the number of rows affected
				int rows = st.executeUpdate();
				
				st.close();
				con.close();
				return rows;
				
				
			}
			catch(Exception e){
				e.printStackTrace();
			}
			
			return -1;
		}
		
		public void insert_lorry(String number_plate, String insurance_company,
				int premium, String condition, String purchase_date, String assigned_driver){
			
			try{
				
				//load the drivers
				Class.forName("com.mysql.jdbc.Driver");
				//create a connection
				Connection con = DriverManager.getConnection(url, dbname, pass);
				
				//a query for inserting data to the database
				String query5 = "INSERT INTO lorries(number_plate, insurance_company, premium, vehicle_condition, purchase_date, assigned_driver) VALUES (?,?,?,?,?,?)";
				//prepare a statement
				PreparedStatement st = con.prepareStatement(query5);
				
				//set the data
				st.setString(1, number_plate);
				st.setString(2, insurance_company);
				st.setInt(3, premium);
				st.setString(4, condition);
				st.setString(5, purchase_date);
				st.setString(6, assigned_driver);
				
				//execute the query and return the number of rows affected
				int rows = st.executeUpdate();
				
				System.out.println(rows + "affected");
				
				st.close();
				con.close();
			}
			catch(Exception e){
				e.printStackTrace();
			}
		}
		
		
		public int edit_lorry(int id, String number_plate, String insurance_company,
				int premium, String condition, String purchase_date, String assigned_driver){
			
			try{
				
				//load the drivers
				Class.forName("com.mysql.jdbc.Driver");
				//create a connection
				Connection con = DriverManager.getConnection(url, dbname, pass);
				
				//a query for inserting data to the database
				String query5 =  "UPDATE lorries SET number_plate=?, insurance_company=?, premium=?, vehicle_condition=?, purchase_date=?, assigned_driver=? WHERE id='"+id+"'";
				//prepare a statement
				PreparedStatement st = con.prepareStatement(query5);
				
				//set the data
				st.setString(1, number_plate);
				st.setString(2, insurance_company);
				st.setInt(3, premium);
				st.setString(4, condition);
				st.setString(5, purchase_date);
				st.setString(6, assigned_driver);
				
				
				//execute the query and return the number of rows affected
				int rows = st.executeUpdate();
				
				st.close();
				con.close();
				
				return rows;
			}
			catch(Exception e){
				e.printStackTrace();
			}
			
			return -1;
		}
		
		
		public void insert_tractor(String number_plate, String insurance_company,
				int premium, String condition, String purchase_date, String assigned_driver){
			
			try{
				
				//load the drivers
				Class.forName("com.mysql.jdbc.Driver");
				//create a connection
				Connection con = DriverManager.getConnection(url, dbname, pass);
				
				//a query for inserting data to the database
				String query5 = "INSERT INTO tractors(number_plate, insurance_company, premium, vehicle_condition, purchase_date, assigned_driver) VALUES (?,?,?,?,?,?)";
				//prepare a statement
				PreparedStatement st = con.prepareStatement(query5);
				
				//set the data
				st.setString(1, number_plate);
				st.setString(2, insurance_company);
				st.setInt(3, premium);
				st.setString(4, condition);
				st.setString(5, purchase_date);
				st.setString(6, assigned_driver);
				
				//execute the query and return the number of rows affected
				int rows = st.executeUpdate();
				
				System.out.println(rows + "affected");
				
				st.close();
				con.close();
			}
			catch(Exception e){
				e.printStackTrace();
			}
		}
		
		public int edit_tractor(int id, String number_plate, String insurance_company,
				int premium, String condition, String purchase_date, String assigned_driver){
			
			try{
				
				//load the drivers
				Class.forName("com.mysql.jdbc.Driver");
				//create a connection
				Connection con = DriverManager.getConnection(url, dbname, pass);
				
				//a query for inserting data to the database
				String query5 =  "UPDATE tractors SET number_plate=?, insurance_company=?, premium=?, vehicle_condition=?, purchase_date=?, assigned_driver=? WHERE id='"+id+"'";
				//prepare a statement
				PreparedStatement st = con.prepareStatement(query5);
				
				//set the data
				st.setString(1, number_plate);
				st.setString(2, insurance_company);
				st.setInt(3, premium);
				st.setString(4, condition);
				st.setString(5, purchase_date);
				st.setString(6, assigned_driver);
				
				
				//execute the query and return the number of rows affected
				int rows = st.executeUpdate();
				
				st.close();
				con.close();
				
				return rows;
			}
			catch(Exception e){
				e.printStackTrace();
			}
			
			return -1;
		}
		
		/*
		 * A method for updating local vehicles  details from the edited form
		 */
		public void editLocalVehicle(int id, String number_plate, String insurance_company,
				int premium, String condition, String purchase_date, String assigned_driver){
			
			try{
				
				//load the drivers
				Class.forName("com.mysql.jdbc.Driver");
				//create a connection
				Connection con = DriverManager.getConnection(url, dbname, pass);
				
				//a query for inserting data to the database
				String query5 = "UPDATE  local_vehicles SET number_plate=?, insurance_company=?, premium=?, vehicle_condition=?, purchase_date=?, assigned_driver=? WHERE id='"+id+"'";
				//prepare a statement
				PreparedStatement st = con.prepareStatement(query5);
				
				//set the data
				st.setString(1, number_plate);
				st.setString(2, insurance_company);
				st.setInt(3, premium);
				st.setString(4, condition);
				st.setString(5, purchase_date);
				st.setString(6, assigned_driver);
				
				//execute the query and return the number of rows affected
				int rows = st.executeUpdate();
				
				System.out.println(rows + "affected");
				
				st.close();
				con.close();
			}
			catch(Exception e){
				e.printStackTrace();
			}
		}
		
		
		public void insert_work_ticket(String number_plate, String date_filled, String driver, String from, 
				String to, int oil, int fuel, int cash_receipt, String time_out, 
				String time_in, int speedo_reading, int kilometres_done, String defects ){
			
			try{
				//GET the database connection
				Connection con = getConnection();
				
				//Create the table if it does not exist
				createTable();
				
				//The sql query
				String query6 = "INSERT INTO work_tickets(number_plate, date_filled, driver, from_place, to_place, oil_drawn, fuel, cash_receipt, time_out, time_in, speedo_reading, kilometres_done, defects) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?) ";
				
				PreparedStatement stmt = con.prepareStatement(query6);
				stmt.setString(1, number_plate);
				stmt.setString(2, date_filled);
				stmt.setString(3, driver);
				stmt.setString(4,  from);
				stmt.setString(5, to);
				stmt.setInt(6,  oil);
				stmt.setInt(7, fuel);
				stmt.setInt(8, cash_receipt);
				stmt.setString(9, time_out);
				stmt.setString(10, time_in);
				stmt.setInt(11, speedo_reading);
				stmt.setInt(12,  kilometres_done);
				stmt.setString(13, defects);
				
				stmt.executeUpdate();
				
				stmt.close();
				con.close();
				
				
			} catch(Exception ex){
				System.out.println(ex);
			}
		}
		
		public void update_work_ticket(int id, String date_filled, String from, 
				String to, int oil, int fuel, int cash_receipt, String time_out, 
				String time_in, int speedo_reading, int kilometres_done, String defects ){
			
			try{
				//GET the database connection
				Connection con = getConnection();
				
				//Create the table if it does not exist
				createTable();
				
				//The sql query
				String query6 = "UPDATE work_tickets SET date_filled=?, from_place=?, to_place=?, oil_drawn=?, fuel=?, cash_receipt=?, time_out=?, time_in=?, speedo_reading=?, kilometres_done=?, defects=? WHERE id=? ";
				
				PreparedStatement stmt = con.prepareStatement(query6);
				stmt.setString(1, date_filled);
				stmt.setString(2,  from);
				stmt.setString(3, to);
				stmt.setInt(4,  oil);
				stmt.setInt(5, fuel);
				stmt.setInt(6, cash_receipt);
				stmt.setString(7, time_out);
				stmt.setString(8, time_in);
				stmt.setInt(9, speedo_reading);
				stmt.setInt(10,  kilometres_done);
				stmt.setString(11, defects);
				stmt.setInt(12, id);
				
				stmt.executeUpdate();
				
				stmt.close();
				con.close();
				
				
			} catch(Exception ex){
				System.out.println(ex);
			}
		}
		
		
		public void update_user_profile(int id, String firstname, String lastname, String username, String email, String password){
			
			try{
				Connection con = getConnection();
				//query to update user details
				String query = "UPDATE users set firstname=?, lastname=?, username=?, email=?, password=? WHERE id=?";
				PreparedStatement stmt = con.prepareStatement(query);
				stmt.setString(1, firstname);
				stmt.setString(2, lastname);
				stmt.setString(3, username);
				stmt.setString(4, email);
				stmt.setString(5, password);
				stmt.setInt(6, id);
				
				stmt.executeUpdate();
			} catch(Exception ex){
				System.out.println(ex);
			}
			
			
		}
		
		public void update_Driver_profile(int id, String email, String password, int phone_no){
			
			try{
				Connection con = getConnection();
				//query to update user details
				String query = "UPDATE drivers set email=?, password=?, phone_no=? WHERE id=?";
				PreparedStatement stmt = con.prepareStatement(query);
				stmt.setString(1, email);
				stmt.setString(2, password);
				stmt.setInt(3, phone_no);
				stmt.setInt(4, id);
				
				stmt.executeUpdate();
			} catch(Exception ex){
				System.out.println(ex);
			}
			
			
		}
		
}

