<%@ page contentType="text/html" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!-- Prevent unauthorised access to the web application. -->
<%
if(session.getAttribute("privileges") == null){
	pageContext.forward("Unauthorised.jsp");
}
%>

<%
/* Establish a connection to the database with server address, username, and password. */
String linkToDB = "jdbc:mysql://localhost:3306/audiofarm";
String usernameForDB = "adminaudiofarm";
String passwordForDB = "b9YMpCFtm9QPxCjv";
Class.forName("com.mysql.jdbc.Driver").newInstance();
Connection connection = DriverManager.getConnection(linkToDB, usernameForDB, passwordForDB);
Statement statement = connection.createStatement();

/* Update the album art cover address - default img directory on the and user submited file name. */
String query = "UPDATE artist SET album_art='img/" + request.getParameter("link") + "' WHERE id=" + request.getParameter("id") + "";
statement.executeUpdate(query);

%>

<jsp:forward page="Admin.jsp" />