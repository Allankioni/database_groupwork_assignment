# Bookstore Database Management System

A comprehensive MySQL-based database management system for a bookstore, featuring role-based access control, order management, and inventory tracking.

## System Overview

The Bookstore Database Management System is designed to handle all aspects of a modern bookstore's operations, including:
- Book inventory management
- Customer order processing
- User role management
- Order tracking and history
- Multi-language book support

## Database Schema

### Core Tables

#### Book-Related Tables
- **book**: Stores book information (title, ISBN, price, stock)
- **author**: Contains author details
- **book_author**: Manages many-to-many relationship between books and authors
- **book_language**: Supports multiple language editions
- **publisher**: Maintains publisher information

#### Customer and Order Tables
- **customer**: Stores customer information
- **address**: Manages shipping and billing addresses
- **country**: Contains country information for addresses
- **customer_address**: Links customers with their addresses

#### Order Management Tables
- **cust_order**: Main order table
- **order_line**: Individual items in orders
- **order_status**: Tracks order statuses
- **order_history**: Maintains order status history
- **shipping_method**: Available shipping options

## User Roles and Permissions

### 1. Admin Role
- Full system access
- Database structure modifications
- User management
- All CRUD operations

### 2. Manager Role
- Customer management
- Order management
- Inventory control
- Staff supervision
- Access to all operational data

### 3. Staff Role
Permissions include:
- View and update order status
- Manage book inventory
- Process customer orders
- Access to staff_order_view
- Cannot delete customer records or modify database structure

### 4. Customer Role
Limited to:
- View book information
- Access to customer_book_view
- Browse authors and publishers
- View book languages
- No modification permissions

## Testing System

The system includes a comprehensive testing tool (`test_bookstore.py`) that verifies:

### Permission Testing
1. **Customer Permissions**
   - Verify read access to books, authors, languages
   - Confirm restriction on modifications

2. **Staff Permissions**
   - Test order management capabilities
   - Verify inventory update permissions
   - Confirm structural modification restrictions

3. **Manager Permissions**
   - Test customer data management
   - Verify order deletion capabilities
   - Confirm full operational access

4. **Admin Permissions**
   - Test database structure modifications
   - Verify complete system access

## Database Views

### Customer Book View
```sql
customer_book_view: Displays book information with author details
- Title
- Author name
- Price
- Stock quantity
```

### Staff Order View
```sql
staff_order_view: Shows comprehensive order information
- Order details
- Customer information
- Order status
- Shipping method
```

## Security Features

- Role-based access control
- Password-protected user accounts
- Restricted database operations based on user role
- View-based data access control

## Setup and Configuration

1. Database Setup:
   - Execute `bookstore_schema.sql` to create database structure
   - Run `bookstore_users.sql` to set up user roles and permissions
   - Import `bookstore_sample_data.sql` for initial data

2. User Credentials:
   - Admin: username='admin', password='Admin@123'
   - Manager: username='manager', password='Manager@123'
   - Staff: username='staff', password='Staff@123'
   - Customer: username='customer', password='Customer@123'

## Testing Instructions

### Automated Testing
1. Run the testing tool:
```bash
python test_bookstore.py
```

2. Enter credentials for the role you want to test
3. The system will automatically run appropriate tests for the given role
4. Review test results for permission verification

### SQL Query Testing
Execute `bookstore_queries.sql` to test the database functionality:
```sql
source bookstore_queries.sql;
```
This file contains various SQL commands to test:
- Table relationships
- Data integrity
- Role-based permissions
- Complex queries and views

## Database Structure and Relationships

### Visual Representation
The `database_diagram.drawio` file provides a comprehensive visual representation of:
- Table structures and relationships
- Primary and foreign key connections
- Data flow between entities
- Entity relationship diagrams

### Key Relationships
- Books can have multiple authors (many-to-many)
- Books belong to one language and publisher (one-to-many)
- Customers can have multiple addresses
- Orders contain multiple order lines
- Order status changes are tracked in order history

## Best Practices

- Always use appropriate user roles for operations
- Regularly backup the database
- Monitor order history for tracking
- Maintain accurate inventory counts
- Use views for simplified data access