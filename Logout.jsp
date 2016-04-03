<%@ page contentType="text/html" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<html>
<head>
	<title>Audio Farm Logout</title>
</head>
<body>
<a href="index.jsp">Home</a>
<a href="Login.jsp">Login</a>

<!-- Terminate user or admin session -->
<%
/* Initialise session related variables. */
String message = null;
String username = (String) session.getAttribute("name");
Long sessionCreationTime = session.getCreationTime();
Long sessionLastTime = session.getLastAccessedTime();
Date humanTimeCreation = new Date(sessionCreationTime * 1000);
Date humanTimeLast = new Date(sessionLastTime * 1000);

try{
	/* Destroy the current session by removing user related attributes. */
	session.removeAttribute("userId");
	session.removeAttribute("name");
	session.removeAttribute("privileges");
	/* Used to notify which user has been logged out. */
	message = username;
} catch(NullPointerException e){
	message = "Logout problem" + e.toString();
}

if(message == null){
	/* The user session has automatically expired. */
	message = "Please login first.";
} else {
	/* Display user notification message. */
	message = message.concat(" was successfully logged out.<br/>");
	//message = message.concat("You started your session on: " + humanTimeCreation.getDate() + "/" + humanTimeCreation.getMonth() + "/" + humanTimeCreation.getYear() + "<br/>");
	//message = message.concat("The last time you logged in was at: " + humanTimeLast.getDate() + "/" + humanTimeLast.getMonth() + "/" + humanTimeLast.getYear());
}

%>

<h1><%= message %></h1>

</body>
</html>