<%@ page contentType="text/html; charest=utf-8"%>
<%
	session.invalidate();
	response.sendRedirect("addProduct.jsp");
%>