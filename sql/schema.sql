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

