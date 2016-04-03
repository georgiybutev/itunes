<%@ page contentType="text/html" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<!-- Prevent unauthorise access to the web application -->
<%
if(session.getAttribute("privileges") == null){
	pageContext.forward("Unauthorised.jsp");
}
%>

<html>
<head>
	<title>Audio Farm Add New User</title>
</head>
<body>
<a id="top" href="Admin.jsp">Home</a>
<a href="Logout.jsp">Logout</a>

<!-- Get form contents and add user to the database -->
<%
/* Initialise user related Strings with data sent from the form. */
String message = "";
String forname = request.getParameter("forname");
forname.trim();
String surname = request.getParameter("surname");
surname.trim();
String gender = request.getParameter("gender");
surname.trim();
String country = request.getParameter("country");
surname.trim();
String city = request.getParameter("city");
surname.trim();
String email = request.getParameter("email");
surname.trim();
String username = request.getParameter("username");
username.trim();
String password = request.getParameter("password");
password.trim();
String secretQuestion = request.getParameter("secretQuestion");
password.trim();
String secretAnswer = request.getParameter("secretAnswer");
secretAnswer.trim();
String dateofbirth = request.getParameter("dateofbirth");
secretAnswer.trim();

/* Get the amount of resource on the user's credit card for display. If the card is empty notify the user. */
String card = request.getParameter("card");
Integer.parseInt(card);
int intCard = 0;
if(!card.isEmpty()){
	intCard = Integer.parseInt(card);
}

/* Get the admin parameter. Only administrators can perform advanced operations. They are marked as 1. */
String admin = request.getParameter("admin");
int intAdmin = 0;
if(!admin.isEmpty()){
	intAdmin = Integer.parseInt(admin);
}

/* Perform simple form validation. Check whether the sent HTML forms are empty. */
if(forname.isEmpty()){
	out.println("<p>Forname field is empty!</p>");
} else if(surname.isEmpty()){
	out.println("<p>Surname field is empty!</p>");
} else if (gender.isEmpty()){
	out.println("<p>Gender field is empty!</p>");
} else if (country.isEmpty()){
	out.println("<p>Country field is empty!</p>");
} else if (city.isEmpty()){
	out.println("<p>City field is empty!</p>");
} else if(email.isEmpty()){
	out.println("<p>Email field is empty!</p>");
} else if(username.isEmpty()){
	out.println("<p>Username field is empty!</p>");
} else if(password.isEmpty()){
	out.println("<p>Password field is empty!</p>");
} else if(password.length() < 6){
	out.println("<p>The password should be more than 6 characters long!</p>");
} else if(secretAnswer.isEmpty()){
	out.println("<p>SecretAnswer field is empty!</p>");
} else if(dateofbirth.isEmpty()){
	out.println("<p>Date of Birth field is empty!</p>");
} else {

	/* Establish connection to MySQL with server address, username and password. */
	String linkToDB = "jdbc:mysql://localhost:3306/audiofarm";
	String usernameForDB = "adminaudiofarm";
	String passwordForDB = "b9YMpCFtm9QPxCjv";
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	Connection connection = DriverManager.getConnection(linkToDB, usernameForDB, passwordForDB);
	Statement statement = connection.createStatement();

	/* Insert the data from the HTML form into the user table. */
	String query = "INSERT INTO user (id, forname, surname, gender, country, city, email, username, password, secretquestion, secretanswer, dateofbirth, card, admin) VALUES (NULL,'" 
		+ forname + "', '" 
		+ surname + "', '" 
		+ gender + "', '" 
		+ country + "', '" 
		+ city + "', '" 
		+ email + "', '" 
		+ username + "', '" 
		+ password + "', '" 
		+ secretQuestion + "', '" 
		+ secretAnswer + "', '" 
		+ dateofbirth + "', '" 
		+ intCard + "', '" 
		+ intAdmin +"')";

	statement.executeUpdate(query);

	message = "<h2>User details were successfully stored in the database.</h2>";
}

%>
<%= message %>
</body>
</html>