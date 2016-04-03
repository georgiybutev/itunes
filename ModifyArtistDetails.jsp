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

<!-- Get artist details from the form and either remove or update -->
<%
/* Initialise song related variables */
String message = "";
String id = request.getParameter("id");
String name = request.getParameter("name");
name.trim();
String artist = request.getParameter("artist");
artist.trim();
String album = request.getParameter("album");
album.trim();
String year = request.getParameter("year");
year.trim();
String duration = request.getParameter("duration");
duration.trim();
String price = request.getParameter("price");
String quantity = request.getParameter("quantity");
String genre = request.getParameter("genre");
Double doublePrice = Double.parseDouble(price);
int intQuantity = Integer.parseInt(quantity);
String action = request.getParameter("action");

/* Perform simple form validation whether the submitted text fields are empty. */
if(name.isEmpty()){
	out.println("<p>Name field is empty!</p>");
} else if(artist.isEmpty()){
	out.println("<p>Artist field is empty!</p>");
} else if (album.isEmpty()){
	out.println("<p>Album field is empty!</p>");
} else if (year.isEmpty()){
	out.println("<p>Year field is empty!</p>");
} else if (duration.isEmpty()){
	out.println("<p>Duration field is empty!</p>");
} else if(price.isEmpty()){
	out.println("<p>Price field is empty!</p>");
} else if(quantity.isEmpty()){
	out.println("<p>Quantity field is empty!</p>");
} else {

	/* Edit selected song details. */
	if(action.startsWith("edit")){
		/* Establish a connection to the database with server address, username, and password. */
		String linkToDB = "jdbc:mysql://localhost:3306/audiofarm";
		String usernameForDB = "adminaudiofarm";
		String passwordForDB = "b9YMpCFtm9QPxCjv";
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		Connection connection = DriverManager.getConnection(linkToDB, usernameForDB, passwordForDB);
		Statement statement = connection.createStatement();

		/* Update all song related fields in the database. */
		String query = "UPDATE artist SET name='"
		+ name + "', 				artist='"
		+ artist + "', 				album='"
		+ album + "', 				year='"
		+ year + "', 				time='"
		+ duration + "', 			price='"
		+ doublePrice + "', 		quantity='"
		+ intQuantity + "', 		genre='"
		+ genre + "' WHERE id='" + id + "'";

		statement.executeUpdate(query);

		message = "<h2>Artist details were successfully stored in the database.</h2>";

	/* Remove a selected song. */
	} else if(action.startsWith("remove")) {
		/* Establish a connection to the database with server address, username, and password. */
		String linkToDB = "jdbc:mysql://localhost:3306/audiofarm";
		String usernameForDB = "adminaudiofarm";
		String passwordForDB = "b9YMpCFtm9QPxCjv";
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		Connection connection = DriverManager.getConnection(linkToDB, usernameForDB, passwordForDB);
		Statement statement = connection.createStatement();

		/* Delete the selected song by id. */
		String queryDelete = "DELETE FROM artist WHERE id='" + id + "'";
		statement.executeUpdate(queryDelete);
		message = "<h2>The user was successfully deleted from the database.</h2>";
	}
}
%>

<%= message %>
</body>
</html>