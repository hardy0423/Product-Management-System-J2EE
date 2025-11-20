<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>👁️ ${pageTitle}</h1>
            <nav>
                <a href="${pageContext.request.contextPath}/">Accueil</a>
                <a href="${pageContext.request.contextPath}/products">Produits</a>
            </nav>
        </header>

        <main>
            <!-- Message de succès -->
            <c:if test="${param.success == 'stock_updated'}">
                <div class="alert alert-success">✅ Stock mis à jour avec succès !</div>
            </c:if>

            <div class="product-detail-card">
                <div class="product-detail-header">
                    <div>
                        <h2>${product.name}</h2>
                        <span class="badge badge-category">${product.category}</span>
                    </div>
                    <div class="product-actions">
                        <a href="${pageContext.request.contextPath}/products/edit?id=${product.id}" 
                           class="btn btn-secondary">✏️ Modifier</a>
                        <form action="${pageContext.request.contextPath}/products" 
                              method="post" style="display: inline;"
                              onsubmit="return confirm('Êtes-vous sûr de vouloir supprimer ce produit ?');">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="id" value="${product.id}">
                            <button type="submit" class="btn btn-danger">🗑️ Supprimer</button>
                        </form>
                    </div>
                </div>

                <div class="product-detail-body">
                    <div class="detail-section">
                        <h3>📝 Description</h3>
                        <p class="description-text">
                            ${not empty product.description ? product.description : 'Aucune description disponible'}
                        </p>
                    </div>

                    <div class="detail-grid">
                        <div class="detail-item">
                            <span class="detail-label">💰 Prix</span>
                            <span class="detail-value price-large">
                                <fmt:formatNumber value="${product.price}" 
                                                  type="currency" currencySymbol="€" 
                                                  maxFractionDigits="2"/>
                            </span>
                        </div>

                        <div class="detail-item">
                            <span class="detail-label">📦 Stock</span>
                            <span class="detail-value stock-large ${product.quantity == 0 ? 'out-of-stock' : 
                                                                     product.quantity < 10 ? 'low-stock' : ''}">
                                ${product.quantity} unités
                            </span>
                        </div>

                        <div class="detail-item">
                            <span class="detail-label">🏷️ Catégorie</span>
                            <span class="detail-value">${product.category}</span>
                        </div>

                        <div class="detail-item">
                            <span class="detail-label">💵 Valeur en stock</span>
                            <span class="detail-value">
                                <fmt:formatNumber value="${product.price * product.quantity}" 
                                                  type="currency" currencySymbol="€" 
                                                  maxFractionDigits="2"/>
                            </span>
                        </div>
                    </div>

                    <div class="detail-section">
                        <h3>📅 Informations</h3>
                        <div class="info-grid">
                            <div class="info-row">
                                <span class="info-label">ID:</span>
                                <span class="info-value">#${product.id}</span>
                            </div>
                            <div class="info-row">
                                <span class="info-label">Créé le:</span>
                                <span class="info-value">
                                   <fmt:formatDate value="${product.createdAtAsDate}" pattern="dd/MM/yyyy HH:mm" />

                                </span>
                            </div>
                            <div class="info-row">
                                <span class="info-label">Modifié le:</span>
                                <span class="info-value">
                                   <fmt:formatDate value="${product.updatedAtAsDate}" pattern="dd/MM/yyyy HH:mm" />
                                </span>
                            </div>
                        </div>
                    </div>

                    <!-- Gestion du stock -->
                    <div class="detail-section">
                        <h3>📊 Gestion du Stock</h3>
                        <div class="stock-management">
                            <form action="${pageContext.request.contextPath}/products" 
                                  method="post" class="stock-form">
                                <input type="hidden" name="action" value="updateStock">
                                <input type="hidden" name="id" value="${product.id}">
                                
                                <div class="stock-input-group">
                                    <label for="quantityChange">Ajuster le stock:</label>
                                    <div class="input-with-buttons">
                                        <button type="button" class="btn btn-sm" 
                                                onclick="changeQuantity(-10)">-10</button>
                                        <button type="button" class="btn btn-sm" 
                                                onclick="changeQuantity(-1)">-1</button>
                                        <input type="number" id="quantityChange" name="quantityChange" 
                                               value="0" class="form-control stock-input">
                                        <button type="button" class="btn btn-sm" 
                                                onclick="changeQuantity(1)">+1</button>
                                        <button type="button" class="btn btn-sm" 
                                                onclick="changeQuantity(10)">+10</button>
                                    </div>
                                </div>
                                
                                <button type="submit" class="btn btn-primary">💾 Mettre à jour le stock</button>
                            </form>
                        </div>
                    </div>
                </div>

                <div class="product-detail-footer">
                    <a href="${pageContext.request.contextPath}/products" class="btn btn-secondary">
                        ← Retour à la liste
                    </a>
                </div>
            </div>
        </main>

        <footer>
            <p>&copy; 2024 Système de Gestion de Produits</p>
        </footer>
    </div>

    <script>
        function changeQuantity(amount) {
            const input = document.getElementById('quantityChange');
            const currentValue = parseInt(input.value) || 0;
            input.value = currentValue + amount;
        }
    </script>
</body>
</html>