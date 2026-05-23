USE classicmodels;
show tables;

SELECT * FROM customers;

-- Show all the customers : customerName,contactFirstName, contactLastName ,country, creditlimit
SELECT customername, contactfirstname, contactlastname,country,creditlimit
FROM customers;

-- List all the customers in USA and France

SELECT * FROM customers
WHERE country = "USA" OR country= 'France';

-- List all the customers in USA with a credit limit higher than $1000

SELECT * FROM customers
WHERE country = "USA" AND creditLimit > 1000;

-- List all the customers in Autralia and Norway with a credit limit higher than $1000

SELECT * FROM customers
WHERE country = "Australia" OR country = "Norway" AND creditlimit > 1000;

-- List all the customers in USA, France, Australia, Poland

SELECT * FROM customers
WHERE country IN ('USA','France','Australia','Poland');

-- List the employee codes for sales representatives of customers in Spain, France and Italy. 
-- Make another query to list the names and email addresses of those employees.

SELECT DISTINCT salesRepEmployeeNumber FROM Customers
WHERE country IN ('Spain','France','Italy');

SELECT * FROM employees;

SELECT employeenumber, firstname, lastname, email, officeCode FROM employees
WHERE employeeNumber in (1370,1337,1702,1401);

-- Change the job title "Sales Rep" to "Sales Representative"
SELECT * FROM employees;

SET SQL_SAFE_UPDATES = 0;

UPDATE employees
SET 
jobtitle = "Sales Representative"
WHERE jobTitle = "Sales Rep";

-- Show a list of employees who are not sales representatives

SELECT * FROM employees
WHERE jobtitle != "Sales Representative";

-- Show a list of customers with "Toys" in their name
SELECT * FROM customers;

SELECT * FROM customers
WHERE customerName LIKE '%Toys%';

SELECT * FROM customers
WHERE contactFirstName LIKE 'A%';

SELECT * FROM customers
WHERE contactFirstName LIKE '%n';

SELECT * FROM customers
WHERE contactFirstName LIKE 'B%n';
use classicmodels;

-- Harley
SELECT * FROM products
WHERE productName LIKE "%Harley%";

-- List the 5 most expensive products from the "Planes" product line

SELECT * FROM products
WHERE productline = "Planes"
ORDER BY MSRP DESC
LIMIT 5;

-- show the 2nd most expensive products from the "Planes" product line
SELECT * FROM products
WHERE productline = "Planes"
ORDER BY MSRP DESC
LIMIT 1,1;

-- Identify the products that are about to run out of stock (quantity in stock < 100)
SELECT * FROM products
WHERE quantityinstock < 100;

-- List 10 products in the "Motorcycles" category 
-- with the lowest buy price and more than 1000 units in stock

SELECT productname, buyprice, quantityInStock , productline FROM products
WHERE productline = "Motorcycles" AND quantityInStock > 1000
ORDER BY buyPrice
limit 10;

-- List all the products having Harley Davidson Motorcycle
SELECT * FROM products
WHERE productname LIKE "%Harley%";

-- Retrieve the list of customers sorted by their first names in ascending order.

SELECT * FROM customers
ORDER BY contactFirstName;

-- Report the total number of payments received before October 28, 2004. 
-- YYYY-MM-DD
SELECT * FROM payments; 
SELECT COUNT(*) FROM payments
WHERE paymentdate < "2004-10-28";
/* comment */
-- Report the number of customer who have made payments before October 28, 2004.
SELECT COUNT(DISTINCT customernumber) FROM payments
WHERE paymentdate < "2004-10-28";

-- Retrieve the list of customer numbers for customer 
-- who have made a payment before October 28, 2004.
SELECT DISTINCT customernumber FROM payments
WHERE paymentdate < "2004-10-28";

-- Retrieve the details all customers who have made a payment before October 28, 2004.
 SELECT * FROM customers
 WHERE customernumber IN (SELECT DISTINCT customernumber FROM payments
WHERE paymentdate < "2004-10-28");

-- Retrieve details of all the customers in the United States who have made 
-- payments between April 1st 2003 and March 31st 2004.
SELECT * FROM customers
 WHERE country = "USA" AND customernumber IN (SELECT DISTINCT customernumber FROM payments
WHERE paymentdate BETWEEN "2003-04-01" AND "2004-03-31");

