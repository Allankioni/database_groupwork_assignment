-- Insert sample data into book_language
INSERT INTO book_language (language_name, language_code) VALUES
('English', 'EN'),
('Spanish', 'ES'),
('French', 'FR'),
('German', 'DE'),
('Italian', 'IT');

-- Insert sample data into publisher
INSERT INTO publisher (publisher_name, publisher_address, publisher_phone, publisher_email) VALUES
('Penguin Books', '80 Strand, London WC2R 0RL, UK', '+44 20 7010 3000', 'info@penguin.co.uk'),
('HarperCollins', '195 Broadway, New York, NY 10007, USA', '+1 212-207-7000', 'info@harpercollins.com'),
('Simon & Schuster', '1230 Avenue of the Americas, New York, NY 10020, USA', '+1 212-698-7000', 'info@simonandschuster.com'),
('Random House', '1745 Broadway, New York, NY 10019, USA', '+1 212-782-9000', 'info@randomhouse.com');

-- Insert sample data into author
INSERT INTO author (first_name, last_name, birth_date, nationality) VALUES
('J.K.', 'Rowling', '1965-07-31', 'British'),
('George R.R.', 'Martin', '1948-09-20', 'American'),
('Stephen', 'King', '1947-09-21', 'American'),
('Agatha', 'Christie', '1890-09-15', 'British'),
('J.R.R.', 'Tolkien', '1892-01-03', 'British'),
('Jane', 'Austen', '1775-12-16', 'British'),
('Ernest', 'Hemingway', '1899-07-21', 'American');

-- Insert sample data into book
INSERT INTO book (title, isbn, publication_date, price, stock_quantity, language_id, publisher_id) VALUES
('Harry Potter and the Philosopher''s Stone', '9780747532743', '1997-06-26', 19.99, 50, 1, 1),
('A Game of Thrones', '9780553103540', '1996-08-01', 24.99, 35, 1, 2),
('The Shining', '9780385129505', '1977-01-28', 17.99, 25, 1, 3),
('Murder on the Orient Express', '9780007119318', '1934-01-01', 14.99, 30, 1, 4),
('The Lord of the Rings', '9780261103252', '1954-07-29', 29.99, 40, 1, 1),
('Pride and Prejudice', '9780141439518', '1813-01-28', 12.99, 20, 1, 2),
('The Old Man and the Sea', '9780684801226', '1952-09-01', 15.99, 15, 1, 3);

-- Insert sample data into book_author
INSERT INTO book_author (book_id, author_id) VALUES
(1, 1), -- Harry Potter - J.K. Rowling
(2, 2), -- Game of Thrones - George R.R. Martin
(3, 3), -- The Shining - Stephen King
(4, 4), -- Murder on the Orient Express - Agatha Christie
(5, 5), -- Lord of the Rings - J.R.R. Tolkien
(6, 6), -- Pride and Prejudice - Jane Austen
(7, 7); -- The Old Man and the Sea - Ernest Hemingway

-- Insert sample data into country
INSERT INTO country (country_name, country_code) VALUES
('United States', 'USA'),
('United Kingdom', 'GBR'),
('Canada', 'CAN'),
('Australia', 'AUS'),
('Germany', 'DEU');

-- Insert sample data into address_status
INSERT INTO address_status (status_name) VALUES
('Current'),
('Previous'),
('Billing'),
('Shipping');

-- Insert sample data into address
INSERT INTO address (street_address, city, state, postal_code, country_id) VALUES
('123 Main St', 'New York', 'NY', '10001', 1),
('456 Oxford St', 'London', NULL, 'W1D 2HG', 2),
('789 Queen St', 'Toronto', 'ON', 'M5H 2N2', 3),
('321 Collins St', 'Melbourne', 'VIC', '3000', 4),
('654 Friedrichstr', 'Berlin', NULL, '10117', 5);

