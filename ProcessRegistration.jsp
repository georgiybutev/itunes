<%@ page contentType="text/html" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<html>
<head>
	<title>Audio Farm Process Registration</title>
</head>
<body>
<a href="index.jsp">Home</a>

<!-- Get all form entries -->
<%
/* Initialise user related variables. */
Boolean duplicate = false;
String message = "";
String forname = request.getParameter("forname");
forname.trim();
String surname = request.getParameter("surname");
surname.trim();
String gender = request.getParameter("gender");
String country = request.getParameter("country");
String city = request.getParameter("city");
String email = request.getParameter("email");
String username = request.getParameter("username");
username.trim();
String password = request.getParameter("password");
password.trim();
String password2 = request.getParameter("password2");
password2.trim();
String secretQuestion = request.getParameter("secretQuestion");
String secretAnswer = request.getParameter("secretAnswer");
secretAnswer.trim();
String dateofbirth = request.getParameter("dateofbirth");

/* Get the credit card amount from the submitted form. */
String card = request.getParameter("card");
Integer.parseInt(card);
int intCard = 0;

/* Depending on the submitted value assign user credit card amount. */
if(Integer.parseInt(card) == 1){
	intCard = 100;
} else if(Integer.parseInt(card) == 2){
	intCard = 200;
} else if(Integer.parseInt(card) == 3){
	intCard = 2000;
}

/* Perform simple form validation checking whether the submitted form fields are empty. */
if(forname.isEmpty()){
	out.println("<p>Forname field is empty!</p>");
} else if(surname.isEmpty()){
	out.println("<p>Surname field is empty!</p>");
} else if(email.isEmpty()){
	out.println("<p>Email field is empty!</p>");
} else if(password.isEmpty()){
	out.println("<p>Password field is empty!</p>");
} else if(password.length() < 6){
	out.println("<p>Your password should be more than 6 characters long!</p>");
} else if(password2.isEmpty()){
	out.println("<p>Retype Password field is empty!</p>");
	password2.trim();
} else if(!password2.matches(password)){
	out.println("<p>The two passwords do not match!</p>");
} else if(secretAnswer.isEmpty()){
	out.println("<p>SecretAnswer field is empty!</p>");
} else if(dateofbirth.isEmpty()){
	out.println("<p>Date of Birth field is empty!</p>");
} else {

	/* Establish a connection to the database with server address, username, and password. */
	String linkToDB = "jdbc:mysql://localhost:3306/audiofarm";
	String usernameForDB = "adminaudiofarm";
	String passwordForDB = "b9YMpCFtm9QPxCjv";
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	Connection connection = DriverManager.getConnection(linkToDB, usernameForDB, passwordForDB);
	Statement statement = connection.createStatement();

	/* Get all usernames from the database. */
	String queryForDuplicate = "SELECT username FROM user";
	ResultSet resultForDuplicate = statement.executeQuery(queryForDuplicate);
	/* Iterate over the result while checking for username duplicates. */
	while(resultForDuplicate.next()){
		if(resultForDuplicate.getString(1).startsWith(username)){
			duplicate = true;
			message = "<h1>This username already exists!</h1>";
		}
	}
	/* Perform only if there are no username duplicates. */
	if(!duplicate){

		/* Create new user with all form submitted user details. */
		String query = "INSERT INTO user (id, forname, surname, gender, country, city, email, username, password, secretquestion, secretanswer, dateofbirth, card, admin) VALUES (NULL,'" 
		+ forname + "', '" 
		+ surname + "', '" 
		+ gender + "', '" 
		+ country + "', '" 
		+ city + "', '" 
		+ email + "', '" 
		+ username + "', SHA2('" 
		+ password + "', 512), '" 
		+ secretQuestion + "', '" 
		+ secretAnswer + "', '" 
		+ dateofbirth + "', '" 
		+ intCard +"', 0)";

		/*String query2 = "UPDATE user SET forname='"+forname+"' WHERE id=7";*/

		statement.executeUpdate(query);

		message = "<h1>Registration was successful!</h1>";
		message = message.concat("<h1>" + forname + " welcome to Audio Farm. <a href=\"Login.jsp\">Login</a></h1>");
	}
}

%>

<%= message %>
</body>
</html>