-- Find the total number of payments made by each customer before October 28, 2004.
use classicmodels;
SELECT customernumber , COUNT(*) AS TotalPayments
FROM Payments
WHERE paymentdate < "2004-10-28"
GROUP BY customernumber
ORDER BY TotalPayments DESC;

SELECT * FROM payments;
SELECT customernumber , SUM(amount) AS TotalAmount
FROM Payments
WHERE paymentdate < "2004-10-28"
GROUP BY customernumber;

SELECT SUM(amount) FROM payments;

--  Find the total no. of payments and total payment 
-- amount for each customer for payments made before October 28, 2004.
SELECT customernumber ,COUNT(*) AS totalPayments,
 SUM(amount) AS TotalAmount,
 AVG(amount) AS AverageAMount,
 MIN(amount) AS MinimumAmount,
 MAX(amount) AS MaximumAmount
FROM Payments
WHERE paymentdate < "2004-10-28"
GROUP BY customernumber; 

-- Display the product code, product name, buy price, sale price and 
-- profit margin percentage ((MSRP - buyPrice)*100/buyPrice) 
-- for the 10 products with the highest profit margin. 
-- Round the profit margin to 2 decimals.
SELECT productcode, productname, buyPrice, MSRP,
ROUND(((MSRP - buyPrice)*100/buyPrice),2) AS ProfitMargin
FROM products
ORDER BY ProfitMargin DESC
LIMIT 10;

-- List the largest single payment done by every customer in the year 2004, 
-- ordered by the transaction value (highest to lowest).

USE classicmodels;
SELECT customernumber, MAX(amount) as LargestPayment
FROM payments
WHERE YEAR(paymentdate) = 2004
GROUP BY customernumber
ORDER BY LargestPayment DESC;


-- Show the total payments received month by month for every year.
SELECT YEAR(paymentdate) AS years,
	MONTH(paymentdate) AS months,
SUM(amount) AS TotalPayments FROM payments
GROUP BY years,months
ORDER BY years,months;

-- Show the number of orders placed by each customer,
-- sorted by the customer number in ascending order.

SELECT * from orders;
SELECT customerNumber, count(*) AS TotalNumberOFOrder
FROM orders
group by customerNumber
ORDER BY TotalNumberOFOrder DESC;
USE classicmodels;

-- Which product lines have the highest average product prices, 
-- sorted by the average price in descending order?
SELECT * FROM products;


SELECT productline, AVG(msrp) AS AveragePrice FROM products
GROUP BY productline
ORDER BY AveragePrice DESC;

-- Display the list of the 5 most expensive products in the "Motorcycles" 
-- product line with their price (MSRP) rounded to dollars.

SELECT productname ,productline, ROUND(msrp)  as SalePrice FROM products
WHERE productline = "Motorcycles"
ORDER BY SALEprice DESC
LIMIT 5;

-- What are the total quantities ordered for each product,
-- sorted by total quantities ordered in descending order?
SELECT * FROM orderdetails;
SELECT productCode, SUM(quantityOrdered) AS totalQuantity
FROM orderdetails
GROUP BY productCode
ORDER BY totalQuantity DESC;

-- Display list of customers (sorted by customer name), with a country code column. 
-- The country is simply the first 3 letters in the country name, in lower case.

SELECT customerName,
UCASE(SUBSTRING(Country,1,3)) AS CountryCode
FROM customers
ORDER BY customerName;

SELECT customerName,COUNtRY FROM customers
WHERE length(country) <= 6;


-- List the names of products sold at less than 80% of the MSRP.
SELECT * FROM products;
SELECT productName FROM products
WHERE buyPrice < 0.8 * msrp;

SELECT * FROM products
WHERE quantityInStock > 5000 AND MSRP < 100;
SELECT * FROM Employees;
-- Show the 10 most recent payments with customer details (name & phone no.).

SELECT * FROM customers;
SELECT * FROM payments;

SELECT checkNumber, paymentDate, amount, 
customers.customernumber, customerName, phone
FROM Payments JOIN customers
ON payments.customerNumber = customers.customerNumber
ORDER BY paymentDate DESC 
LIMIT 10;

-- Show the full office address and phone number for each employee.
SELECT * FROM employees;
SELECT * FROM offices;
SELECT firstname,lastname, o.officecode,phone,addressLine1,addressLine2,city,state 
FROM  Employees e JOIN offices o
ON e.officecode = o.officecode
ORDER BY firstname;

