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
	<title>Audio Farm User Home</title>
</head>
<body>
<a href="User.jsp">Home</a>
<a href="History.jsp">History</a>
<a href="Logout.jsp">Logout</a>

<!-- Show songs and enable user to buy -->

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
String basket = "";
String message = "";

try{
	/* Establish a connection to the database with server address, username, and password. */
	String linkToDB = "jdbc:mysql://localhost:3306/audiofarm";
	String username = "adminaudiofarm";
	String password = "b9YMpCFtm9QPxCjv";
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	Connection connection = DriverManager.getConnection(linkToDB,username,password);
	Statement statement = connection.createStatement();

	/* Get all data from the artist table in the database. */
	String query = "SELECT* FROM`artist` LIMIT 0 , 30";
	ResultSet resultSet = statement.executeQuery(query);
	
	/* Iterate over the results until all song data is assigned. */
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

	/* Select the currently logged in user's surname and gender. */
	String queryGetName = "SELECT id, surname, gender FROM user WHERE id = " + session.getAttribute("userId") + "";
	ResultSet resultGetName = statement.executeQuery(queryGetName);
	/* Iterate over the results to construct a welcome message such as Mr. Gates or Mrs. Clinton. */
	while(resultGetName.next()){
		if(resultGetName.getString(3).startsWith("Male")){
			message = "Mr. " + resultGetName.getString(2);
		} else if(resultGetName.getString(3).startsWith("Female")){
			message = "Mrs. " + resultGetName.getString(2);
		}
	}

}catch(Exception exception){
	/* Notify the user upon failure. */
	out.println("Could not retrieve data from the database.");
}

/* Initialise cart realated variables. */
ArrayList<String> cartItemsArrayList = new ArrayList<String>();
int cartItems;

/* Get all song ids from the session unless empty. */
if(session.getAttribute("songsId") != null){
	cartItemsArrayList = (ArrayList<String>) session.getAttribute("songsId");
	/* Get the number of songs in the session array. */
	cartItems = cartItemsArrayList.size();
} else {
	cartItems = 0;
}

if(cartItems == 0){
	/* If the number of songs in the session array is zero - show an empty basket to the user. */
	basket = "img/basket-empty.png";
} else {
	/* If the number of songs in the session array is zero - show full basket to the user. */
	basket = "img/basket-full.png";
}

%>

<a href="Cart.jsp" style="text-decoration: none">Cart: <%= cartItems %><img src="<%= basket %>" style="border: none"/></a>
<h1>Welcome <%= message %>!</h1>

<form method="POST" action="Search.jsp">
Search for: <input type="text" name="keyword" />
<select name="searchType">
	<option value="name">Song Name</option>
	<option value="artist">Artist</option>
	<option value="album">Album</option>
</select>
<input type="submit" value="Search" />
</form>

<form method="POST" action="AddSongsToCart.jsp">
<table border=1 color="black">
<th>Name</th><th>Artist</th><th>Album</th><th>Year</th><th>Time</th><th>Price</th><th>Quantity</th><th>Genre</th><th>Album Art</th><th>Buy</th>
<% 
/* Iterate over the songs arrays until all data is shown to the user. */
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
</html>