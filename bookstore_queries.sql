-- 1. Basic Book Information
-- Show all books with their authors and publishers
SELECT 
    b.title,
    CONCAT(a.first_name, ' ', a.last_name) as author,
    p.publisher_name,
    b.price,
    b.stock_quantity
FROM book b
JOIN book_author ba ON b.book_id = ba.book_id
JOIN author a ON ba.author_id = a.author_id
JOIN publisher p ON b.publisher_id = p.publisher_id
ORDER BY b.title;

-- 2. Customer Orders
-- Show all orders with customer details and order status
SELECT 
    o.order_id,
    CONCAT(c.first_name, ' ', c.last_name) as customer,
    c.email,
    o.order_date,
    os.status_name as order_status,
    sm.method_name as shipping_method,
    sm.cost as shipping_cost
FROM cust_order o
JOIN customer c ON o.customer_id = c.customer_id
JOIN order_status os ON o.order_status_id = os.status_id
JOIN shipping_method sm ON o.shipping_method_id = sm.method_id
ORDER BY o.order_date DESC;

-- 3. Order Details
-- Show detailed information about a specific order (Order ID 1)
SELECT 
    ol.order_id,
    b.title,
    ol.quantity,
    ol.price as unit_price,
    (ol.quantity * ol.price) as total_price
FROM order_line ol
JOIN book b ON ol.book_id = b.book_id
WHERE ol.order_id = 1;

-- 4. Order History
-- Show complete history of an order (Order ID 1)
SELECT 
    oh.order_id,
    os.status_name,
    oh.status_date
FROM order_history oh
JOIN order_status os ON oh.status_id = os.status_id
WHERE oh.order_id = 1
ORDER BY oh.status_date;

-- 5. Customer Addresses
-- Show all addresses for a customer (Customer ID 1)
SELECT 
    c.first_name,
    c.last_name,
    a.street_address,
    a.city,
    a.state,
    a.postal_code,
    co.country_name,
    ast.status_name as address_type
FROM customer c
JOIN customer_address ca ON c.customer_id = ca.customer_id
JOIN address a ON ca.address_id = a.address_id
JOIN country co ON a.country_id = co.country_id
JOIN address_status ast ON ca.status_id = ast.status_id
WHERE c.customer_id = 1;

-- 6. Stock Management
-- Show books with low stock (less than 30 copies)
SELECT 
    b.title,
    b.stock_quantity,
    p.publisher_name
FROM book b
JOIN publisher p ON b.publisher_id = p.publisher_id
WHERE b.stock_quantity < 30
ORDER BY b.stock_quantity;

-- 7. Sales Analysis
-- Show total sales by book
SELECT 
    b.title,
    COUNT(ol.order_id) as total_orders,
    SUM(ol.quantity) as total_quantity_sold,
    SUM(ol.quantity * ol.price) as total_revenue
FROM book b
LEFT JOIN order_line ol ON b.book_id = ol.book_id
GROUP BY b.book_id, b.title
ORDER BY total_revenue DESC;

-- 8. Customer Spending
-- Show total spending by customer
SELECT 
    CONCAT(c.first_name, ' ', c.last_name) as customer,
    COUNT(DISTINCT o.order_id) as total_orders,
    SUM(ol.quantity * ol.price) as total_spent
FROM customer c
JOIN cust_order o ON c.customer_id = o.customer_id
JOIN order_line ol ON o.order_id = ol.order_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spent DESC;

-- 9. Shipping Analysis
-- Show orders by shipping method
SELECT 
    sm.method_name,
    COUNT(o.order_id) as total_orders,
    SUM(sm.cost) as total_shipping_revenue
FROM shipping_method sm
LEFT JOIN cust_order o ON sm.method_id = o.shipping_method_id
GROUP BY sm.method_id, sm.method_name
ORDER BY total_orders DESC;

-- 10. Book Language Distribution
-- Show books by language
SELECT 
    bl.language_name,
    COUNT(b.book_id) as total_books,
    AVG(b.price) as average_price
FROM book_language bl
LEFT JOIN book b ON bl.language_id = b.language_id
GROUP BY bl.language_id, bl.language_name
ORDER BY total_books DESC; 