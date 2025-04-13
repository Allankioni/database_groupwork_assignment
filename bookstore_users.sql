-- Create roles for different access levels
CREATE ROLE IF NOT EXISTS 'bookstore_admin', 'bookstore_manager', 'bookstore_staff', 'bookstore_customer';

-- Grant all privileges to admin role
GRANT ALL PRIVILEGES ON bookstore.* TO 'bookstore_admin';

-- Grant privileges to manager role
GRANT SELECT, INSERT, UPDATE, DELETE ON bookstore.* TO 'bookstore_manager';
GRANT EXECUTE ON bookstore.* TO 'bookstore_manager';

-- Grant privileges to staff role
GRANT SELECT, INSERT, UPDATE ON bookstore.book TO 'bookstore_staff';
GRANT SELECT, INSERT, UPDATE ON bookstore.author TO 'bookstore_staff';
GRANT SELECT, INSERT, UPDATE ON bookstore.book_author TO 'bookstore_staff';
GRANT SELECT, INSERT, UPDATE ON bookstore.publisher TO 'bookstore_staff';
GRANT SELECT, INSERT, UPDATE ON bookstore.cust_order TO 'bookstore_staff';
GRANT SELECT, INSERT, UPDATE ON bookstore.order_line TO 'bookstore_staff';
GRANT SELECT, INSERT, UPDATE ON bookstore.order_history TO 'bookstore_staff';
GRANT SELECT, INSERT, UPDATE ON bookstore.order_status TO 'bookstore_staff';

-- Grant privileges to customer role
GRANT SELECT ON bookstore.book TO 'bookstore_customer';
GRANT SELECT ON bookstore.author TO 'bookstore_customer';
GRANT SELECT ON bookstore.book_author TO 'bookstore_customer';
GRANT SELECT ON bookstore.book_language TO 'bookstore_customer';
GRANT SELECT ON bookstore.publisher TO 'bookstore_customer';

-- Create users and assign roles
-- Admin user
CREATE USER IF NOT EXISTS 'admin'@'localhost' IDENTIFIED BY 'Admin@123';
GRANT 'bookstore_admin' TO 'admin'@'localhost';
SET DEFAULT ROLE 'bookstore_admin' TO 'admin'@'localhost';

-- Manager user
CREATE USER IF NOT EXISTS 'manager'@'localhost' IDENTIFIED BY 'Manager@123';
GRANT 'bookstore_manager' TO 'manager'@'localhost';
SET DEFAULT ROLE 'bookstore_manager' TO 'manager'@'localhost';

-- Staff user
CREATE USER IF NOT EXISTS 'staff'@'localhost' IDENTIFIED BY 'Staff@123';
GRANT 'bookstore_staff' TO 'staff'@'localhost';
SET DEFAULT ROLE 'bookstore_staff' TO 'staff'@'localhost';

-- Customer user
CREATE USER IF NOT EXISTS 'customer'@'localhost' IDENTIFIED BY 'Customer@123';
GRANT 'bookstore_customer' TO 'customer'@'localhost';
SET DEFAULT ROLE 'bookstore_customer' TO 'customer'@'localhost';

-- Create customer book view
CREATE OR REPLACE VIEW customer_book_view AS
SELECT 
    b.title,
    CONCAT(a.first_name, ' ', a.last_name) as author_name,
    b.price,
    b.stock_quantity
FROM book b
LEFT JOIN book_author ba ON b.book_id = ba.book_id
LEFT JOIN author a ON ba.author_id = a.author_id;

-- Grant access to customer book view
GRANT SELECT ON bookstore.customer_book_view TO 'bookstore_customer';

-- Flush privileges to apply changes
FLUSH PRIVILEGES;

-- Create views for different user roles
-- View for staff to see order details
CREATE OR REPLACE VIEW staff_order_view AS
SELECT 
    co.order_id,
    c.first_name,
    c.last_name,
    c.email,
    co.order_date,
    os.status_name as order_status,
    sm.method_name as shipping_method
FROM cust_order co
JOIN customer c ON co.customer_id = c.customer_id
JOIN order_status os ON co.order_status_id = os.status_id
JOIN shipping_method sm ON co.shipping_method_id = sm.method_id;

-- Grant access to views
GRANT SELECT ON bookstore.staff_order_view TO 'bookstore_staff';
GRANT SELECT ON bookstore.customer_book_view TO 'bookstore_customer'; 