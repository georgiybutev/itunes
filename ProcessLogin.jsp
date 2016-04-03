<%@ page contentType="text/html" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<html>
<head>
	<title>Audio Farm Process Login</title>
</head>
<body>
<a href="index.jsp">Home</a>
<a href="Register.jsp">Register</a>

<!-- Authorise user against DB -->
<%
/* Initialise user related variables. */
String queryUserId = null;
int userId = 0;
String queryForname = null;
String queryUsername = null;
String queryPassword = null;
String queryAdmin = null;
Boolean userVerified = false;
Boolean adminVerified = false;
Boolean privileges = false;
String verifiedForname = null;
String message = null;
String link = "";

/* Get the submitted form username and password. */
String formUsername = request.getParameter("username");
formUsername.trim();
String formPassword = request.getParameter("password");
formPassword.trim();

/* Initialise password related variables. */
String cryptedPassword = "";
String originalPassword = "";

/* Process user authentication only if both text fields are not empty. */
if(formUsername.isEmpty()){
	out.println("<p>Username field was empty.</p>");
} else if (formPassword != null && formPassword.isEmpty()){
	out.println("<p>Password field was empty.</p>");
} else {

	try{
		/* Establish a connection to the database with server address, username, and password. */
		String linkToDB = "jdbc:mysql://localhost:3306/audiofarm";
		String username = "adminaudiofarm";
		String password = "b9YMpCFtm9QPxCjv";
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		Connection connection = DriverManager.getConnection(linkToDB,username,password);
		Statement statement = connection.createStatement();

		/* Get 512 bit hashed password based on the submitted password field. */
		String queryCrypt = "SELECT SHA2('" + formPassword + "', 512)";
		ResultSet resultCrypt = statement.executeQuery(queryCrypt);
		/* Assign the crypted password for later use. */
		while(resultCrypt.next()){
			cryptedPassword = resultCrypt.getString(1);
		}

		/* Get all user related details from the database. */
		String query = "SELECT * FROM user LIMIT 0 , 30";
		ResultSet resultSet = statement.executeQuery(query);
		
		/* Iterate over the result until all user related details are assigned. */
		while(resultSet.next()){
			queryUserId = resultSet.getString(1);
			queryForname = resultSet.getString(2);
			queryUsername = resultSet.getString(8);
			queryPassword = resultSet.getString(9);
			queryAdmin = resultSet.getString(14);
			/* Check whether there is a match between the submitted username and password against the database records. */
			if(queryUsername.matches(formUsername) && queryPassword.matches(cryptedPassword)){
				/* Assign user privileges by default. */
				userVerified = true;
				verifiedForname = queryForname;
				userId = Integer.parseInt(queryUserId);
				/* Assign user privileges if the field equals one. */
				if(Integer.parseInt(queryAdmin) == 1){
					adminVerified = true;
					verifiedForname = queryForname;
					privileges = true;
					userId = Integer.parseInt(queryUserId);
				}
			}
		}

	}catch(Exception exception){
		out.println("Could not retrieve data from the database.");
	}

	/* If the user/administrator has been successfully authenticated. */
	if(userVerified){
		message = verifiedForname + " successfully logged in.";
		if(adminVerified){
			/* Admin home page. */
			link = "&nbsp;<a href=\"Admin.jsp\">Admin</a>";
		} else {
			/* User home page. */
			link = "&nbsp;<a href=\"User.jsp\">User</a>";
		}
		/* Set the user related session attributed. */
		session.setAttribute("userId", userId);
		session.setAttribute("name", verifiedForname);
		session.setAttribute("privileges", privileges);
	} else {
		/* Notify the user upon unsuccessful authentication. */
		message = "Username or password incorrect.";
	}
}

%>

<h1><%= message %><%= link %></h1>

</body>
</html>