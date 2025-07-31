-- Schema Version: v0.1.0 - Initial schema with users table

CREATE TABLE IF NOT EXISTS users (
     id INT AUTO_INCREMENT PRIMARY KEY,
     username VARCHAR(50) NOT NULL UNIQUE,
     password VARCHAR(225) NOT NULL,
     role VARCHAR(20) NOT NULL,
     created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS customers (
     id INT AUTO_INCREMENT PRIMARY KEY,
     account_number VARCHAR(20) NOT NULL UNIQUE,
     name VARCHAR(100) NOT NULL,
     address TEXT,
     phone VARCHAR(20),
     units_consumed INT DEFAULT 0,
     created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS items (
       id INT PRIMARY KEY AUTO_INCREMENT,
       code VARCHAR(20) NOT NULL UNIQUE,
       name VARCHAR(100) NOT NULL,
       category VARCHAR(50),
       unit_price DECIMAL(10,2) NOT NULL,
       stock_qty INT NOT NULL
);

CREATE TABLE IF NOT EXISTS `bills` (
       `id` INT NOT NULL AUTO_INCREMENT,
       `customer_id` INT NOT NULL,
       `billing_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
       `total_amount` DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
       `status` VARCHAR(20) NOT NULL DEFAULT 'unpaid',
       PRIMARY KEY (`id`),
       CONSTRAINT `fk_bills_customer` FOREIGN KEY (`customer_id`) REFERENCES `customers`(`id`)
);

CREATE TABLE IF NOT EXISTS `bill_items` (
        `id` INT NOT NULL AUTO_INCREMENT,
        `bill_id` INT NOT NULL,
        `item_id` INT NOT NULL,
        `quantity` INT NOT NULL CHECK (`quantity` > 0),
        `unit_price` DECIMAL(10, 2) NOT NULL CHECK (`unit_price` >= 0),
        `line_total` DECIMAL(10, 2) NOT NULL CHECK (`line_total` >= 0),
        PRIMARY KEY (`id`),
        CONSTRAINT `fk_bill_items_bill` FOREIGN KEY (`bill_id`) REFERENCES `bills`(`id`) ON DELETE CASCADE,
        CONSTRAINT `fk_bill_items_item` FOREIGN KEY (`item_id`) REFERENCES `items`(`id`)
);



