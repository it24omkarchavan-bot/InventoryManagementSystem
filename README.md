# StockFlow - Inventory Management System

A complete Java web-based Inventory Management System built with:

- Java 17
- JSP
- Jakarta Servlet 6
- Maven
- MySQL 8
- Apache Tomcat 10.1
- HTML/CSS
- Docker / Docker Compose
- Jenkins
- Selenium + JUnit

## Features

- Dashboard with inventory statistics
- Add products
- Edit products
- Delete products
- Search products
- Filter by category
- SKU management
- Supplier management
- Quantity and reorder-level tracking
- Automatic stock status:
  - In Stock
  - Low Stock
  - Out of Stock
- Inventory valuation
- Responsive professional UI
- MySQL persistent storage
- Docker Compose setup
- Jenkins pipeline
- Selenium smoke tests

## Option A - Run with Docker Compose

Requirements:
- Docker Desktop
- Maven
- Java 17

Build the WAR:

```cmd
mvn clean package
```

Then:

```cmd
docker compose up --build -d
```

Open:

http://localhost:8081/InventoryManagementSystem/

Dashboard:

http://localhost:8081/InventoryManagementSystem/dashboard

Inventory:

http://localhost:8081/InventoryManagementSystem/inventory

MySQL is exposed on host port 3307.

## Option B - Run with local Tomcat + local MySQL

1. Create database using `database/init.sql`.
2. Start MySQL.
3. Build:

```cmd
mvn clean package
```

4. Copy:

`target/InventoryManagementSystem.war`

to:

`TOMCAT_HOME/webapps/`

5. Start Tomcat.

Default local database settings:

- Database: inventorydb
- User: inventory
- Password: inventory123
- Host: localhost
- Port: 3306

You can override them with environment variables:

DB_URL
DB_USER
DB_PASSWORD

## Important port note

Docker Compose uses:

- Web app: http://localhost:8081
- MySQL: localhost:3307

This avoids conflicts if Jenkins or another Tomcat is already using port 8080.

## Selenium

Start the Docker application first, then run:

```cmd
mvn test
```

Chrome must be installed. Selenium Manager included with Selenium 4 can automatically manage the Chrome driver.

## Project structure

InventoryManagementSystem/
├── pom.xml
├── Dockerfile
├── docker-compose.yml
├── Jenkinsfile
├── README.md
├── database/
│   └── init.sql
└── src/
    ├── main/
    │   ├── java/com/myapp/
    │   │   ├── DBConnection.java
    │   │   ├── DashboardServlet.java
    │   │   ├── InventoryDAO.java
    │   │   ├── InventoryItem.java
    │   │   └── InventoryServlet.java
    │   └── webapp/
    │       ├── dashboard.jsp
    │       ├── edit.jsp
    │       ├── index.jsp
    │       ├── inventory.jsp
    │       ├── css/style.css
    │       └── WEB-INF/web.xml
    └── test/
        └── java/com/myapp/InventorySeleniumTest.java
