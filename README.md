# **Product Management System – J2EE**

A complete web application for product management, built with **Java 21**, **J2EE (Servlets/JSP)**, and following a clean **Layered Architecture**.

---

## **📌 Table of Contents**

* [Architecture](#architecture)
* [Technologies Used](#technologies-used)
* [Prerequisites](#prerequisites)
* [Installation](#installation)
* [Project Structure](#project-structure)
* [Configuration](#configuration)
* [Running the Project](#running-the-project)
* [Features](#features)
* [Screenshots](#screenshots)
* [Best Practices](#best-practices)
* [API Documentation](#api-documentation)
* [Author](#author)

---

## **🏛 Architecture**

The project is based on a clean **Layered Architecture**:

```
┌─────────────────────────────────────┐
│   Presentation Layer (JSP/Servlet)  │
├─────────────────────────────────────┤
│        Service Layer (Business)     │
├─────────────────────────────────────┤
│       DAO Layer (Data Access)       │
├─────────────────────────────────────┤
│         Model Layer (Entity)        │
└─────────────────────────────────────┘
```

### **Layers Overview**

1. **Model Layer** (`com.gestion.model`)
   Contains business entities (e.g., `Product`).

2. **DAO Layer** (`com.gestion.dao`)
   Handles CRUD operations.
   Interfaces: `IProductDAO`
   Implementation: `ProductDAO`

3. **Service Layer** (`com.gestion.service`)
   Contains business logic and validation.
   Interfaces: `IProductService`
   Implementation: `ProductService`

4. **Presentation Layer** (`com.gestion.controller`)
   Servlets and JSP views.

5. **Configuration** (`com.gestion.config`)
   Database connection using Singleton.

---

## **🛠 Technologies Used**

* **Backend**: Java 21, J2EE (Servlets, JSP)
* **Frontend**: HTML5, CSS3, JavaScript
* **Database**: PostgreSQL
* **Application Server**: Apache Tomcat 9.x/10.x
* **JSTL**: Version 1.2

---

## **📦 Prerequisites**

* Java 17+ (Java 21 recommended)
* Apache Tomcat 9 or 10
* PostgreSQL 12+
* Maven (optional)
* Eclipse, IntelliJ or VS Code (recommended)

---

## **🚀 Installation**

### **1. Clone the repository**

```bash
git clone git@github.com:hardy0423/Product-Management-System-J2EE.git
cd ProductManagerWithJEE
```

### **2. Configure PostgreSQL**

Run the SQL schema:

```bash
sudo -u postgres psql -d gestion_produits -f database/schema.sql
```

---

## **📁 Project Structure**

```
ProductManagerWithJEE/
│
├── build/classes/                     
│
├── src/main/
│   ├── java/com/gestion/
│   │   ├── config/
│   │   │   └── DatabaseConnection.java
│   │   ├── model/
│   │   │   └── Product.java
│   │   ├── dao/
│   │   │   ├── IProductDAO.java
│   │   │   └── ProductDAO.java
│   │   ├── service/
│   │   │   ├── IProductService.java
│   │   │   ├── ProductService.java
│   │   │   └── ValidationException.java
│   │   ├── controller/
│   │   │   └── ProductServlet.java
│   │   └── filter/
│   │       └── CharacterEncodingFilter.java
│   │
│   └── webapp/
│       ├── META-INF/
│       │   └── MANIFEST.MF
│       ├── WEB-INF/
│       │   ├── lib/
│       │   ├── views/
│       │   │   ├── product-list.jsp
│       │   │   ├── product-form.jsp
│       │   │   ├── product-view.jsp
│       │   │   └── error.jsp
│       │   └── web.xml
│       ├── css/
│       │   └── style.css
│       ├── js/
│       │   └── main.js
│       └── index.jsp
│
├── database/
│   └── schema.sql
│
└── README.md
```

---

## **▶️ Running the Project**

### **With Eclipse**

1. Import the project as *Dynamic Web Project*
2. Right-click → **Run As → Run on Server**
3. Choose Tomcat
4. Open:
   **[http://localhost:8080/ProductManagerWithJEE/](http://localhost:8080/ProductManagerWithJEE/)**

### **With Tomcat (manual)**

```bash
cd $TOMCAT_HOME/bin
./startup.sh      # Linux / macOS
startup.bat       # Windows
```

Access the app:
➡ **[http://localhost:8080/ProductManagerWithJEE/](http://localhost:8080/ProductManagerWithJEE/)**

---

## **✨ Features**

### **CRUD Operations**

* Create a product
* View product list
* Edit existing products
* Delete products

### **Advanced Features**

* Product search by name
* Category filtering
* Stock management (add/remove quantities)
* Low-stock alerts
* Product statistics (count, total value)
* Server-side validation

---

## **📸 Screenshots**

* **Home Page** – modern dashboard-style interface
* **Product List** – search + filter
* **Product Form** – real-time validation
* **Product Details** – full description + stock controls

*(Screenshots can be added here)*

---

## **🎨 Best Practices Implemented**

### **Design Patterns**

* **Singleton** → Database connection
* **DAO Pattern** → Data access abstraction
* **Service Layer Pattern** → Business rules
* **MVC** → Clear separation
* **Interface Segregation** → DAO & Service interfaces

### **Security**

* Prepared Statements (protection from SQL injection)
* UTF-8 encoding filter
* Business validations on the server

### **Architecture Principles**

* Single Responsibility (SRP)
* Open/Closed Principle (OCP)
* Dependency Inversion (DIP)
* Centralized error management


