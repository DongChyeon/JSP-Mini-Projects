<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="dto.Product"%>
<%@ page import="dao.ProductRepository"%>

<%
	String id = request.getParameter("id");
	if (id == null || id.trim().equals("")) {
		response.sendRedirect("products.jsp");
		return;
	}
	
	ProductRepository dao = ProductRepository.getInstance();
	
	Product product = dao.getProductById(id);
	if (product == null) {
		response.sendRedirect("exceptionNoProductId.jsp");
	}
	
	ArrayList<Product> cartList = (ArrayList<Product>)session.getAttribute("cartlist");
	Product productsQnt = new Product();
	for (int i = 0; i < cartList.size(); i++) {
		productsQnt = cartList.get(i);
		if (productsQnt.getProductId().equals(id)) {
			cartList.remove(productsQnt);
		}
	}
	
	response.sendRedirect("cart.jsp");
%>