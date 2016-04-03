<%@ page contentType="text/html" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<!-- Prevent unauthorised access to the web application -->
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

<!-- Show songs and enable admin to add, edit, and remove -->
<%
String welcomeName = "";
/* Variables for artist table */
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

/* Variables for user table */
ArrayList<String> queryUserId = new ArrayList<String>();
ArrayList<String> forname = new ArrayList<String>();
ArrayList<String> surname = new ArrayList<String>();
ArrayList<String> gender = new ArrayList<String>();
ArrayList<String> country = new ArrayList<String>();
ArrayList<String> city = new ArrayList<String>();
ArrayList<String> email = new ArrayList<String>();
ArrayList<String> username = new ArrayList<String>();
ArrayList<String> password = new ArrayList<String>();
ArrayList<String> secretQuestion = new ArrayList<String>();
ArrayList<String> secretAnswer = new ArrayList<String>();
ArrayList<String> dateofbirth = new ArrayList<String>();
ArrayList<String> card = new ArrayList<String>();
ArrayList<String> admin = new ArrayList<String>();

/* Database login details */
String linkToDB = null;
String usernameDB = null;
String passwordDB = null;
Connection connection;
Statement statement;
String query = null;
String queryAdminName = null;
ResultSet resultSet;
ResultSet resultAdminName;

try{

	/* Establish connection with server address, username, and password */
	linkToDB = "jdbc:mysql://localhost:3306/audiofarm";
	usernameDB = "adminaudiofarm";
	passwordDB = "b9YMpCFtm9QPxCjv";
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	connection = DriverManager.getConnection(linkToDB,usernameDB,passwordDB);

	statement = connection.createStatement();

	/* Retrieve all data from the artist table. This is displayed to the user. */
	query = "SELECT * FROM artist LIMIT 0 , 30";
	resultSet = statement.executeQuery(query);
	
	/* Iterate until all artist related data has been store in the arrays. */
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
	out.println("Could not retrieve data from the artist database.");
}

try{

	/* Establish connection with server address, username, and password. */
	linkToDB = "jdbc:mysql://localhost:3306/audiofarm";
	usernameDB = "adminaudiofarm";
	passwordDB = "b9YMpCFtm9QPxCjv";
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	connection = DriverManager.getConnection(linkToDB,usernameDB,passwordDB);

	statement = connection.createStatement();

	/* Retrieve all data from the user table. This is displayed to the user. */
	query = "SELECT * FROM user LIMIT 0 , 30";
	resultSet = statement.executeQuery(query);
	/* Iterate until all artist related data has been store in the arrays. */
	while(resultSet.next()){
		queryUserId.add(resultSet.getString(1));
		forname.add(resultSet.getString(2));
		surname.add(resultSet.getString(3));
		gender.add(resultSet.getString(4));
		country.add(resultSet.getString(5));
		city.add(resultSet.getString(6));
		email.add(resultSet.getString(7));
		username.add(resultSet.getString(8));
		password.add(resultSet.getString(9));
		secretQuestion.add(resultSet.getString(10));
		secretAnswer.add(resultSet.getString(11));
		dateofbirth.add(resultSet.getString(12));
		card.add(resultSet.getString(13));
		admin.add(resultSet.getString(14));
	}

	/* Retrieve id and name data from the database match against the current user's identification. */
	queryAdminName = "SELECT id, forname FROM user WHERE id ='" + session.getAttribute("userId") + "'";
	resultAdminName = statement.executeQuery(queryAdminName);

	/* Iterate over the results and assign the name to the string variable. This is used to welcome the user by his/her name. */
	while(resultAdminName.next()){
		welcomeName = resultAdminName.getString(2);
	}

} catch(Exception exception) {
	out.println("Could not retrieve data from the user database.");
}

%>

