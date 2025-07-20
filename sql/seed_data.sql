-- Sample users for testing login functionality

INSERT INTO users (username, password, role) VALUES
     ('admin', 'admin123', 'admin'),
     ('staff', 'staff123', 'staff'),
     ('user1', 'user123', 'customer'),
     ('testuser', 'testpass', 'tester');

INSERT INTO customers (account_number, name, address, phone, units_consumed) VALUES
     ('CUST001', 'Nimal Perera', '123 Galle Road, Colombo', '0771234567', 120),
     ('CUST002', 'Samantha Silva', '45 Kandy Street, Kandy', '0719876543', 85);

INSERT INTO items (code, name, category, unit_price, stock_qty) VALUES
     ('BK001', 'Introduction to Java', 'Programming', 1200.00, 10),
     ('BK002', 'Advanced SQL', 'Database', 950.50, 5);


INSERT INTO `bills` (`customer_id`, `billing_date`, `total_amount`, `status`) VALUES
      (1, CURDATE(), 150.00, 'paid'),
      (2, CURDATE(), 80.00, 'unpaid');

INSERT INTO `bill_items` (`bill_id`, `item_id`, `quantity`, `unit_price`, `line_total`) VALUES
        (1, 1, 2, 50.00, 100.00),
        (1, 2, 1, 50.00, 50.00),
        (2, 1, 1, 80.00, 80.00);
