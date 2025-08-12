-- Bank Management SQL Project 2 (Joins)

-- Drop tables if they already exist

DROP TABLE IF EXISTS accounts;
DROP TABLE IF EXISTS customers;

-- Create Customers table

CREATE TABLE customers (
      customer_id SERIAL PRIMARY KEY,
	  first_name VARCHAR(50),
	  last_name VARCHAR(50),
	  email VARCHAR(100),
	  phone VARCHAR(15),
	  city VARCHAR(50)  
);
-- After Create this customers table import csv file

-- Retrive Customer Table ?

SELECT * FROM customers;

-- Create accounts table

CREATE TABLE accounts (
   account_id SERIAL PRIMARY KEY,
   customer_id INT,
   account_type VARCHAR(50),
   balance DECIMAL(12,2),
   branch VARCHAR(50),
   FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- After Create this accounts table import csv file

-- Retrive accounts Table

SELECT * FROM accounts;

-- Data Analysis & Business Key Problems & Answers

-- 1. Show customer details with their account information ?
-- 2. Show customers with no accounts ?
-- 3. Total balance of each customer ?
-- 4. Show only the customers who have a Savings account ?
-- 5.Find customers who have only Current accounts ?
-- 6. Display all accounts with customer names ?
-- 7. Show customers from 'Mumbai' and their accounts ?
-- 8. Find customers with more than one account ?
-- 9. Show accounts with balance greater than ₹50,000 ?
-- 10. List customers and accounts ordered by balance ?
-- 11. Find top 3 customers with highest total balance ?
-- 12. Show branch-wise total balance ?
-- 13. Show customers with both Savings and Current accounts ?
-- 14. Find the average balance for each account type ?
-- 15. List all customers even if they don’t have any accounts, showing NULL for account details ?


-- 1. DATA EXPLORATION

-- 1. Show customer details with their account information ?

SELECT c.customer_id, c.first_name, c.last_name, a.account_type, a.balance
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id;

-- 2. Show customers with no accounts ?

SELECT c.*
FROM customers c
LEFT JOIN accounts a ON c.customer_id = a.customer_id
WHERE a.account_id IS NULL;

-- 3. Total balance of each customer ?

SELECT c.first_name, c.last_name, SUM(a.balance) AS Total_balance
FROM customers c JOIN accounts a
     ON c.customer_id = a.customer_id
    GROUP BY c.first_name, c.last_name;

-- 4. Show only the customers who have a Savings account

SELECT c.first_name, c.last_name, a.account_type
FROM customers c
JOIN accounts a 
 ON c.customer_id = a.customer_id
WHERE a.account_type = 'Savings';

-- 5.Find customers who have only Current accounts

SELECT c.customer_id, c.first_name, c.last_name
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING BOOL_AND(a.account_type = 'Current');


-- 6. Display all accounts with customer names ?

SELECT a.account_id, c.first_name, c.last_name, a.account_type, a.balance
FROM accounts a
JOIN customers c 
 ON a.customer_id = c.customer_id;

-- 7. Show customers from 'Mumbai' and their accounts ?

SELECT c.first_name, c.last_name, a.account_type, a.balance, c.city
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
WHERE c.city = 'Mumbai';

-- 8. Find customers with more than one account ?

SELECT c.customer_id, c.first_name, c.last_name, COUNT(a.account_id) AS account_count
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(a.account_id) > 1;

-- 9. Show accounts with balance greater than ₹50,000 ?

SELECT c.first_name, c.last_name, a.account_type, a.balance
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
WHERE a.balance > 50000;

-- 10. List customers and accounts ordered by balance ?

SELECT c.first_name, c.last_name, a.account_type, a.balance
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
ORDER BY a.balance DESC;

-- 2. ADVANCED JOINS

-- 11. Find top 3 customers with highest total balance ?

SELECT c.first_name, c.last_name, SUM(a.balance) AS total_balance
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
GROUP BY c.first_name, c.last_name
ORDER BY total_balance DESC
LIMIT 3;

-- 12. Show branch-wise total balance ?

SELECT a.branch, SUM(a.balance) AS branch_total_balance
FROM accounts a
GROUP BY a.branch
ORDER BY branch_total_balance DESC;

-- 13. Show customers with both Savings and Current accounts ?

SELECT c.customer_id, c.first_name, c.last_name
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(DISTINCT a.account_type) = 2;

-- 14. Find the average balance for each account type ?

SELECT account_type, AVG(balance) AS avg_balance
FROM accounts
GROUP BY account_type;

-- 15. List all customers even if they don’t have any accounts, showing NULL for account details ?

SELECT c.customer_id, c.first_name, c.last_name, a.account_type, a.balance
FROM customers c
LEFT JOIN accounts a ON c.customer_id = a.customer_id;


-- End Of Project























