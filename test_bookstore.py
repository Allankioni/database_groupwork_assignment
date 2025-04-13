import mysql.connector
from mysql.connector import Error
import getpass
import time

def connect_to_database(username, password):
    try:
        connection = mysql.connector.connect(
            host='localhost',
            user=username,
            password=password,
            database='bookstore'
        )
        return connection
    except Error as e:
        print(f"Error connecting to MySQL: {e}")
        return None

def test_customer_permissions(cursor):
    print("\nTesting Customer Permissions...")
    try:
        # Test SELECT permissions (should work)
        print("\n1. Testing SELECT permissions:")
        tables = ['book', 'author', 'book_language', 'publisher']
        for table in tables:
            cursor.execute(f"SELECT * FROM {table} LIMIT 1")
            result = cursor.fetchone()
            print(f"✓ Successfully read from {table}")
        
        # Test modification permissions (should fail)
        print("\n2. Testing modification restrictions:")
        try:
            cursor.execute("INSERT INTO book (title, isbn, price) VALUES ('Test Book', '1234567890', 29.99)")
            print("✗ Should not be able to INSERT")
        except Error:
            print("✓ Correctly prevented from INSERTING")
        
        try:
            cursor.execute("UPDATE book SET price = 19.99 WHERE book_id = 1")
            print("✗ Should not be able to UPDATE")
        except Error:
            print("✓ Correctly prevented from UPDATING")
        
        try:
            cursor.execute("DELETE FROM book WHERE book_id = 1")
            print("✗ Should not be able to DELETE")
        except Error:
            print("✓ Correctly prevented from DELETING")
            
    except Error as e:
        print(f"Error during customer tests: {e}")

def test_staff_permissions(cursor):
    print("\nTesting Staff Permissions...")
    try:
        # Test SELECT and UPDATE permissions (should work)
        print("\n1. Testing SELECT and UPDATE permissions:")
        tables = ['cust_order', 'order_line', 'order_status']
        for table in tables:
            cursor.execute(f"SELECT * FROM {table} LIMIT 1")
            result = cursor.fetchone()
            print(f"✓ Successfully read from {table}")
        
        try:
            cursor.execute("UPDATE order_status SET status_name = 'Processing' WHERE status_id = 1")
            print("✓ Successfully UPDATED order_status")
        except Error:
            print("✗ Failed to UPDATE order_status")
        
        # Test restricted operations (should fail)
        print("\n2. Testing restricted operations:")
        try:
            cursor.execute("DELETE FROM customer WHERE customer_id = 1")
            print("✗ Should not be able to DELETE from customer")
        except Error:
            print("✓ Correctly prevented from DELETING customer")
            
        try:
            cursor.execute("ALTER TABLE book ADD COLUMN test_column INT")
            print("✗ Should not be able to ALTER table")
        except Error:
            print("✓ Correctly prevented from ALTERING table")
            
    except Error as e:
        print(f"Error during staff tests: {e}")

def test_manager_permissions(cursor):
    print("\nTesting Manager Permissions...")
    try:
        # Test customer operations (should work)
        print("\n1. Testing customer operations:")
        cursor.execute("SELECT * FROM customer LIMIT 1")
        result = cursor.fetchone()
        print("✓ Successfully read from customer")
        
        try:
            cursor.execute("UPDATE customer SET email = 'test@email.com' WHERE customer_id = 1")
            print("✓ Successfully UPDATED customer")
        except Error:
            print("✗ Failed to UPDATE customer")
        
        try:
            cursor.execute("DELETE FROM cust_order WHERE order_id = 1")
            print("✓ Successfully DELETED from cust_order")
        except Error:
            print("✗ Failed to DELETE from cust_order")
            
    except Error as e:
        print(f"Error during manager tests: {e}")

def test_admin_permissions(cursor):
    print("\nTesting Admin Permissions...")
    try:
        # Test database operations (should work)
        print("\n1. Testing database operations:")
        try:
            cursor.execute("CREATE TABLE test_table (id INT)")
            print("✓ Successfully CREATED table")
            
            cursor.execute("ALTER TABLE test_table ADD COLUMN name VARCHAR(50)")
            print("✓ Successfully ALTERED table")
            
            cursor.execute("DROP TABLE test_table")
            print("✓ Successfully DROPPED table")
        except Error:
            print("✗ Failed to perform database operations")
            
    except Error as e:
        print(f"Error during admin tests: {e}")

def main():
    print("Bookstore Database Testing Tool")
    print("===============================")
    
    # Get user credentials
    username = input("Enter username: ")
    password = getpass.getpass("Enter password: ")
    
    # Connect to database
    connection = connect_to_database(username, password)
    if not connection:
        print("Failed to connect to database. Exiting...")
        return
    
    cursor = connection.cursor()
    
    # Determine user role and run appropriate tests
    if username == 'customer':
        test_customer_permissions(cursor)
    elif username == 'staff':
        test_staff_permissions(cursor)
    elif username == 'manager':
        test_manager_permissions(cursor)
    elif username == 'admin':
        test_admin_permissions(cursor)
    else:
        print("Unknown user role. Please use one of: customer, staff, manager, admin")
    
    # Clean up
    cursor.close()
    connection.close()
    print("\nTesting completed!")

if __name__ == "__main__":
    main() 