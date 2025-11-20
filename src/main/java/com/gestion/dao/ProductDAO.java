package com.gestion.dao;

import com.gestion.config.DatabaseConnection;
import com.gestion.model.Product;

import java.math.BigDecimal;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO implements IProductDAO {
	private Connection connection;

	public ProductDAO() throws SQLException {
		this.connection = DatabaseConnection.getInstance().getConnection();
	}

	@Override
	public Product create(Product product) throws SQLException {
		String sql = "INSERT INTO products (name, description, price, quantity, category, created_at, updated_at) "
				+ "VALUES (?, ?, ?, ?, ?, ?, ?)";

		try (PreparedStatement stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
			stmt.setString(1, product.getName());
			stmt.setString(2, product.getDescription());
			stmt.setBigDecimal(3, product.getPrice());
			stmt.setInt(4, product.getQuantity());
			stmt.setString(5, product.getCategory());
			stmt.setTimestamp(6, Timestamp.valueOf(product.getCreatedAt()));
			stmt.setTimestamp(7, Timestamp.valueOf(product.getUpdatedAt()));

			int affectedRows = stmt.executeUpdate();

			if (affectedRows == 0) {
				throw new SQLException("Échec de création du produit");
			}

			try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
				if (generatedKeys.next()) {
					product.setId(generatedKeys.getLong(1));
				}
			}
		}
		return product;
	}


	@Override
	public Product findById(Long id) throws SQLException {
		String sql = "SELECT * FROM products WHERE id = ?";

		try (PreparedStatement stmt = connection.prepareStatement(sql)) {
			stmt.setLong(1, id);

			try (ResultSet rs = stmt.executeQuery()) {
				if (rs.next()) {
					return mapResultSetToProduct(rs);
				}
			}
		}
		return null;
	}


	@Override
	public List<Product> findAll() throws SQLException {
		List<Product> products = new ArrayList<>();
		String sql = "SELECT * FROM products ORDER BY created_at DESC";

		try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {

			while (rs.next()) {
				products.add(mapResultSetToProduct(rs));
			}
		}
		return products;
	}

	
	@Override
	public List<Product> findByCategory(String category) throws SQLException {
		List<Product> products = new ArrayList<>();
		String sql = "SELECT * FROM products WHERE category = ? ORDER BY name";

		try (PreparedStatement stmt = connection.prepareStatement(sql)) {
			stmt.setString(1, category);

			try (ResultSet rs = stmt.executeQuery()) {
				while (rs.next()) {
					products.add(mapResultSetToProduct(rs));
				}
			}
		}
		return products;
	}

	@Override
	public boolean update(Product product) throws SQLException {
		String sql = "UPDATE products SET name = ?, description = ?, price = ?, "
				+ "quantity = ?, category = ?, updated_at = ? WHERE id = ?";

		try (PreparedStatement stmt = connection.prepareStatement(sql)) {
			stmt.setString(1, product.getName());
			stmt.setString(2, product.getDescription());
			stmt.setBigDecimal(3, product.getPrice());
			stmt.setInt(4, product.getQuantity());
			stmt.setString(5, product.getCategory());
			stmt.setTimestamp(6, Timestamp.valueOf(LocalDateTime.now()));
			stmt.setLong(7, product.getId());

			return stmt.executeUpdate() > 0;
		}
	}


	@Override
	public boolean delete(Long id) throws SQLException {
		String sql = "DELETE FROM products WHERE id = ?";

		try (PreparedStatement stmt = connection.prepareStatement(sql)) {
			stmt.setLong(1, id);
			return stmt.executeUpdate() > 0;
		}
	}

	@Override
	public List<Product> searchByName(String searchTerm) throws SQLException {
		List<Product> products = new ArrayList<>();
		String sql = "SELECT * FROM products WHERE name LIKE ? ORDER BY name";

		try (PreparedStatement stmt = connection.prepareStatement(sql)) {
			stmt.setString(1, "%" + searchTerm + "%");

			try (ResultSet rs = stmt.executeQuery()) {
				while (rs.next()) {
					products.add(mapResultSetToProduct(rs));
				}
			}
		}
		return products;
	}


	@Override
	public int count() throws SQLException {
		String sql = "SELECT COUNT(*) FROM products";

		try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {

			if (rs.next()) {
				return rs.getInt(1);
			}
		}
		return 0;
	}


	private Product mapResultSetToProduct(ResultSet rs) throws SQLException {
		Product product = new Product();
		product.setId(rs.getLong("id"));
		product.setName(rs.getString("name"));
		product.setDescription(rs.getString("description"));
		product.setPrice(rs.getBigDecimal("price"));
		product.setQuantity(rs.getInt("quantity"));
		product.setCategory(rs.getString("category"));
		product.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
		product.setUpdatedAt(rs.getTimestamp("updated_at").toLocalDateTime());
		return product;
	}
}