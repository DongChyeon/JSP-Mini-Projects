<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="dto.Product"%>
<%@ page import="dao.ProductRepository"%>
<%@ include file="dbconn.jsp" %>
<%
	String id = request.getParameter("id");
	if (id == null || id.trim().equals("")) {
		response.sendRedirect("products.jsp");
		return;
	}
	
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "SELECT * FROM product WHERE p_id = ?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, id);
	rs = pstmt.executeQuery();
	if (rs.next()) {
		Product product = new Product(rs.getString("p_id"), rs.getString("p_name"), rs.getInt("p_unitPrice"));
		product.setDescription(rs.getString("p_description"));
		product.setCategory(rs.getString("p_category"));
		product.setManufacturer(rs.getString("p_manufacturer"));
		product.setUnitsInStock(rs.getLong("p_unitsInStock"));
		product.setCondition(rs.getString("p_condition"));
		product.setFilename(rs.getString("p_fileName"));
		
		ArrayList<Product> list = (ArrayList<Product>)session.getAttribute("cartlist");
		if (list == null) {
			list = new ArrayList<Product>();
			session.setAttribute("cartlist", list);
		}
		
		int cnt = 0;
		Product productQnt = new Product();
		for (int i = 0; i < list.size(); i++) {
			productQnt = list.get(i);
			if (productQnt.getProductId().equals(id)) {
				cnt++;
				int orderQuantity = productQnt.getQuantity() + 1;
				productQnt.setQuantity(orderQuantity);
			}
		}
		
		if (cnt == 0) {
			product.setQuantity(1);
			list.add(product);
		}
	}
	else {
		response.sendRedirect("exceptionNoProductId.jsp");
	}
	
	if (rs != null) rs.close();
	if (pstmt != null) pstmt.close();
	if (conn != null) conn.close();
	
	response.sendRedirect("product.jsp?id=" + id);
%>