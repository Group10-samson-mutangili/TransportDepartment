<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Log out</title>
</head>
<body>
<% 
		//get a session
		HttpSession session_out = request.getSession();
		//remove the data from the session
		session_out.removeAttribute("username");
		session_out.invalidate();
		
		response.sendRedirect("welcome.jsp");
%>
	

</body>
</html>