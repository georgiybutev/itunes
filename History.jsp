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
	<title>Audio Farm History</title>
</head>
<body>
<a href="User.jsp">Home</a>
<a href="Logout.jsp">Logout</a>

<!-- User History -->

<%
/* Initialise song related variables */
String message = "";
ArrayList<String> user_id = new ArrayList<String>();
ArrayList<String> song_id = new ArrayList<String>();
ArrayList<String> name = new ArrayList<String>();
ArrayList<String> artist = new ArrayList<String>();
ArrayList<String> album = new ArrayList<String>();
ArrayList<String> year = new ArrayList<String>();
ArrayList<String> time = new ArrayList<String>();
ArrayList<String> price = new ArrayList<String>();
ArrayList<String> album_art = new ArrayList<String>();
/* Initialise recommended song related variables */
ArrayList<String> nameRecommend = new ArrayList<String>();
ArrayList<String> artistRecommend = new ArrayList<String>();
ArrayList<String> albumRecommend = new ArrayList<String>();
ArrayList<String> yearRecommend = new ArrayList<String>();
ArrayList<String> timeRecommend = new ArrayList<String>();
ArrayList<String> priceRecommend = new ArrayList<String>();
ArrayList<String> album_artRecommend = new ArrayList<String>();
ArrayList<String> quantityRecommend = new ArrayList<String>();
ArrayList<String> genre = new ArrayList<String>();
ArrayList<String> genreRecommend = new ArrayList<String>();
int card = 0;

try{
	/* Establish a connection to the database with server address, username, and password. */
	String linkToDB = "jdbc:mysql://localhost:3306/audiofarm";
	String username = "adminaudiofarm";
	String password = "b9YMpCFtm9QPxCjv";
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	Connection connection = DriverManager.getConnection(linkToDB,username,password);
	Statement statement = connection.createStatement();

	/* Join the user, artist, and history tables into one. Then get all entries. */
	String query = "SELECT * FROM history LEFT JOIN artist ON history.song_id=artist.id LEFT JOIN user ON history.user_id=user.id WHERE history.user_id=" + session.getAttribute("userId") + " LIMIT 0, 30";

	/* Iterate over the results until all song details are assigned. */
	ResultSet result = statement.executeQuery(query);
	while(result.next()){
		name.add(result.getString(5));
		artist.add(result.getString(6));
		album.add(result.getString(7));
		year.add(result.getString(8));
		time.add(result.getString(9));
		price.add(result.getString(10));
		album_art.add(result.getString(12));
		genre.add(result.getString(13));
		card = Integer.parseInt(result.getString(26));
	}

	/* Get all songs from the database that match the purchased song's genre. */
	String queryRecommend = "SELECT * FROM artist WHERE genre='" + genre.get(0) + "'";

	/* Iterate over the result until all recommended song details are assigned. */
	ResultSet resultRecommend = statement.executeQuery(queryRecommend);
	while(resultRecommend.next()){
		nameRecommend.add(resultRecommend.getString(2));
		artistRecommend.add(resultRecommend.getString(3));
		albumRecommend.add(resultRecommend.getString(4));
		yearRecommend.add(resultRecommend.getString(5));
		timeRecommend.add(resultRecommend.getString(6));
		priceRecommend.add(resultRecommend.getString(7));
		quantityRecommend.add(resultRecommend.getString(8));
		album_artRecommend.add(resultRecommend.getString(9));
		genreRecommend.add(resultRecommend.getString(10));
	}

} catch(Exception exception){
	message = "Could not retrieve data from the database.";
}

%>

<h1><%= message %></h1>
<h2>Recently Purchased Songs</h2>
<h3>Remaining Credit: &#163; <%= card %></h3>
<table border=1 color="black">
	<th>Song Name</th><th>Artist</th><th>Album</th><th>Year</th><th>Duration</th><th>Price</th><th>Genre</th><th>Album Art</th>
	<% 
	/* Iterate over the purchased songs arrays until all data is shown to the user. */
	for(int i = 0; i<name.size(); i++){
		out.println("<tr><td>" + name.get(i) + "</td>");
		out.println("<td>" + artist.get(i) + "</td>");
		out.println("<td>" + album.get(i) + "</td>");
		out.println("<td>" + year.get(i) + "</td>");
		out.println("<td>" + time.get(i) + "</td>");
		out.println("<td>" + price.get(i) + "</td>");
		out.println("<td>" + genre.get(i) + "</td>");
		out.println("<td><img src=\"" + album_art.get(i) + "\" width=\"60\" height=\"60\" /></td></tr>");
	}
	%>
</table>
<h2>We recommend you:</h2>
<table border=1 color="black">
	<th>Song Name</th><th>Artist</th><th>Album</th><th>Year</th><th>Duration</th><th>Price</th><th>Quantity</th><th>Genre</th><th>Album Art</th>
	<% 
	/* Iterate over the recommended songs arrays until all data is shown to the user. */
	for (int j = 0;j<nameRecommend.size(); j++){
		out.println("<tr><td>" + nameRecommend.get(j) + "</td>");
		out.println("<td>" + artistRecommend.get(j) + "</td>");
		out.println("<td>" + albumRecommend.get(j) + "</td>");
		out.println("<td>" + yearRecommend.get(j) + "</td>");
		out.println("<td>" + timeRecommend.get(j) + "</td>");
		out.println("<td>" + priceRecommend.get(j) + "</td>");
		out.println("<td>" + quantityRecommend.get(j) + "</td>");
		out.println("<td>" + genreRecommend.get(j) + "</td>");
		out.println("<td><img src=\"" + album_artRecommend.get(j) + "\" width=\"60\" heigth=\"60\" /></td></tr>");
	}
	%>
</table>
</body>
</html>