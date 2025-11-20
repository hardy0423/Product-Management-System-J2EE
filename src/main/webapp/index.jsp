<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Système de Gestion de Produits</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
	<div class="container">
		<header>
			<h1>🏪 Système de Gestion de Produits</h1>
			<p>Application J2EE avec architecture en couches</p>
		</header>

		<main>
			<div class="welcome-card">
				<h2>Bienvenue !</h2>
				<p>Cette application vous permet de gérer efficacement votre
					inventaire de produits.</p>

				<div class="features">
					<div class="feature">
						<span class="icon"></span>
						<h3>Gestion complète</h3>
						<p>Créer, modifier et supprimer des produits</p>
					</div>

					<div class="feature">
						<span class="icon"></span>
						<h3>Recherche avancée</h3>
						<p>Rechercher par nom ou filtrer par catégorie</p>
					</div>

					<div class="feature">
						<span class="icon"></span>
						<h3>Statistiques</h3>
						<p>Visualiser les stocks et valeurs d'inventaire</p>
					</div>
				</div>

				<div class="actions">
					<a href="${pageContext.request.contextPath}/products"
						class="btn btn-primary"> Accéder à la gestion des produits </a>
				</div>
			</div>

			<div class="info-section">
				<h3>🏗️ Architecture du Projet</h3>
				<ul>
					<li><strong>Presentation Layer</strong> - Servlets & JSP</li>
					<li><strong>Service Layer</strong> - Logique métier</li>
					<li><strong>DAO Layer</strong> - Accès aux données</li>
					<li><strong>Model Layer</strong> - Entités</li>
				</ul>
			</div>
		</main>

		<footer>
			<p>&copy; 2024 Système de Gestion de Produits - Version 1.0.0</p>
		</footer>
	</div>
</body>
</html>