CREATE DATABASE IF NOT EXISTS inventorydb;
USE inventorydb;

CREATE TABLE IF NOT EXISTS products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(120) NOT NULL,
    sku VARCHAR(50) NOT NULL UNIQUE,
    category VARCHAR(60) NOT NULL,
    quantity INT NOT NULL DEFAULT 0,
    reorder_level INT NOT NULL DEFAULT 10,
    price DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    supplier VARCHAR(120) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT IGNORE INTO products (name,sku,category,quantity,reorder_level,price,supplier) VALUES
('Business Laptop Pro','LAP-1001','Electronics',18,5,65000,'TechSource India'),
('Wireless Keyboard','KEY-1002','Accessories',7,10,1800,'Peripherals Hub'),
('24-inch LED Monitor','MON-1003','Electronics',12,5,12500,'Display World'),
('Office Chair','CHR-1004','Furniture',4,6,8500,'Comfort Office'),
('USB-C Docking Station','DOC-1005','Accessories',0,5,6200,'ConnectIT'),
('A4 Printer Paper','PAP-1006','Office',55,20,420,'OfficeMart');
