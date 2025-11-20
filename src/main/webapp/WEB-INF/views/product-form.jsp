<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
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
            <h1>${pageTitle}</h1>
            <nav>
                <a href="${pageContext.request.contextPath}/">Accueil</a>
                <a href="${pageContext.request.contextPath}/products">Produits</a>
            </nav>
        </header>

        <main>
            <div class="form-container">
                <form action="${pageContext.request.contextPath}/products" method="post" class="product-form">
                    <input type="hidden" name="action" value="${empty product ? 'create' : 'update'}">
                    <c:if test="${not empty product}">
                        <input type="hidden" name="id" value="${product.id}">
                    </c:if>

                    <div class="form-group">
                        <label for="name">Nom du produit <span class="required">*</span></label>
                        <input type="text" id="name" name="name" 
                               value="${product.name}" 
                               class="form-control" 
                               required 
                               minlength="3"
                               placeholder="Ex: Laptop Dell XPS 15">
                        <small class="form-text">Minimum 3 caractères</small>
                    </div>

                    <div class="form-group">
                        <label for="description">Description</label>
                        <textarea id="description" name="description" 
                                  class="form-control" 
                                  rows="4"
                                  placeholder="Description détaillée du produit...">${product.description}</textarea>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="price">Prix (€) <span class="required">*</span></label>
                            <input type="number" id="price" name="price" 
                                   value="${product.price}" 
                                   class="form-control" 
                                   required 
                                   step="0.01" 
                                   min="0.01"
                                   placeholder="0.00">
                        </div>

                        <div class="form-group">
                            <label for="quantity">Quantité <span class="required">*</span></label>
                            <input type="number" id="quantity" name="quantity" 
                                   value="${product.quantity}" 
                                   class="form-control" 
                                   required 
                                   min="0"
                                   placeholder="0">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="category">Catégorie <span class="required">*</span></label>
                        <select id="category" name="category" class="form-control" required>
                            <option value="">-- Sélectionnez une catégorie --</option>
                            <option value="Informatique" ${product.category == 'Informatique' ? 'selected' : ''}>
                                Informatique
                            </option>
                            <option value="Téléphonie" ${product.category == 'Téléphonie' ? 'selected' : ''}>
                                Téléphonie
                            </option>
                            <option value="Audio" ${product.category == 'Audio' ? 'selected' : ''}>
                                Audio
                            </option>
                            <option value="Tablettes" ${product.category == 'Tablettes' ? 'selected' : ''}>
                                Tablettes
                            </option>
                            <option value="Accessoires" ${product.category == 'Accessoires' ? 'selected' : ''}>
                                Accessoires
                            </option>
                            <option value="Électronique" ${product.category == 'Électronique' ? 'selected' : ''}>
                                Électronique
                            </option>
                        </select>
                    </div>

                    <div class="form-actions">
                        <button type="submit" class="btn btn-primary">
                            ${empty product ? '➕ Créer le produit' : '💾 Enregistrer les modifications'}
                        </button>
                        <a href="${pageContext.request.contextPath}/products" class="btn btn-secondary">
                            ❌ Annuler
                        </a>
                    </div>
                </form>
            </div>
        </main>

        <footer>
            <p>&copy; 2024 Système de Gestion de Produits</p>
        </footer>
    </div>

    <script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>