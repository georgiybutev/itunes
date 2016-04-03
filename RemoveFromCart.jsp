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
	<title>Audio Farm Remove Songs to Cart</title>
</head>
<body>
<a href="User.jsp">Home</a>
<a href="Logout.jsp">Logout</a>

<!-- Remove Songs from Cart -->

<%
/* Initialise song related variables. */
int index = 0;
ArrayList<String> songsId = new ArrayList<String>();
ArrayList<String> id = new ArrayList<String>();

/* Get all purchased songs from the session array. */
songsId = (ArrayList<String>) session.getAttribute("songsId");

/* Clone the session song id array to another id array. */
for(int i = 0; i<songsId.size(); i++){
	id.add(request.getParameter(String.valueOf(i)));
}
out.println(request.getParameter(String.valueOf(1)));

/* Remove only selected ids from the song ids array. */
for(int j = 0; j<id.size(); j++){
	if(songsId.contains(id.get(j))){
		index = songsId.indexOf(id.get(j));
		songsId.remove(index);
	} else {
		out.println("Nothing to remove");
	}
}

/* Replace the session song ids array with the updated array. */
session.removeAttribute("songsId");
session.setAttribute("songsId", songsId);

%>
<jsp:forward page="Cart.jsp" />
</body>
</html>