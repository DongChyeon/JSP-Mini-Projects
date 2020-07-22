<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>JSTL</title>
</head>
<body>
	<h3> 구구단 </h3>
	<table>
		<c:forEach var="i" begin="1" end="9">
			<tr>
				<c:forEach var="j" begin="1" end="9">
					<td width=100>${ i } * ${ j } = ${ i * j }</td>
				</c:forEach>
			</tr>
		</c:forEach>
	</table>
</body>
</html>