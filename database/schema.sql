-- Création de la base de données (à exécuter depuis postgres ou pgAdmin)
-- CREATE DATABASE gestion_produits WITH ENCODING 'UTF8' LC_COLLATE='fr_FR.UTF-8' LC_CTYPE='fr_FR.UTF-8';

-- Connexion à la base
\c gestion_produits;

-- Suppression de la table si elle existe
DROP TABLE IF EXISTS products CASCADE;

-- Table products
CREATE TABLE products (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price NUMERIC(10,2) NOT NULL,
    quantity INT NOT NULL DEFAULT 0,
    category VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT now(),
    updated_at TIMESTAMP DEFAULT now()
);

-- Données de test
INSERT INTO products (name, description, price, quantity, category) VALUES
('Laptop Dell XPS 15', 'Ordinateur portable haute performance avec écran 15 pouces', 1299.99, 15, 'Informatique'),
('iPhone 15 Pro', 'Smartphone Apple dernière génération 256GB', 1199.00, 30, 'Téléphonie'),
('Samsung Galaxy S24', 'Smartphone Android flagship 128GB', 899.99, 25, 'Téléphonie');

-- Vue des statistiques par catégorie
CREATE OR REPLACE VIEW category_statistics AS
SELECT 
    category,
    COUNT(*) AS product_count,
    SUM(quantity) AS total_quantity,
    SUM(price * quantity) AS total_value,
    AVG(price) AS average_price,
    MIN(price) AS min_price,
    MAX(price) AS max_price
FROM products
GROUP BY category;

-- Fonction pour calculer la valeur totale du stock
CREATE OR REPLACE FUNCTION calculate_total_inventory_value()
RETURNS NUMERIC(15,2) AS $$
DECLARE
    total_value NUMERIC(15,2);
BEGIN
    SELECT SUM(price * quantity) INTO total_value FROM products;
    RETURN COALESCE(total_value,0);
END;
$$ LANGUAGE plpgsql;

-- Table pour historique des prix
DROP TABLE IF EXISTS product_price_history CASCADE;

CREATE TABLE product_price_history (
    id BIGSERIAL PRIMARY KEY,
    product_id BIGINT NOT NULL REFERENCES products(id) ON DELETE CASCADE,
    old_price NUMERIC(10,2),
    new_price NUMERIC(10,2),
    changed_at TIMESTAMP DEFAULT now()
);

-- Trigger pour historiser les prix
CREATE OR REPLACE FUNCTION track_price_changes()
RETURNS TRIGGER AS $$
BEGIN
    IF OLD.price <> NEW.price THEN
        INSERT INTO product_price_history(product_id, old_price, new_price)
        VALUES (OLD.id, OLD.price, NEW.price);
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER track_price_changes
BEFORE UPDATE ON products
FOR EACH ROW
EXECUTE FUNCTION track_price_changes();