-- Show the full order information and product details for order no. 10100.
SELECT * FROM orderdetails;
SELECT * FROM products;
SELECT od.orderNumber,od.productCode, p.productname,
od.quantityOrdered, od.priceEach
FROM orderdetails od
JOIN products p 
ON od.productCode = p.productCode
WHERE orderNumber = 10100;

-- List the countries where offices are located along with the number 
-- of employees in each office, sorted by the number of employees in 
-- descending order.
SELECT * FROM offices;
SELECT * FROM employees;
SELECT country, COUNT(employeenumber) AS employeeCount
FROM offices o JOIN employees e
ON o.officecode = e.officecode
GROUP BY e.officecode
ORDER BY employeeCount DESC;

-- Retrieve the names of customers who have placed orders 
-- along with the details of the products they ordered for 
-- order number 10100.
SELECT c.contactFirstName, c.contactLastName, p.productName,
       od.quantityOrdered, od.priceEach FROM customers c
JOIN orders o ON c.customernumber = o.customernumber
JOIN orderdetails od ON o.orderNumber = od.orderNumber
JOIN products p on od.productCode = p.productCode
WHERE o.orderNUmber = 10100;
SELECT * FROM Employees;
SELECT * FROM customers;



-- List name of the customers with the employeeNumumber 
-- firstName, lastName and email of Sales Representative


SELECT c.customerName, e.employeeNumber, e.firstName,
e.lastName,e.email
FROM customers c JOIN employees e
ON c.salesRepEmployeeNumber = e.employeeNumber
ORDER BY customerName;

-- Show a list of employees with the name & employee number of 
-- their manager.
SELECT * FROM employees;
SELECT E.employeenumber, E.firstname, E.lastname,
M.employeeNumber as managerEmployeeNumber,
CONCAT(M.firstname," ",M.lastname) AS managerName
from employees E LEFT JOIN employees M
ON E.reportsTO = M.employeeNUmber;


-- List all customers and their orders, 
-- including customers who have not placed any orders.
use classicmodels;
SELECT c.customerName, o.ordernumber
FROM customers c
LEFT JOIN orders o
ON c.customerNumber = o.customerNumber;

-- Show a list of orders and the associated customers, 
-- including orders that don't have assigned customers.

SELECT o.ordernumber, c.customerName
From orders o
RIGHT JOIN customers c 
ON o.customerNumber = c.customerNumber;

--  List the products ordered on a Monday.
SELECT p.productName, o.orderdate, DAYNAME(o.orderDate)
FROM products p
JOIN orderdetails od ON
p.productcode = od.productCode
JOIN orders o ON
od.orderNumber = o.orderNumber
WHERE DAYOFWEEK(o.orderDate) = 2;

-- Report the products that have not been sold.
SELECT p.productName FROM Products p
LEFT JOIN orderdetails od ON p.productCOde = od.productCode
WHERE od.productCode IS NULL;

-- Report those payments greater than $100,000

SELECT * FROM payments
WHERE amount > 100000;

-- Reports those products that have been sold with a markup of 100% or more 
-- (i.e., the priceEach is at least twice the buyPrice)
SELECT * FROM products;
SELECT * FROM orderdetails;

SELECT p.productName, p.buyPrice, od.priceEach
FROM products p
JOIN orderdetails od ON p.productCode = od.productCode
WHERE od.priceEach >= p.buyPrice * 2;

-- Retrieve a list of all product names along with the names of all customers,
-- showing all possible combinations.
SELECT p.productName, c.customerName
FROM products p
CROSS JOIN customers c;

-- Generate all possible combinations of employees and customers.
SELECT e.firstname,e.lastname,
       c.contactFirstName,c.contactLastNAme
FROM employees e
CROSS JOIN customers c;

-- Create a list of all dates within a specific date range, 
-- combined with all product names.

SELECT d.date, p.productName
FROM (
      SELECT DISTINCT DATE(orderdate) AS date
      FROM orders
      WHERE orderdate Between '2003-01-01' AND '2004-06-14'
) d
CROSS JOIN products p;

USE classicmodels;

-- Add an index on the lastName column of the customers table.
CREATE INDEX customer_lastname_index ON customers (contactLastName);
SELECT * FROM customers
WHERE contactLastName = 'Lee';

SELECT * FROM customers 
order by contactLastName LIMIT 10;

SHOW INDEX FROM customers;

-- Create a view from customers table with all the customers from USA
CREATE VIEW usCustomers AS SELECT * FROM customers where country = 'USA';

SELECT * from uscustomers
WHERE state= 'CA';


