package dao;

import java.util.ArrayList;
import java.sql.*;
import dto.Product;

public class ProductRepository {
	
	private ArrayList<Product> listOfProducts = new ArrayList<Product>();
	private static ProductRepository instance = new ProductRepository();
	
	
	public ProductRepository() {
		Connection conn = null;

		try {
			String url = "jdbc:mysql://localhost:3306/WebMarketDB";
			String user = "root";
			String password = "Youare2485!";
			
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(url, user, password);
		} catch (SQLException ex) {
			System.out.println("데이터베이스 연결이 실패했습니다.\n");
			System.out.println("SQLException : " + ex.getMessage());
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT * FROM product";
		try {
			pstmt = conn.prepareStatement(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		try {
			rs = pstmt.executeQuery();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		Product product = null;
		
		try {
			while(rs.next()) {
				product = new Product(rs.getString("p_id"), rs.getString("p_name"), rs.getInt("p_unitPrice"));
				product.setDescription(rs.getString("p_description"));
				product.setCategory(rs.getString("p_category"));
				product.setManufacturer(rs.getString("p_manufacturer"));
				product.setUnitsInStock(rs.getLong("p_unitsInStock"));
				product.setCondition(rs.getString("p_condition"));
				product.setFilename(rs.getString("p_fileName"));
				
				listOfProducts.add(product);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		if (rs != null) {
			try {
				rs.close();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		}
		if (pstmt != null) {
			try {
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if (conn != null) {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	public ArrayList<Product> getAllProducts() {
		return listOfProducts;
	}
	
	public Product getProductById(String productId) {
		Product productById = null;
		
		for (int i = 0; i < listOfProducts.size(); i++) {
			Product product = listOfProducts.get(i);
			if (product != null && product.getProductId() != null && product.getProductId().equals(productId)) {
				productById = product;
				break;
			}
		}
		return productById;
	}
	
	public static ProductRepository getInstance() {
		return instance;
	}
	
	public void addProduct(Product product) {
		listOfProducts.add(product);
	}
	
}
