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
	<title>Audio Farm Checkout</title>
</head>
<body>
<a href="User.jsp">Home</a>
<a href="Logout.jsp">Logout</a>

<!-- Checkout Procedure -->

<%
/* Initialise song related variables */
ArrayList<String> card = new ArrayList<String>();
ArrayList<String> songsId = new ArrayList<String>();
String message = "";
String name = "";
String artist = "";
String price = "";
String warning = "";
int songQuantity = 0;
Double budget = 0.0;

/* Get the all purchased song ids from the session variable */
songsId = (ArrayList<String>) session.getAttribute("songsId");

try{
	/* Establish a connection to the database with server address, username, and password. */
	String linkToDB = "jdbc:mysql://localhost:3306/audiofarm";
	String username = "adminaudiofarm";
	String password = "b9YMpCFtm9QPxCjv";
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	Connection connection = DriverManager.getConnection(linkToDB,username,password);
	Statement statement = connection.createStatement();
	//String index = (String) session.getAttribute("userId");

	/* Select all user columns matching the currently logged in user id. */
	String userBudget = "SELECT id, card FROM user WHERE id=" + session.getAttribute("userId") + "";

	/* Iterate over the array to find the user's credit card amount. */
	ResultSet resultBudget = statement.executeQuery(userBudget);
	while(resultBudget.next()){
		card.add(resultBudget.getString(2));
	}
} catch(Exception exception){
	out.println("Could not retrieve user data from the database.");
}

/* Iterate over the song ids array until all the user and song columns have been updated. */
for(int j = 0; j<songsId.size(); j++){
	//out.println(songsId.get(j));

	try{
		/* Establish a connection to the database with server address, username, and password. */
		String linkToDB = "jdbc:mysql://localhost:3306/audiofarm";
		String username = "adminaudiofarm";
		String password = "b9YMpCFtm9QPxCjv";
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		Connection connection = DriverManager.getConnection(linkToDB,username,password);
		Statement statementSongGet = connection.createStatement();

		/* Select all artist details matching the currently logged in user. */
		String querySongQuantity = "SELECT * FROM artist WHERE id ='" + songsId.get(j) + "'";

		/* Iterate until all user artist details are received. */
		ResultSet resultSongQuantity = statementSongGet.executeQuery(querySongQuantity);
		while(resultSongQuantity.next()){
			name = resultSongQuantity.getString(2);
			artist = resultSongQuantity.getString(3);
			price = resultSongQuantity.getString(7);
			songQuantity = Integer.parseInt(resultSongQuantity.getString(8));
		}

		/* Decrement the purchased song quantity unless it is zero. */
		if(songQuantity == 0){
			warning = "<h1>" + name + " by " + artist + " is temporary out of stock. </h1>";
		} else {
			songQuantity -= 1;
		}

		/* Perform floating point calculation to determine the final user credit card amount. */
		budget = Double.parseDouble(card.get(0)) - Double.parseDouble(price);
		//out.println(budget);
		
		/* Decrease the purchased song quantity in the database. */
		String queryUpdateSongQuantity = "UPDATE artist SET quantity='" + songQuantity + "' WHERE id ='" + songsId.get(j) + "'";
		statementSongGet.executeUpdate(queryUpdateSongQuantity);

		/* Decrease the user credit card amount in the database. */
		String queryUpdateUserBudget = "UPDATE user SET card=" + budget + " WHERE id =" + session.getAttribute("userId") + "";
		statementSongGet.executeUpdate(queryUpdateUserBudget);

		/* Update the past purchased song database table with the currently logged user id and purchased song ids. */
		String queryHistory = "INSERT INTO history (id, user_id, song_id) VALUES(NULL, " + session.getAttribute("userId") + ", " + songsId.get(j) + ")";
		statementSongGet.executeUpdate(queryHistory);

	} catch (Exception exception){
		out.println("Could not retrieve data from the database.");
	}

	message = "<h1>Your purchase was successful!</h1>";

	/* Remove the already purchased song ids from the session. */
	session.removeAttribute("songsId");
}

%>

<%= warning %>
<%= message %>

</body>
</html>