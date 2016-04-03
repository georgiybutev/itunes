<%@ page contentType="text/html" %>
<%@ page pageEncoding="UTF-8" %>
<html>
<head>
	<title>Audio Farm Register</title>
</head>
<body>
<a href="index.jsp">Home</a>

<h1>Please, register to buy items<br/> and view your shopping cart.</h1>

<form name="register" id="register" method="POST" action="ProcessRegistration.jsp">
	<table>
	<tr>
		<td><img src="img/chat-support.png"/></td>
	</tr>
	<tr>
		<td>
			<label for="forname">Forname: </label>
		</td>
		<td>
			<input type="text" name="forname" id="forname"/>
		</td>

	</tr>
	<tr>
		<td>
			<label for="surname">Surname: </label>
		</td>
		<td>
			<input type="text" name="surname" id="surname"/>
		</td>

	</tr>
	<tr>
		<td>
			<label for="gender">Gender: </label>
		</td>
		<td>
			<input type="radio" name="gender" id="gender" value="Male" checked="checked"/>Male
			<input type="radio" name="gender" id="gender" value="Female"/>Female
		</td>
	</tr>
	<tr>
		<td>
			<label for="country">Country: </label>
		</td>
		<td>
			<select name="country" id="country">
				<option value="England">England</option>
				<option value="Wales">Wales</option>
				<option value="Scotland">Scotland</option>
				<option value="Nothern Ireland">Northern Ireland</option>
				<option value="Republic of Ireland">&#201;ire</option>
			</select>
		</td>
	</tr>
	<tr>
		<td>
			<label for="city">City: </label>
		</td>
		<td>
			<select name="city" id="city">
				<option value="London">London</option>
				<option value="Cardiff">Cardiff</option>
				<option value="Edinburgh">Edinburgh</option>
				<option value="Belfast">Belfast</option>
			</select>
		</td>
	</tr>
	<tr>
		<td>
			<label for="email">Email: </label>
		</td>
		<td>
			<input type="text" name="email" id="email"/><br/>
		</td>
	</tr>
	<tr>
		<td>
			<label for="username">Username: </label>
		</td>
		<td>
			<input type="text" name="username" id="username"/>
		</td>
	</tr>
	<tr>
		<td>
			<label for="password">Password: </label>
		</td>
		<td>
			<input type="password" name="password" id="password"/>
		</td>
	</tr>
	<tr>
		<td>
			<label for="password2">Retype Password: </label>
		</td>
		<td>
			<input type="password" name="password2" id="password2"/>
		</td>
	</tr>
	<tr>
		<td>
			<label for="secret">Select Secret Question: </label>
		</td>
		<td>
			<select name="secretQuestion" id="secret">
				<option value="Whats your favourite movie">What's your favourite movie?</option>
				<option value="Whats your favourite band">What's your favourite band?</option>
				<option value="Whats your favourite song">What's your favourite song?</option>
				<option value="Whats your best friends last name">What's your best friend's last name?</option>
			</select>
		</td>
	</tr>
	<tr>
		<td>
			<label for="secretAnswer">Secret Answer: </label>
		</td>
		<td>
			<input type="text" name="secretAnswer" id="secretAnswer"/>
		</td>
	</tr>
	<tr>
		<td>
			<label for="dateofbirth">Date of Birth: </label>
		</td>
		<td>
			<input type="text" name="dateofbirth" id="dateofbirth" value="DD/MM/YYYY"/>
		</td>
	</tr>
	<tr>
		<td>
			<label for="card">Card: </label>
		</td>
		<td>
			<select name="card" id="card">
				<option value="1">VISA &#8356;100</option>
				<option value="2">Master Card &#8356;200</option>
				<option value="3">AmEx &#8356;2000</option>
			</select>
		</td>
	</tr>
	<tr>
		<td>
			<input type="submit" name="submit" id="submit" value="Register"/>
		</td>
		<td>
			<input type="reset" name="reset" id="reset" value="Start Over"/>
		</td>
	</tr>
	</table>
</form>
</body>
</html>