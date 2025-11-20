package com.gestion.service;

import com.gestion.model.Product;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.List;

public interface IProductService {

	Product createProduct(Product product) throws SQLException, ValidationException;

	Product getProductById(Long id) throws SQLException, ValidationException;

	List<Product> getAllProducts() throws SQLException;

	List<Product> getProductsByCategory(String category) throws SQLException, ValidationException;

	boolean updateProduct(Product product) throws SQLException, ValidationException;

	boolean deleteProduct(Long id) throws SQLException, ValidationException;

	List<Product> searchProducts(String searchTerm) throws SQLException, ValidationException;

	boolean updateStock(Long productId, int quantityChange) throws SQLException, ValidationException;

	boolean isOutOfStock(Long productId) throws SQLException, ValidationException;

	List<Product> getOutOfStockProducts() throws SQLException;

	int getTotalProductCount() throws SQLException;

	BigDecimal calculateTotalInventoryValue() throws SQLException;
}