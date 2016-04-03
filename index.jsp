<%@ page contentType="text/html" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<html>
<head>
	<title>Audio Farm Home</title>
</head>
<body>
<a href="Login.jsp">Login</a>
<a href="Register.jsp">Register</a>

<!-- Get all songs for sale -->
<%
/* Initialise song related variables */
ArrayList<String> id = new ArrayList<String>();
ArrayList<String> name = new ArrayList<String>();
ArrayList<String> artist = new ArrayList<String>();
ArrayList<String> album = new ArrayList<String>();
ArrayList<String> year = new ArrayList<String>();
ArrayList<String> duration = new ArrayList<String>();
ArrayList<String> price = new ArrayList<String>();
ArrayList<String> quantity = new ArrayList<String>();
ArrayList<String> album_art = new ArrayList<String>();
ArrayList<String> genre = new ArrayList<String>();

try{
	/* Establish a connection to the database with server address, username, and password. */
	String linkToDB = "jdbc:mysql://localhost:3306/audiofarm";
	String username = "adminaudiofarm";
	String password = "b9YMpCFtm9QPxCjv";
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	Connection connection = DriverManager.getConnection(linkToDB,username,password);
	Statement statement = connection.createStatement();

	/* Select all songs from the artist database table */
	String query = "SELECT* FROM`artist` LIMIT 0 , 30";

	/* Iterate over the results until all song details are assigned. */
	ResultSet resultSet = statement.executeQuery(query);
	while(resultSet.next()){
		id.add(resultSet.getString(1));
		name.add(resultSet.getString(2));
		artist.add(resultSet.getString(3));
		album.add(resultSet.getString(4));
		year.add(resultSet.getString(5));
		duration.add(resultSet.getString(6));
		price.add(resultSet.getString(7));
		quantity.add(resultSet.getString(8));
		album_art.add(resultSet.getString(9));
		genre.add(resultSet.getString(10));
	}

}catch(Exception exception){
	out.println("Could not retrieve data from the database.");
}

%>
<a href="#" style="text-decoration: none">Cart: 0<img src="img/basket-empty.png" style="border: none"/></a>
<h1>Welcome to Audio Farm</h1>
<table border=1 color="black">
<th>ID</th><th>Name</th><th>Artist</th><th>Album</th><th>Year</th><th>Time</th><th>Price</th><th>Quantity</th><th>Genre</th><th>Album Art</th>
<% 
/* Iterate over the database songs arrays until all data is shown to the user. */
for (int i = 0; i<id.size(); i++){
			out.println("<tr>");
			out.println("<td>" + id.get(i) + "</td>");
			out.println("<td>" + name.get(i) + "</td>");
			out.println("<td>" + artist.get(i) + "</td>");
			out.println("<td>" + album.get(i) + "</td>");
			out.println("<td>" + year.get(i) + "</td>");
			out.println("<td>" + duration.get(i) + "</td>");
			out.println("<td>" + price.get(i) + "</td>");
			out.println("<td>" + quantity.get(i) + "</td>");
			out.println("<td>" + genre.get(i) + "</td>");
			out.println("<td><img src=\"" + album_art.get(i) + "\" width=\"60\" heigth=\"60\" /></td></form></tr>");
			out.println("</tr>");
}
%>
</table>

</body>
</html>