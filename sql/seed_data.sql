-- Sample users for testing login functionality

INSERT INTO users (username, password, role) VALUES
     ('admin', 'admin123', 'admin'),
     ('staff', 'staff123', 'staff'),
     ('user1', 'user123', 'customer'),
     ('testuser', 'testpass', 'tester');

INSERT INTO customers (account_number, name, address, phone, units_consumed) VALUES
     ('CUST001', 'Nimal Perera', '123 Galle Road, Colombo', '0771234567', 120),
     ('CUST002', 'Samantha Silva', '45 Kandy Street, Kandy', '0719876543', 85);