-- Insert sample data into customer
INSERT INTO customer (first_name, last_name, email, phone, registration_date) VALUES
('John', 'Doe', 'john.doe@email.com', '+1 212-555-1234', '2023-01-15'),
('Jane', 'Smith', 'jane.smith@email.com', '+44 20 7123 4567', '2023-02-20'),
('Robert', 'Johnson', 'robert.j@email.com', '+1 416-555-7890', '2023-03-10'),
('Emily', 'Brown', 'emily.b@email.com', '+61 3 9876 5432', '2023-04-05'),
('Michael', 'Wilson', 'michael.w@email.com', '+49 30 1234 5678', '2023-05-12');

-- Insert sample data into customer_address
INSERT INTO customer_address (customer_id, address_id, status_id) VALUES
(1, 1, 1), -- John Doe - Current address
(1, 2, 3), -- John Doe - Billing address
(2, 2, 1), -- Jane Smith - Current address
(3, 3, 1), -- Robert Johnson - Current address
(4, 4, 1), -- Emily Brown - Current address
(5, 5, 1); -- Michael Wilson - Current address

-- Insert sample data into shipping_method
INSERT INTO shipping_method (method_name, cost) VALUES
('Standard Shipping', 5.99),
('Express Shipping', 12.99),
('International Shipping', 19.99),
('Next Day Delivery', 24.99);

-- Insert sample data into order_status
INSERT INTO order_status (status_name) VALUES
('Pending'),
('Processing'),
('Shipped'),
('Delivered'),
('Cancelled');

-- Insert sample data into cust_order
INSERT INTO cust_order (customer_id, order_date, shipping_address_id, shipping_method_id, order_status_id) VALUES
(1, '2023-06-01 10:30:00', 1, 1, 4), -- John Doe - Delivered
(2, '2023-06-05 14:15:00', 2, 2, 3), -- Jane Smith - Shipped
(3, '2023-06-10 09:45:00', 3, 1, 2), -- Robert Johnson - Processing
(4, '2023-06-15 16:20:00', 4, 3, 1), -- Emily Brown - Pending
(5, '2023-06-20 11:10:00', 5, 4, 3); -- Michael Wilson - Shipped

-- Insert sample data into order_line
INSERT INTO order_line (order_id, book_id, quantity, price) VALUES
(1, 1, 1, 19.99), -- John's order - Harry Potter
(1, 3, 1, 17.99), -- John's order - The Shining
(2, 2, 1, 24.99), -- Jane's order - Game of Thrones
(3, 5, 1, 29.99), -- Robert's order - Lord of the Rings
(4, 6, 2, 12.99), -- Emily's order - Pride and Prejudice (2 copies)
(5, 7, 1, 15.99); -- Michael's order - The Old Man and the Sea

-- Insert sample data into order_history
INSERT INTO order_history (order_id, status_id, status_date) VALUES
(1, 1, '2023-06-01 10:30:00'), -- John's order - Pending
(1, 2, '2023-06-01 11:00:00'), -- John's order - Processing
(1, 3, '2023-06-02 09:00:00'), -- John's order - Shipped
(1, 4, '2023-06-04 14:00:00'), -- John's order - Delivered
(2, 1, '2023-06-05 14:15:00'), -- Jane's order - Pending
(2, 2, '2023-06-05 15:00:00'), -- Jane's order - Processing
(2, 3, '2023-06-06 10:00:00'), -- Jane's order - Shipped
(3, 1, '2023-06-10 09:45:00'), -- Robert's order - Pending
(3, 2, '2023-06-10 10:30:00'), -- Robert's order - Processing
(4, 1, '2023-06-15 16:20:00'), -- Emily's order - Pending
(5, 1, '2023-06-20 11:10:00'), -- Michael's order - Pending
(5, 2, '2023-06-20 12:00:00'), -- Michael's order - Processing
(5, 3, '2023-06-21 09:00:00'); -- Michael's order - Shipped 