<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<html>
<head>
<title>JSTL</title>
</head>
<body>
	<form action="sql02_process.jsp" method="post">
		<p> 아이디  : <input type="text" name="id">
		<p> 비밀번호 : <input type="text" name="passwd">
		<p> 이름  : <input type="text" name="name">
		<p> <input type="submit" value="전송">
	</form>
</body>
</html>