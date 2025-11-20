package com.gestion.dao;

import java.sql.SQLException;
import java.util.List;

import com.gestion.model.Product;

public interface IProductDAO {

	Product create(Product product) throws SQLException;

	Product findById(Long id) throws SQLException;

	List<Product> findAll() throws SQLException;

	List<Product> findByCategory(String category) throws SQLException;

	boolean update(Product product) throws SQLException;

	boolean delete(Long id) throws SQLException;

	List<Product> searchByName(String searchTerm) throws SQLException;

	int count() throws SQLException;
}