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

<!-- Show items in cart -->

<%
/* Initialise songs related arrays. */
String message = "";
int budget = 0;
ArrayList<String> songsId = new ArrayList<String>();
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
ArrayList<String> card = new ArrayList<String>();

/* Get the purchased song id from the session variable */
songsId = (ArrayList<String>) session.getAttribute("songsId");

try{
	for(int j = 0; j<songsId.size(); j++){
		
		/* Establish connection with server address, username, and password. */
		String linkToDB = "jdbc:mysql://localhost:3306/audiofarm";
		String username = "adminaudiofarm";
		String password = "b9YMpCFtm9QPxCjv";
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		Connection connection = DriverManager.getConnection(linkToDB,username,password);

		Statement statement = connection.createStatement();

		/* Retrieve all songs details match against the already assigned song id variable. */
		String query = "SELECT * FROM artist WHERE id ='" + songsId.get(j) + "'";
		ResultSet result = statement.executeQuery(query);

		/* Iterate until all song related data is store into the arrays. */
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
	}

} catch(NullPointerException exception){
	message = "The basket is empty.";
} catch(Exception exception){
	out.println("Could not retrieve data from the database.");
}

try{
	/* Establish connection with server address, username, and password. */
	String linkToDB = "jdbc:mysql://localhost:3306/audiofarm";
	String username = "adminaudiofarm";
	String password = "b9YMpCFtm9QPxCjv";
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	Connection connection = DriverManager.getConnection(linkToDB,username,password);

	Statement statement = connection.createStatement();
	//String index = (String) session.getAttribute("userId");

	/* Retrieve all id and card data from the user table match against the current user id. */
	String userBudget = "SELECT id, card FROM user WHERE id=" + session.getAttribute("userId") + "";
	ResultSet resultBudget = statement.executeQuery(userBudget);

	/* Get the amount of resource from the card for the user */
	while(resultBudget.next()){
		card.add(resultBudget.getString(2));
	}
} catch(Exception exception){
	out.println("Could not retrieve user data from the database.");
}

%>
<h1><%= message %></h1>
<h2>You have &#163;<% out.println(card.get(0)); %> available in yout bank account.</h2>
<form method="POST" action="RemoveFromCart.jsp">
<table border=1 color="black">
<th>Name</th><th>Artist</th><th>Album</th><th>Year</th><th>Time</th><th>Price</th><th>Quantity</th><th>Genre</th><th>Album Art</th><th>Remove</th>
<% 
/* Iterate over the already assigned arrays to display all songs details. */
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
			out.println("<td><img src=\"" + album_art.get(i) + "\" width=\"60\" height=\"60\" /></td>");
			out.println("<td><input type=\"checkbox\" name=\""+ i +"\" value=\"" + id.get(i) + "\" /></td>");
			out.println("</tr>");
}
%>
</table>
<br/><input type="submit" value="Remove" />
</form>

<form method="POST" action="Checkout.jsp">
<input type="hidden" name="fromCart" value="yes" />
<input type="submit" value="Proceed" />
</form>

</body>
</body>
</html>