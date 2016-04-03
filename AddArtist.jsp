<%@ page contentType="text/html" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!-- Prevent unauthorise access to the database -->
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

<!-- Get form contents and add artist to the database -->
<%
String message = "";
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
price.trim();
String quantity = request.getParameter("quantity");
quantity.trim();
String genre = request.getParameter("genre");
genre.trim();
String album_art = "default.jpg";
Double doublePrice = Double.parseDouble(price);
int intQuantity = Integer.parseInt(quantity);

/* Perform simple form validation. Check whether a form is empty. */
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

	/* Establish connection to the database with server address, username and password */
	String linkToDB = "jdbc:mysql://localhost:3306/audiofarm";
	String usernameForDB = "adminaudiofarm";
	String passwordForDB = "b9YMpCFtm9QPxCjv";
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	Connection connection = DriverManager.getConnection(linkToDB, usernameForDB, passwordForDB);
	Statement statement = connection.createStatement();

	/* Insert the data supplied by the HTML form to the database. */
	String query = "INSERT INTO artist (id, name, artist, album, year, time, price, quantity, album_art, genre) VALUES (NULL,'" 
		+ name + "', '" 
		+ artist + "', '" 
		+ album + "', '" 
		+ year + "', '" 
		+ duration + "', '" 
		+ doublePrice + "', '" 
		+ intQuantity + "', '"
		+ album_art + "', '"
		+ genre + "')";

	statement.executeUpdate(query);

	message = "<h2>Artist details were successfully stored in the database.</h2>";
}

%>
<%= message %>
</body>
</html>