<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${pageTitle}</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
	<div class="container">
		<header>
			<h1>📦 ${pageTitle}</h1>
			<nav>
				<a href="${pageContext.request.contextPath}/">Accueil</a> <a
					href="${pageContext.request.contextPath}/products">Produits</a>
			</nav>
		</header>

		<main>
			<!-- Messages de succès -->
			<c:if test="${param.success == 'created'}">
				<div class="alert alert-success">✅ Produit créé avec succès !</div>
			</c:if>
			<c:if test="${param.success == 'updated'}">
				<div class="alert alert-success">✅ Produit mis à jour avec
					succès !</div>
			</c:if>
			<c:if test="${param.success == 'deleted'}">
				<div class="alert alert-success">✅ Produit supprimé avec
					succès !</div>
			</c:if>

			<!-- Barre d'actions -->
			<div class="toolbar">
				<div class="toolbar-left">
					<a href="${pageContext.request.contextPath}/products/new"
						class="btn btn-primary"> ➕ Nouveau Produit </a>
				</div>

				<div class="toolbar-right">
					<form action="${pageContext.request.contextPath}/products/search"
						method="get" class="search-form">
						<input type="text" name="q" placeholder="Rechercher un produit..."
							value="${searchTerm}" class="search-input">
						<button type="submit" class="btn btn-secondary">🔍
							Rechercher</button>
					</form>
				</div>
			</div>

			<!-- Statistiques -->
			<c:if test="${not empty totalCount}">
				<div class="stats-grid">
					<div class="stat-card">
						<div class="stat-icon">📊</div>
						<div class="stat-content">
							<div class="stat-label">Total Produits</div>
							<div class="stat-value">${totalCount}</div>
						</div>
					</div>

					<div class="stat-card">
						<div class="stat-icon">💰</div>
						<div class="stat-content">
							<div class="stat-label">Valeur Totale</div>
							<div class="stat-value">
								<fmt:formatNumber value="${totalValue}" type="currency"
									currencySymbol="€" maxFractionDigits="2" />
							</div>
						</div>
					</div>
				</div>
			</c:if>

			<!-- Filtres par catégorie -->
			<div class="category-filters">
				<a href="${pageContext.request.contextPath}/products"
					class="filter-btn ${empty category ? 'active' : ''}">Toutes</a> <a
					href="${pageContext.request.contextPath}/products/category?name=Informatique"
					class="filter-btn ${category == 'Informatique' ? 'active' : ''}">Informatique</a>
				<a
					href="${pageContext.request.contextPath}/products/category?name=Téléphonie"
					class="filter-btn ${category == 'Téléphonie' ? 'active' : ''}">Téléphonie</a>
				<a
					href="${pageContext.request.contextPath}/products/category?name=Audio"
					class="filter-btn ${category == 'Audio' ? 'active' : ''}">Audio</a>
				<a
					href="${pageContext.request.contextPath}/products/category?name=Tablettes"
					class="filter-btn ${category == 'Tablettes' ? 'active' : ''}">Tablettes</a>
			</div>

			<!-- Liste des produits -->
			<c:choose>
				<c:when test="${empty products}">
					<div class="empty-state">
						<p>😕 Aucun produit trouvé.</p>
						<a href="${pageContext.request.contextPath}/products/new"
							class="btn btn-primary"> Créer votre premier produit </a>
					</div>
				</c:when>
				<c:otherwise>
					<div class="products-grid">
						<c:forEach var="product" items="${products}">
							<div class="product-card">
								<div class="product-header">
									<h3>${product.name}</h3>
									<span class="badge badge-category">${product.category}</span>
								</div>

								<div class="product-body">
									<p class="product-description">${product.description}</p>

									<div class="product-info">
										<div class="info-item">
											<span class="label">Prix:</span> <span class="value price">
												<fmt:formatNumber value="${product.price}" type="currency"
													currencySymbol="€" maxFractionDigits="2" />
											</span>
										</div>

										<div class="info-item">
											<span class="label">Stock:</span> <span
												class="value stock ${product.quantity == 0 ? 'out-of-stock' : 
                                                                       product.quantity < 10 ? 'low-stock' : ''}">
												${product.quantity} unités </span>
										</div>
									</div>
								</div>

								<div class="product-footer">
									<a
										href="${pageContext.request.contextPath}/products/view?id=${product.id}"
										class="btn btn-sm btn-info">👁️ Voir</a> <a
										href="${pageContext.request.contextPath}/products/edit?id=${product.id}"
										class="btn btn-sm btn-secondary">✏️ Modifier</a>
									<form action="${pageContext.request.contextPath}/products"
										method="post" style="display: inline;"
										onsubmit="return confirm('Êtes-vous sûr de vouloir supprimer ce produit ?');">
										<input type="hidden" name="action" value="delete"> <input
											type="hidden" name="id" value="${product.id}">
										<button type="submit" class="btn btn-sm btn-danger">🗑️
											Supprimer</button>
									</form>
								</div>
							</div>
						</c:forEach>
					</div>
				</c:otherwise>
			</c:choose>
		</main>

		<footer>
			<p>&copy; 2024 Système de Gestion de Produits</p>
		</footer>
	</div>
</body>
</html>