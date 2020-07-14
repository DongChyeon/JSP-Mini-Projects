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
	
	ArrayList<Product> productsList = dao.getAllProducts();
	Product products = new Product();
	for (int i = 0; i < productsList.size(); i++) {
		products = productsList.get(i);
		if (products.getProductId().equals(id)) {
			break;
		}
	}
	
	ArrayList<Product> list = (ArrayList<Product>)session.getAttribute("cartlist");
	if (list == null) {
		list = new ArrayList<Product>();
		session.setAttribute("cartlist", list);
	}
	
	int cnt = 0;
	Product productsQnt = new Product();
	for (int i = 0; i < list.size(); i++) {
		productsQnt = list.get(i);
		if (productsQnt.getProductId().equals(id)) {
			cnt++;
			int orderQuantity = productsQnt.getQuantity() + 1;
			productsQnt.setQuantity(orderQuantity);
		}
	}
	
	if (cnt == 0) {
		products.setQuantity(1);
		list.add(products);
	}
	
	response.sendRedirect("product.jsp?id=" + id);
%>