<h1>Welcome <%= welcomeName %>!</h1>
<a href="#">Manage Songs Details.</a>
<table id="artists" border="1" color="black">
	<th>ID</th><th>Name</th><th>Artist</th><th>Album</th><th>Year</th><th>Time</th><th>Price</th><th>Quantity</th><th>Genre</th><th>Action</th>
		<% 
		/* Display all songs' details using the already assigned arrays. */
		for (int i = 0; i<id.size(); i++){
			out.println("<tr><form method=\"POST\" action=\"ModifyArtistDetails.jsp\">");
			out.println("<td><input readonly=\"readonly\" type=\"text\" value=\"" + id.get(i) + "\" name=\"id\" size=\"2\"/></td>");
			out.println("<td><input type=\"text\" value=\"" + name.get(i) + "\" name=\"name\" maxlength=\"25\"/></td>");
			out.println("<td><input type=\"text\" value=\"" + artist.get(i) + "\" name=\"artist\" maxlength=\"25\"/></td>");
			out.println("<td><input type=\"text\" value=\"" + album.get(i) + "\" name=\"album\" maxlength=\"25\"/></td>");
			out.println("<td><input type=\"text\" value=\"" + year.get(i) + "\" name=\"year\" size=\"4\" maxlength=\"4\"/></td>");
			out.println("<td><input type=\"text\" value=\"" + duration.get(i) + "\" name=\"duration\" size=\"5\"maxlength=\"5\"/></td>");
			out.println("<td><input type=\"text\" value=\"" + price.get(i) + "\" name=\"price\" size=\"4\" maxlength=\"4\"/></td>");
			out.println("<td><input type=\"text\" value=\"" + quantity.get(i) + "\" name=\"quantity\" size=\"5\" maxlength=\"5\"/></td>");
			out.println("<td><input type=\"text\" value=\"" + genre.get(i) + "\" name=\"genre\" size=\"5\" maxlength=\"5\"/></td>");
			out.println("<td><select name=\"action\"><option value=\"edit\">Edit</option><option value=\"remove\">Remove</option></select><br/><input type=\"submit\" value=\"Perform\" name=\"submit\"/></td></tr></tr></form>");
		} %>
	<tr>
		<form method="POST" action="AddArtist.jsp">
			<td>
				?
			</td>
			<td><input type="text" name="name" maxlength="25"/></td>
			<td><input type="text" name="artist" maxlength="25"/></td>
			<td><input type="text" name="album" maxlength="25"/></td>
			<td><input type="text" name="year" size="4" maxlength="4"/></td>
			<td><input type="text" name="duration" size="5" maxlength="5"/></td>
			<td><input type="text" name="price" size="4" maxlength="4"/></td>
			<td><input type="text" name="quantity" size="5" maxlength="5"/></td>
			<td><input type="text" name="genre" size="5" maxlength="5"/></td>
			<td>
				<select>
					<option value="Add">Add</option>
				</select>
				<br/>
				<input type="submit" value="Perform" name="submit"/>
			</td>
		</form>
	</tr>
</table>

<a href="#">Upload Album Art</a>
<table id="album" border="1" color="black">
	<th>ID</th><th>Album</th><th>Link Name</th><th>Action</th><th>Album Art</th>
	<% 
	/* Display all the album art data using the already assigned arrays. */
	for (int i = 0; i<id.size(); i++){
			out.println("<tr><form method=\"POST\" action=\"LinkAlbumArt.jsp\">");
			out.println("<td><input readonly=\"readonly\" type=\"text\" value=\"" + id.get(i) + "\" name=\"id\" size=\"2\"/></td>");
			out.println("<td><input type=\"text\" value=\"" + album.get(i) + "\" name=\"album\" maxlength=\"25\"/></td>");
			out.println("<td><input type=\"text\" name=\"link\" value=\"" + album_art.get(i) + "\" /></td>");
			out.println("<td><input type=\"submit\" name=\"submit\" value=\"Update\" /></td>");
			out.println("<td><img src=\"" + album_art.get(i) + "\" width=\"60\" height=\"60\" /></td></form></tr>");
	}
	%>
</table>

