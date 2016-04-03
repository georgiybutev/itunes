<%@ page contentType="text/html" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<!-- Prevent unauthorised access to the web application. -->
<%
if(session.getAttribute("privileges") == null){
	pageContext.forward("Unauthorised.jsp");
}
%>

<html>
<head>
	<title>Audio Farm User Search</title>
</head>
<body>
<a href="User.jsp">Home</a>
<a href="Logout.jsp">Logout</a>

<!-- Search for songs -->

<%
/* Initialise song related variables. */
ArrayList<String> id = new ArrayList<String>();
ArrayList<String> name = new ArrayList<String>();
ArrayList<String> artist = new ArrayList<String>();
ArrayList<String> album = new ArrayList<String>();
ArrayList<String> year = new ArrayList<String>();
ArrayList<String> duration = new ArrayList<String>();
ArrayList<String> price = new ArrayList<String>();
ArrayList<String> quantity = new ArrayList<String>();
ArrayList<String> genre = new ArrayList<String>();
ArrayList<String> album_art = new ArrayList<String>();
/* Initialise database related variables. */
String keyword = null;
String searchType = null;
String linkToDB;
String username;
String password;
Connection connection;
Statement statement;
ResultSet result;
String query = null;

try{
	/* Get the submitted search keyword. */
	keyword = request.getParameter("keyword");
	//out.println("keyword: " + keyword);
	/* Get the submitted search criterion. */
	searchType = request.getParameter("searchType");
	//out.println("option: " + searchType);

	/* Establish a connection to the database with server address, username, and password. */
	linkToDB = "jdbc:mysql://localhost:3306/audiofarm";
	username = "adminaudiofarm";
	password = "b9YMpCFtm9QPxCjv";
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	connection = DriverManager.getConnection(linkToDB,username,password);
	statement = connection.createStatement();

	/* Search for a song in the database that matches the user submitted keyword and the user submitted column (criterion). */
	query = "SELECT * FROM artist WHERE MATCH (" + searchType + ") AGAINST ('+" + keyword + "' IN BOOLEAN MODE)";
	result = statement.executeQuery(query);

	/* Iterate over the result until all song related details are assign. */
	while(result.next()){
		id.add(result.getString(1));
		name.add(result.getString(2));
		artist.add(result.getString(3));
		album.add(result.getString(4));
		year.add(result.getString(5));
		duration.add(result.getString(6));
		price.add(result.getString(7));
		quantity.add(result.getString(8));
		album_art.add(result.getString(9));
		genre.add(result.getString(10));
	}

} catch (NullPointerException exception){
	/* Notify the user if no results were found. */
	out.println("No results were found.");
}

%>

<form method="POST" action="AddSongsToCart.jsp">
<table border=1 color="black">
<th>Name</th><th>Artist</th><th>Album</th><th>Year</th><th>Time</th><th>Price</th><th>Quantity</th><th>Genre</th><th>Album Art</th><th>Buy</th>
<% 
/* Iterate over the found songs arrays until all data is shown to the user. */
for (int i = 0; i<id.size(); i++){
			out.println("<tr>");
			out.println("<td>" + name.get(i) + "</td>");
			out.println("<td>" + artist.get(i) + "</td>");
			out.println("<td>" + album.get(i) + "</td>");
			out.println("<td>" + year.get(i) + "</td>");
			out.println("<td>" + duration.get(i) + "</td>");
			out.println("<td>" + price.get(i) + "</td>");
			out.println("<td>" + quantity.get(i) + "</td>");
			out.println("<td>" + genre.get(i) + "</td>");
			out.println("<td><img src=\"" + album_art.get(i) + "\" width=\"60\" heigth=\"60\" /></td>");
			out.println("<input type=\"hidden\" name=\"submitted\" value=\"yes\" />");
			out.println("<td><input type=\"checkbox\" name=\"" + id.get(i) + "\" value=\"" + id.get(i) + "\" /></td>");
			out.println("</tr>");
}
%>
</table>
<br/><input type="submit" name="submit" value="Purchase" />
</form>
</body>