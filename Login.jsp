<%@ page contentType="text/html" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<html>
<head>
	<title>Audio Farm Login</title>
</head>
<body>
<a href="index.jsp">Home</a>
<a href="Register.jsp">Register</a>

<form name="login" id="login" method="POST" action="ProcessLogin.jsp">
	<table>
		<tr>
			<img src="img/checklist.png"/>
		</tr>
		<tr>
			<td>Username: </td>
			<td><input type="text" id="username" name="username"/></td>
		</tr>
		<tr>
			<td>Password: </td>
			<td><input type="password" id="password" name="password"/></td>
		</tr>
		<tr>
			<td><input type="submit" id="submit" name="submit" value="Login"/></td>
			<td><input type="reset" id="reset" name="reset" value="Try Again"></td>
		</tr>
	</table>
</form>

</body>
</html>