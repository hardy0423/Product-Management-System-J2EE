package com.gestion.service;

import com.gestion.dao.IProductDAO;
import com.gestion.dao.ProductDAO;
import com.gestion.model.Product;

import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.List;

public class ProductService implements IProductService {
	private IProductDAO productDAO;

	public ProductService() throws SQLException {
		this.productDAO = new ProductDAO();
	}

	public Product createProduct(Product product) throws SQLException, ValidationException {
		validateProduct(product);

		if (product.getPrice().compareTo(BigDecimal.ZERO) <= 0) {
			throw new ValidationException("Le prix doit être supérieur à 0");
		}

		if (product.getQuantity() < 0) {
			throw new ValidationException("La quantité ne peut pas être négative");
		}

		return productDAO.create(product);
	}

	public Product getProductById(Long id) throws SQLException, ValidationException {
		if (id == null || id <= 0) {
			throw new ValidationException("ID invalide");
		}

		Product product = productDAO.findById(id);
		if (product == null) {
			throw new ValidationException("Produit non trouvé avec l'ID: " + id);
		}

		return product;
	}

	public List<Product> getAllProducts() throws SQLException {
		return productDAO.findAll();
	}

	public List<Product> getProductsByCategory(String category) throws SQLException, ValidationException {
		if (category == null || category.trim().isEmpty()) {
			throw new ValidationException("Catégorie invalide");
		}

		return productDAO.findByCategory(category);
	}

	public boolean updateProduct(Product product) throws SQLException, ValidationException {
		if (product.getId() == null) {
			throw new ValidationException("ID du produit requis pour la mise à jour");
		}

		validateProduct(product);

		Product existing = productDAO.findById(product.getId());
		if (existing == null) {
			throw new ValidationException("Produit non trouvé");
		}

		return productDAO.update(product);
	}

	public boolean deleteProduct(Long id) throws SQLException, ValidationException {
		if (id == null || id <= 0) {
			throw new ValidationException("ID invalide");
		}

		Product product = productDAO.findById(id);
		if (product == null) {
			throw new ValidationException("Produit non trouvé");
		}

		return productDAO.delete(id);
	}

	public List<Product> searchProducts(String searchTerm) throws SQLException, ValidationException {
		if (searchTerm == null || searchTerm.trim().isEmpty()) {
			throw new ValidationException("Terme de recherche invalide");
		}

		return productDAO.searchByName(searchTerm);
	}

	public boolean updateStock(Long productId, int quantityChange) throws SQLException, ValidationException {
		Product product = getProductById(productId);

		int newQuantity = product.getQuantity() + quantityChange;

		if (newQuantity < 0) {
			throw new ValidationException("Stock insuffisant. Stock actuel: " + product.getQuantity());
		}

		product.setQuantity(newQuantity);
		return productDAO.update(product);
	}

	public boolean isOutOfStock(Long productId) throws SQLException, ValidationException {
		Product product = getProductById(productId);
		return product.getQuantity() == 0;
	}

	public List<Product> getOutOfStockProducts() throws SQLException {
		return productDAO.findAll().stream().filter(p -> p.getQuantity() == 0).toList();
	}

	public int getTotalProductCount() throws SQLException {
		return productDAO.count();
	}

	public BigDecimal calculateTotalInventoryValue() throws SQLException {
		List<Product> products = productDAO.findAll();

		return products.stream().map(p -> p.getPrice().multiply(BigDecimal.valueOf(p.getQuantity())))
				.reduce(BigDecimal.ZERO, BigDecimal::add);
	}

	private void validateProduct(Product product) throws ValidationException {
		if (product == null) {
			throw new ValidationException("Le produit ne peut pas être null");
		}

		if (product.getName() == null || product.getName().trim().isEmpty()) {
			throw new ValidationException("Le nom du produit est requis");
		}

		if (product.getName().length() < 3) {
			throw new ValidationException("Le nom doit contenir au moins 3 caractères");
		}

		if (product.getPrice() == null) {
			throw new ValidationException("Le prix est requis");
		}

		if (product.getQuantity() == null) {
			throw new ValidationException("La quantité est requise");
		}

		if (product.getCategory() == null || product.getCategory().trim().isEmpty()) {
			throw new ValidationException("La catégorie est requise");
		}
	}
}