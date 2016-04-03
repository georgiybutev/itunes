<%@ page contentType="text/html" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>

<!-- Prevent unauthorise access to the web application -->
<%
if(session.getAttribute("privileges") == null){
	pageContext.forward("Unauthorised.jsp");
}
%>

<html>
<head>
	<title>Audio Farm add Songs to Cart</title>
</head>
<body>
<a href="User.jsp">Home</a>
<a href="Logout.jsp">Logout</a>

<!-- Add songs to cart -->

<%
/* Initialise arrays to store songs' details. */
ArrayList<String> id = new ArrayList<String>();
ArrayList<String> songsId = new ArrayList<String>();
String message = "";

ArrayList<String> name = new ArrayList<String>();
ArrayList<String> artist = new ArrayList<String>();
ArrayList<String> album = new ArrayList<String>();
ArrayList<String> year = new ArrayList<String>();
ArrayList<String> duration = new ArrayList<String>();
ArrayList<String> price = new ArrayList<String>();
ArrayList<String> quantity = new ArrayList<String>();
ArrayList<String> genre = new ArrayList<String>();
ArrayList<String> album_art = new ArrayList<String>();

try{
	
	/* Establish connection to the databse using the server address, username, and password */
	String linkToDB = "jdbc:mysql://localhost:3306/audiofarm";
	String username = "adminaudiofarm";
	String password = "b9YMpCFtm9QPxCjv";
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	Connection connection = DriverManager.getConnection(linkToDB,username,password);

	Statement statement = connection.createStatement();

	/* Retriece all data from the artist's table. */
	String query = "SELECT * FROM artist LIMIT 0 , 30";
	ResultSet resultSet = statement.executeQuery(query);
	
	/* Get the first id from the query. */
	while(resultSet.next()){
		id.add(resultSet.getString(1));
	}

}catch(Exception exception){
	out.println("Could not retrieve data from the database.");
}

/* Get selected songs from the form. Add all non null to an array list. Set session variable using the array list. */
for(int i = 0; i<id.size(); i++){
	if(request.getParameter(id.get(i)) != null ){
		songsId.add(request.getParameter(id.get(i)));
		session.setAttribute("songsId", songsId);
	}
}

/* Iterate limited by the size of the songs array. This is necessary for the SQL statement. */
for(int j = 0; j<songsId.size(); j++){
	String linkToDB = "jdbc:mysql://localhost:3306/audiofarm";
	String username = "adminaudiofarm";
	String password = "b9YMpCFtm9QPxCjv";
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	Connection connection = DriverManager.getConnection(linkToDB,username,password);

	Statement statementSong = connection.createStatement();

	/* Retrieve all data from the artist table where there is match against the user id. */
	String querySong = "SELECT * FROM artist WHERE id = " + songsId.get(j) + " ";
	ResultSet resultSetSong = statementSong.executeQuery(querySong);

	/* Iterate until all data is stored into the song related arrays. This is used for the HTML display. */
	while(resultSetSong.next()){
		name.add(resultSetSong.getString(2));
		artist.add(resultSetSong.getString(3));
		album.add(resultSetSong.getString(4));
		year.add(resultSetSong.getString(5));
		duration.add(resultSetSong.getString(6));
		price.add(resultSetSong.getString(7));
		quantity.add(resultSetSong.getString(8));
		album_art.add(resultSetSong.getString(9));
		genre.add(resultSetSong.getString(10));
	}
}

/*
ArrayList<String> result = new ArrayList<String>();
result = (ArrayList<String>) session.getAttribute("songsId");
for(int j = 0; j<result.size(); j++){
	out.println(result.get(j));	
}
*/

%>

<h1><%= message %></h1>

<h1>User <%= session.getAttribute("name") %> added to cart!</h1>
<form method="POST" action="Checkout.jsp">
<table border=1 color="black">
<th>Name</th><th>Artist</th><th>Album</th><th>Year</th><th>Time</th><th>Price</th><th>Quantity</th><th>Genre</th><th>Album Art</th>
<%
/* Iterate until all song related array data has been displayed to the user. */
for (int i = 0; i<name.size(); i++){
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
			out.println("</tr>");
}
%>
</table>
<br/><input type="submit" value="Checkout" />

</body>
</html>