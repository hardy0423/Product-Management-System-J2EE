<%@ page contentType="text/html;charset=UTF-8" language="java"
	isErrorPage="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Erreur - ${pageTitle}</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
	<div class="container">
		<header>
			<h1>⚠️ Une erreur s'est produite</h1>
			<nav>
				<a href="${pageContext.request.contextPath}/">Accueil</a> <a
					href="${pageContext.request.contextPath}/products">Produits</a>
			</nav>
		</header>

		<main>
			<div class="error-container">
				<div class="error-icon">❌</div>

				<h2>Oups ! Quelque chose s'est mal passé</h2>

				<c:if test="${not empty errorMessage}">
					<div class="alert alert-danger">
						<strong>Message d'erreur :</strong>
						<p>${errorMessage}</p>
					</div>
				</c:if>

				<c:if
					test="${empty errorMessage && not empty pageContext.exception}">
					<div class="alert alert-danger">
						<strong>Message d'erreur :</strong>
						<p>${pageContext.exception.message}</p>
					</div>
				</c:if>

				<div class="error-actions">
					<a href="${pageContext.request.contextPath}/products"
						class="btn btn-primary"> ← Retour à la liste des produits </a> <a
						href="${pageContext.request.contextPath}/"
						class="btn btn-secondary"> 🏠 Retour à l'accueil </a>
				</div>

				<div class="error-help">
					<h3>💡 Que faire ?</h3>
					<ul>
						<li>Vérifiez que toutes les données saisies sont correctes</li>
						<li>Assurez-vous que la connexion à la base de données est
							active</li>
						<li>Contactez l'administrateur si le problème persiste</li>
					</ul>
				</div>
			</div>
		</main>

		<footer>
			<p>&copy; 2024 Système de Gestion de Produits</p>
		</footer>
	</div>
</body>
</html>