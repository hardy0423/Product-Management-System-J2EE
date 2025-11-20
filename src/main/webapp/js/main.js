// ===== Validation de formulaire =====
document.addEventListener('DOMContentLoaded', function() {
    const productForm = document.querySelector('.product-form');
    
    if (productForm) {
        productForm.addEventListener('submit', function(e) {
            if (!validateForm()) {
                e.preventDefault();
            }
        });
    }
    
    // Auto-hide alerts après 5 secondes
    const alerts = document.querySelectorAll('.alert');
    alerts.forEach(alert => {
        setTimeout(() => {
            alert.style.transition = 'opacity 0.5s';
            alert.style.opacity = '0';
            setTimeout(() => alert.remove(), 500);
        }, 5000);
    });
});

function validateForm() {
    let isValid = true;
    
    // Validation du nom
    const name = document.getElementById('name');
    if (name && name.value.trim().length < 3) {
        showError(name, 'Le nom doit contenir au moins 3 caractères');
        isValid = false;
    } else if (name) {
        clearError(name);
    }
    
    // Validation du prix
    const price = document.getElementById('price');
    if (price && parseFloat(price.value) <= 0) {
        showError(price, 'Le prix doit être supérieur à 0');
        isValid = false;
    } else if (price) {
        clearError(price);
    }
    
    // Validation de la quantité
    const quantity = document.getElementById('quantity');
    if (quantity && parseInt(quantity.value) < 0) {
        showError(quantity, 'La quantité ne peut pas être négative');
        isValid = false;
    } else if (quantity) {
        clearError(quantity);
    }
    
    // Validation de la catégorie
    const category = document.getElementById('category');
    if (category && category.value === '') {
        showError(category, 'Veuillez sélectionner une catégorie');
        isValid = false;
    } else if (category) {
        clearError(category);
    }
    
    return isValid;
}

function showError(element, message) {
    // Supprimer l'erreur existante
    clearError(element);
    
    // Ajouter la classe d'erreur
    element.style.borderColor = '#ef4444';
    
    // Créer et ajouter le message d'erreur
    const errorDiv = document.createElement('div');
    errorDiv.className = 'error-message';
    errorDiv.style.color = '#ef4444';
    errorDiv.style.fontSize = '0.875rem';
    errorDiv.style.marginTop = '5px';
    errorDiv.textContent = message;
    
    element.parentNode.appendChild(errorDiv);
}

function clearError(element) {
    element.style.borderColor = '';
    const errorMessage = element.parentNode.querySelector('.error-message');
    if (errorMessage) {
        errorMessage.remove();
    }
}

// ===== Confirmation de suppression =====
function confirmDelete(productName) {
    return confirm(`Êtes-vous sûr de vouloir supprimer le produit "${productName}" ?\n\nCette action est irréversible.`);
}

// ===== Gestion du stock =====
function changeQuantity(amount) {
    const input = document.getElementById('quantityChange');
    if (input) {
        const currentValue = parseInt(input.value) || 0;
        input.value = currentValue + amount;
    }
}

// ===== Recherche en temps réel (optionnel) =====
const searchInput = document.querySelector('.search-input');
if (searchInput) {
    let searchTimeout;
    
    searchInput.addEventListener('input', function() {
        clearTimeout(searchTimeout);
        
        searchTimeout = setTimeout(() => {
            const searchTerm = this.value.trim();
            if (searchTerm.length >= 2) {
                // Optionnel: recherche AJAX en temps réel
                console.log('Recherche pour:', searchTerm);
            }
        }, 500);
    });
}

// ===== Animation des cartes =====
const observerOptions = {
    threshold: 0.1,
    rootMargin: '0px 0px -50px 0px'
};

const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            entry.target.style.opacity = '0';
            entry.target.style.transform = 'translateY(20px)';
            
            setTimeout(() => {
                entry.target.style.transition = 'all 0.5s ease-out';
                entry.target.style.opacity = '1';
                entry.target.style.transform = 'translateY(0)';
            }, 100);
            
            observer.unobserve(entry.target);
        }
    });
}, observerOptions);

// Observer toutes les cartes de produit
document.querySelectorAll('.product-card, .feature').forEach(card => {
    observer.observe(card);
});