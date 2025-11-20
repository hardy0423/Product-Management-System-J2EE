package com.gestion.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.List;

import com.gestion.model.Product;
import com.gestion.service.IProductService;
import com.gestion.service.ProductService;
import com.gestion.service.ValidationException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;



@WebServlet("/products/*")
public class ProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private IProductService productService;

	@Override
	public void init() throws ServletException {
		try {
			System.out.println("INITIALISATION DU SERVLET");
			productService = new ProductService();
		} catch (SQLException e) {
			throw new ServletException("Erreur d'initialisation du service", e);
		}
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String pathInfo = request.getPathInfo();
		
		System.out.println("PATH "+  pathInfo);

		try {
			if (pathInfo == null || pathInfo.equals("/")) {
				listProducts(request, response);
			} else if (pathInfo.equals("/view")) {
				viewProduct(request, response);
			} else if (pathInfo.equals("/search")) {
				searchProducts(request, response);
			} else if (pathInfo.equals("/new")) {
				showNewForm(request, response);
			} else if (pathInfo.equals("/edit")) {
				showEditForm(request, response);
			} else if (pathInfo.equals("/category")) {
				filterByCategory(request, response);
			} else {
				response.sendError(HttpServletResponse.SC_NOT_FOUND);
			}
		} catch (SQLException | ValidationException e) {
			handleError(request, response, e);
		}
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String action = request.getParameter("action");

		try {
			if ("create".equals(action)) {
				createProduct(request, response);
			} else if ("update".equals(action)) {
				updateProduct(request, response);
			} else if ("delete".equals(action)) {
				deleteProduct(request, response);
			} else if ("updateStock".equals(action)) {
				updateStock(request, response);
			} else {
				response.sendError(HttpServletResponse.SC_BAD_REQUEST);
			}
		} catch (SQLException | ValidationException e) {
			handleError(request, response, e);
		}
	}

	private void listProducts(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, ServletException, IOException {

		List<Product> products = productService.getAllProducts();
		int totalCount = productService.getTotalProductCount();
		BigDecimal  totalValue = productService.calculateTotalInventoryValue();

		request.setAttribute("products", products);
		request.setAttribute("totalCount", totalCount);
		request.setAttribute("totalValue", totalValue);
		request.setAttribute("pageTitle", "Liste des Produits");

		request.getRequestDispatcher("/WEB-INF/views/product-list.jsp").forward(request, response);
	}

	private void viewProduct(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, ValidationException, ServletException, IOException {

		Long id = Long.parseLong(request.getParameter("id"));
		Product product = productService.getProductById(id);

		request.setAttribute("product", product);
		request.setAttribute("pageTitle", "Détails du Produit");

		request.getRequestDispatcher("/WEB-INF/views/product-view.jsp").forward(request, response);
	}

	private void searchProducts(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, ValidationException, ServletException, IOException {

		String searchTerm = request.getParameter("q");
		List<Product> products = productService.searchProducts(searchTerm);

		request.setAttribute("products", products);
		request.setAttribute("searchTerm", searchTerm);
		request.setAttribute("pageTitle", "Résultats de recherche");

		request.getRequestDispatcher("/WEB-INF/views/product-list.jsp").forward(request, response);
	}

	private void filterByCategory(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, ValidationException, ServletException, IOException {

		String category = request.getParameter("name");
		List<Product> products = productService.getProductsByCategory(category);

		request.setAttribute("products", products);
		request.setAttribute("category", category);
		request.setAttribute("pageTitle", "Catégorie: " + category);

		request.getRequestDispatcher("/WEB-INF/views/product-list.jsp").forward(request, response);
	}

	private void showNewForm(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setAttribute("pageTitle", "Nouveau Produit");
		request.getRequestDispatcher("/WEB-INF/views/product-form.jsp").forward(request, response);
	}

	private void showEditForm(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, ValidationException, ServletException, IOException {

		Long id = Long.parseLong(request.getParameter("id"));
		Product product = productService.getProductById(id);

		request.setAttribute("product", product);
		request.setAttribute("pageTitle", "Modifier le Produit");

		request.getRequestDispatcher("/WEB-INF/views/product-form.jsp").forward(request, response);
	}

	private void createProduct(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, ValidationException, IOException {

		Product product = extractProductFromRequest(request);
		productService.createProduct(product);

		response.sendRedirect(request.getContextPath() + "/products?success=created");
	}

	private void updateProduct(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, ValidationException, IOException {

		Product product = extractProductFromRequest(request);
		Long id = Long.parseLong(request.getParameter("id"));
		product.setId(id);

		productService.updateProduct(product);

		response.sendRedirect(request.getContextPath() + "/products?success=updated");
	}

	private void deleteProduct(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, ValidationException, IOException {

		Long id = Long.parseLong(request.getParameter("id"));
		productService.deleteProduct(id);

		response.sendRedirect(request.getContextPath() + "/products?success=deleted");
	}

	private void updateStock(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, ValidationException, IOException {

		Long id = Long.parseLong(request.getParameter("id"));
		int quantityChange = Integer.parseInt(request.getParameter("quantityChange"));

		productService.updateStock(id, quantityChange);

		response.sendRedirect(request.getContextPath() + "/products/view?id=" + id + "&success=stock_updated");
	}

	private Product extractProductFromRequest(HttpServletRequest request) {
		String name = request.getParameter("name");
		String description = request.getParameter("description");
		BigDecimal price = new BigDecimal(request.getParameter("price"));
		Integer quantity = Integer.parseInt(request.getParameter("quantity"));
		String category = request.getParameter("category");

		return new Product(name, description, price, quantity, category);
	}

	private void handleError(HttpServletRequest request, HttpServletResponse response, Exception e)
			throws ServletException, IOException {

		request.setAttribute("errorMessage", e.getMessage());
		request.setAttribute("pageTitle", "Erreur");

		request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
	}
}