-- Database

CREATE DATABASE shop;

-- Tables 

CREATE TABLE customers(
    id SERIAL PRIMARY KEY, 
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL, 
    Gender VARCHAR NOT NULL, 
    Address VARCHAR(200) NOT NULL, 
    Phone BIGINT NOT NULL, 
    Email VARCHAR(100) NOT NULL, 
    City VARCHAR(20) NOT NULL, 
    Country VARCHAR(50) NOT NULL 
);


CREATE TABLE employees(
    id SERIAL PRIMARY KEY, 
    FirstName VARCHAR(50) NOT NULL, 
    LastName VARCHAR(50) NOT NULL, 
    Email VARCHAR(100) NOT NULL, 
    JobTitle VARCHAR(20) NOT NULL
);


CREATE TABLE products(
    id SERIAL PRIMARY KEY, 
    ProductName VARCHAR(100) NOT NULL, 
    Description VARCHAR(300) NOT NULL,
    BuyPrice decimal NOT NULL
);


CREATE TABLE payments(
    CustomerID INT NOT NULL references customers(id),
    id SERIAL PRIMARY KEY, 
    PaymentDate DATE NOT NULL,
    Amount decimal NOT NULL
);


CREATE TABLE orders(
    id SERIAL PRIMARY KEY, 
    ProductID INT NOT NULL references products(id), 
    PaymentID INT NOT NULL references payments(id), 
    FulfilledByEmployeeID INT NOT NULL references employees(id),
    DateRequired DATE NOT NULL, 
    DateShipped DATE, 
    Status VARCHAR(20) NOT NULL
);


-- Records

INSERT INTO customers(FirstName, LastName, Gender, Address, Phone, Email, City, Country) 
VALUES ('John', 'Hibert', 'Male', '284 chaucer st', 084789657, 'john@gmail.com', 'Johannesburg', 'South Africa'), 
('Thando', 'Sithole', 'Female', '240 Sect 1', 0794445584, 'thando@gmail.com', 'Cape Town', 'South Africa'), 
('Leon', 'Glen', 'Male', '81 Everton Rd,Gillits', 0820832830, 'Leon@gmail.com', 'Durban', 'South Africa'),
('Charl', 'Muller', 'Mal', '290A Dorset Ecke', +44856872553, 'Charl.muller@yahoo.com', 'Berlin', 'Germany'),
('Julia', 'Stein', 'Female', '2 Wernerring', +448672445058, 'Js234@yahoo.com', 'Frankfurt', 'Germany');


INSERT INTO employees(FirstName, LastName, Email, JobTitle) 
VALUES('Kani','Matthew', 'mat@gmail.com', 'Manager'), 
('Lesly', 'Cronje', 'LesC@gmail.com', 'Clerk'),
('Gideon', 'Maduku', 'm@gmail.com', 'Accountant');


INSERT INTO products(ProductName, Description, BuyPrice) 
VALUES('Harley Davidson Chopper', 'This replica features working kickstand, front suspension, gear-shift lever', 150.75), 
('Classic Car', 'Turnable front wheels, steering function', 550.75), 
('Sports car', 'Turnable front wheels, steering function', 700.60);


INSERT INTO payments(CustomerID, PaymentDate, Amount) 
VALUES(1, '01-09-2018', 150.75),
(5, '03-09-2018', 150.75),
(4, '03-09-2018', 700.60);


INSERT INTO orders(ProductID, PaymentID, FulfilledByEmployeeID, DateRequired, DateShipped, Status) 
VALUES(1,1,2,'05-09-2018', NULL, 'Not shipped'),
(1,2,2, '04-09-2018', '03-09-2018', 'Shipped'),
(3,3,3, '06-09-2018', NULL, 'Not shipped');


--Queries

SELECT * FROM customers;

SELECT FirstName, LastName FROM customers;

SELECT FirstName, LastName FROM customers WHERE id = 1; 

UPDATE customers SET FirstName = 'Lerato', LastName = 'Mabitso' WHERE id = 1;

DELETE FROM customers WHERE id = 2;

SELECT Status, COUNT(Status) FROM orders GROUP BY Status;

SELECT MAX(amount) AS Max_Payment FROM payments;

SELECT * FROM customers ORDER BY Country;

SELECT * FROM products WHERE BuyPrice BETWEEN 100 AND 600;

SELECT * FROM customers WHERE Country = 'Germany' AND City = 'Berlin';

SELECT * FROM customers WHERE City = 'Cape Town' OR City = 'Durban';

SELECT * FROM products WHERE BuyPrice > 500;

SELECT SUM(Amount) AS Sum_Payments FROM payments;

SELECT COUNT(id) AS No_Shipped_Orders FROM orders WHERE Status = 'Shipped';

SELECT ROUND(AVG(buyprice),2) AS AVG_Rands, ROUND(AVG(buyprice)/12 , 2) AS AVG_Dollars FROM products;
 
SELECT *
FROM payments
INNER JOIN customers
ON payments.CustomerID = customers.id;

SELECT * 
FROM products
WHERE Description ~* '.*turnable front wheels.*';