<form action="UploadAlbumArt.jsp" method="POST" enctype="multipart/form-data">
	<input type="file" name="file"/>
	<input type="submit" name="submit" value="Upload" />
</form>

<a href="#">Manage Users</a>
<table id="users" border="1" color="black">
	<th>ID</th><th>Forname</th><th>Surname</th><th>Gender</th><th>Country</th><th>City</th><th>Email</th><th>Username</th><th>Password</th><th>Secret Question</th><th>Secret Answer</th><th>Date of Birth</th><th>Card</th><th>Admin</th><th>Action</th>
		<% 
		/* Display all users' details from the already assigned arrays. */
		for (int j=0; j<queryUserId.size(); j++){
			out.println("<tr><form method=\"POST\" action=\"ModifyUserDetails.jsp\">");
			out.println("<td><input readonly=\"readonly\" type=\"text\" value=\"" + queryUserId.get(j) + "\" name=\"queryUserId\" size=\"2\"</td>");
			out.println("<td><input type=\"text\" value=\"" + forname.get(j) + "\" name=\"forname\"</td>");
			out.println("<td><input type=\"text\" value=\"" + surname.get(j) + "\" name=\"surname\"</td>");
			out.println("<td><input type=\"text\" value=\"" + gender.get(j) + "\" name=\"gender\"</td>");
			out.println("<td><input type=\"text\" value=\"" + country.get(j) + "\" name=\"country\"</td>");
			out.println("<td><input type=\"text\" value=\"" + city.get(j) + "\" name=\"city\"</td>");
			out.println("<td><input type=\"text\" value=\"" + email.get(j) + "\" name=\"email\"</td>");
			out.println("<td><input type=\"text\" value=\"" + username.get(j) + "\" name=\"username\"</td>");
			out.println("<td><input type=\"text\" value=\"" + password.get(j) + "\" name=\"password\"</td>");
			out.println("<td><input type=\"text\" value=\"" + secretQuestion.get(j) + "\" name=\"secretQuestion\"</td>");
			out.println("<td><input type=\"text\" value=\"" + secretAnswer.get(j) + "\" name=\"secretAnswer\"</td>");
			out.println("<td><input type=\"text\" value=\"" + dateofbirth.get(j) + "\" name=\"dateofbirth\"</td>");
			out.println("<td><input type=\"text\" value=\"" + card.get(j) + "\" name=\"card\"</td>");
			out.println("<td><input type=\"text\" value=\"" + admin.get(j) + "\" name=\"admin\"</td>");
			out.println("<td><select name=\"action\"><option value=\"edit\">Edit</option><option value=\"remove\">Remove</option></select><br/><input type=\"submit\" value=\"Perform\" name=\"submit\"/></td></tr></form>");
		} %>
	</form>
				
	<tr>
		<form method="POST" action="AddUser.jsp">
			<td>
				?
			</td>
			<td><input type="text" name="forname" maxlength="25"/></td>
			<td><input type="text" name="surname" maxlength="25"/></td>
			<td><input type="text" name="gender" maxlength="6"/></td>
			<td><input type="text" name="country" maxlength="25"/></td>
			<td><input type="text" name="city" maxlength="25"/></td>
			<td><input type="text" name="email" maxlength="25"/></td>
			<td><input type="text" name="username" maxlength="25"/></td>
			<td><input type="text" name="password" maxlength="25"/></td>
			<td><input type="text" name="secretQuestion" maxlength="25"/></td>
			<td><input type="text" name="secretAnswer" maxlength="25"/></td>
			<td><input type="text" name="dateofbirth" maxlength="25"/></td>
			<td><input type="text" name="card" maxlength="25"/></td>
			<td><input type="text" name="admin" maxlength="3"/></td>
			<td>
				<select>
					<option value="Add">Add</option>
				</select>
				<br/>
				<input type="submit" value="Perform" name="submit"/>
			</td>
		</form>
	</tr>
</table>
<a href="#top">Back to the top.</a>
</body>
</html>