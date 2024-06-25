DROP DATABASE IF EXISTS Bookshop;
CREATE DATABASE Bookshop;
USE Bookshop;

-- create tables
CREATE TABLE Publisher (
    publisherID VARCHAR(255) PRIMARY KEY,
    publisher_name VARCHAR(255),
    publisher_country VARCHAR(255)
);

CREATE TABLE Books (
    bookID VARCHAR(255) PRIMARY KEY,
    title VARCHAR(255),
    author VARCHAR(255),
    price DECIMAL(10,2),
    publisherID VARCHAR(255),
    FOREIGN KEY (publisherID) REFERENCES Publisher(publisherID),
    INDEX (price)
);

CREATE TABLE Customers (
    customerID VARCHAR(255) PRIMARY KEY,
    customer_name VARCHAR(255),
    customer_address VARCHAR(255),
    customer_email VARCHAR(255)
);

CREATE TABLE Book_Orders (
    bookID VARCHAR(255),
    order_date DATE,
    order_price DECIMAL(10,2),
    customerID VARCHAR(255),
    CONSTRAINT fk_bookID FOREIGN KEY (bookID) REFERENCES Books(bookID),
    CONSTRAINT fk_bookprice FOREIGN KEY (order_price) REFERENCES Books(price),
    CONSTRAINT fk_customerID FOREIGN KEY (customerID) REFERENCES Customers(customerID)
);


-- insert data into tables
insert into Publisher
(publisherID, publisher_name, publisher_country)
values
('P1', 'Orion', 'France'),
('P2', 'Harper Collins', 'United Kingdom'),
('P3', 'Bantam', 'United Kingdom'),
('P4', '4th Estate', 'USA'),
('P5', 'Bourdon', 'Czech Republic');

insert into Books
(bookID, title, author, price, publisherID)
values
('B1','Labyrinth','Kate Mosse', 15.99, 'P1'),
('B2','The Hobbit', 'J.R.R. Tolkien', 19.99, 'P2'),
('B3', 'Tom Lake', 'Ann Patchett', 9.99, 'P2'),
('B4', 'Medea', 'Rosie Hewlett', 21.99, 'P3'),
('B5', 'Really good, actually', 'Monica Heisey', '11.99', 'P4'),
('B6', 'Gazely ', 'Patrik Hartl', 25.99, 'P5');

INSERT INTO Customers (customerID, customer_name, customer_address, customer_email)
VALUES 
    ('C1', 'John Doe', '123 Main Street', 'john@example.com'),
    ('C2', 'Jane Smith', '456 Elm Street', 'jane@example.com'),
    ('C3', 'Alice Johnson', '789 Oak Street', 'alice@example.com'),
    ('C4', 'Bob Brown', '101 Pine Street', 'bob@example.com'),
    ('C5', 'Emily Davis', '202 Maple Street', 'emily@example.com');

INSERT INTO Book_Orders (bookID, order_date, customerID)
VALUES 
    ('B1', '2024-06-10', 'C1'),
    ('B4', '2024-06-10', 'C1'),
    ('B2', '2024-06-09', 'C2'),
    ('B3', '2024-03-26', 'C2'),
    ('B3', '2024-06-08', 'C3'),
    ('B4', '2024-06-07', 'C4'),
    ('B5', '2024-06-06', 'C5');
    

-- a summary of book orders along with customer and publisher details
CREATE VIEW BookOrdersView AS
SELECT 
    bo.bookID,
    b.title,
    b.author,
    b.price,
    p.publisher_name,
    p.publisher_country,
    c.customerID,
    c.customer_name,
    c.customer_address,
    c.customer_email,
    bo.order_date
FROM 
    Book_Orders bo
JOIN 
    Books b ON bo.bookID = b.bookID
JOIN 
    Publisher p ON b.publisherID = p.publisherID
JOIN 
    Customers c ON bo.customerID = c.customerID;


-- generate a function to calculate the total_spend of each customer
DELIMITER //

CREATE FUNCTION TotalSpentByCustomer(custID VARCHAR(255)) 
RETURNS DECIMAL(10,2)
READS SQL DATA
BEGIN
    DECLARE total_spent DECIMAL(10,2);
    
    SELECT SUM(b.price) INTO total_spent
    FROM Book_Orders bo
    JOIN Books b ON bo.bookID = b.bookID
    WHERE bo.customerID = custID;
    
    RETURN total_spent;
END //

DELIMITER ;


-- find the customers spent over 20.00 in the bookstore
SELECT 
    customer_name, 
    customer_email,
    TotalSpent
FROM 
    (SELECT 
        c.customer_name,
        c.customer_email,
        TotalSpentByCustomer(c.customerID) AS TotalSpent
     FROM 
        Customers c) AS CustomerSpending
WHERE 
    TotalSpent > 20.00;