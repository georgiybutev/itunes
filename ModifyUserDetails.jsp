<%@ page contentType="text/html" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!-- Prevent unauthorised access to the web application. -->
<%
if(session.getAttribute("privileges") == null){
	pageContext.forward("Unauthorised.jsp");
}
%>

<html>
<head>
	<title>Audio Farm Admin</title>
</head>
<body>
<a id="top" href="Admin.jsp">Home</a>
<a href="Logout.jsp">Logout</a>

<!-- Get user details from the form and either remove or update -->
<%
/* Initialise user related variables. */
String message = "";
String queryUserId = request.getParameter("queryUserId");
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
String secretQuestion = request.getParameter("secretQuestion");
password.trim();
String secretAnswer = request.getParameter("secretAnswer");
secretAnswer.trim();
String dateofbirth = request.getParameter("dateofbirth");
secretAnswer.trim();
String action = request.getParameter("action");

/* Get the user credit card amount unless zero. */
String card = request.getParameter("card");
Integer.parseInt(card);
int intCard = 0;
if(!card.isEmpty()){
	intCard = Integer.parseInt(card);
}

/* Get the admin privileges unless zero. */
String admin = request.getParameter("admin");
int intAdmin = 0;
if(!admin.isEmpty()){
	intAdmin = Integer.parseInt(admin);
}

/* Perform simple form validation checking whether the submitted fields are empty. */
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
	/* Edit selected user details. */
	if(action.startsWith("edit")){
		/* Establish a connection to the database with server address, username, and password. */
		String linkToDB = "jdbc:mysql://localhost:3306/audiofarm";
		String usernameForDB = "adminaudiofarm";
		String passwordForDB = "b9YMpCFtm9QPxCjv";
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		Connection connection = DriverManager.getConnection(linkToDB, usernameForDB, passwordForDB);
		Statement statement = connection.createStatement();

		/* Update all user related fields in the database. Use 512 bit password hashing for additional security. */
		String query = "UPDATE user SET forname='"
		+ forname + "', surname='"
		+ surname + "', gender='"
		+ gender + "', country='"
		+ country + "', city='"
		+ city + "', email='"
		+ email + "', username='"
		+ username + "', password=SHA2('"
		+ password + "', 512), secretquestion='"
		+ secretQuestion + "', secretanswer='"
		+ secretAnswer + "', dateofbirth='"
		+ dateofbirth + "', card='"
		+ card + "', admin="
		+ admin + " WHERE id=" + queryUserId + "";

		statement.executeUpdate(query);

		message = "<h2>User details were successfully stored in the database.</h2>";

	/* Remove the selected user from the database. */
	} else if(action.startsWith("remove")) {
		/* Establish a connection to the database with server address, username, and password. */
		String linkToDB = "jdbc:mysql://localhost:3306/audiofarm";
		String usernameForDB = "adminaudiofarm";
		String passwordForDB = "b9YMpCFtm9QPxCjv";
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		Connection connection = DriverManager.getConnection(linkToDB, usernameForDB, passwordForDB);
		Statement statement = connection.createStatement();

		/*  Delete the selected user by matching user id number. */
		String queryDelete = "DELETE FROM user WHERE id='" + queryUserId + "'";
		statement.executeUpdate(queryDelete);
		message = "<h2>The user was successfully deleted from the database.</h2>";
	}
}
%>

<%= message %>
</body>
</html>