<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<link rel = "stylesheet"
	href = "https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.class">
<meta charset="EUC-KR">
<title>Welcome</title>
</head>
<body>
	<nav class = "navbar navbar-expand  navbar-dark bg-dark">
		<div class = "container" >
			<div class = "navbar-header">
				<a class = "navbar-brand" href="./heello.jsp">Home</a>
			</div>
		</div>
	</nav>
	<%! String greeting = "Welcome to Web Shopping Mall" ;
	String tagline = "Welcome to Web Market!"; %>
	<div class = "jumbotron">
		<div class = "container">
			<h1 class = "display-3">
				<%= greeting %>
			</h1>
		</div>
	</div>
	<div class = "conainer">
		<div class = "text-center">
			<h3>
				<%= tagline %>
			</h3>
		</div>
		<hr>
	</div>
	<footer class = "container">
		<p>&copy; WebMarket</p>
	</footer>
</body>
</html>