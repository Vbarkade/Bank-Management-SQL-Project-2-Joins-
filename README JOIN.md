# 🏦 Bank Management SQL Project (Joins)

## 📌 Project Overview
This project demonstrates **SQL JOIN operations** in PostgreSQL using a **Bank Management System** example.  
It contains two related tables:
1. **customers** – Stores customer personal details.
2. **accounts** – Stores customer bank account details linked to customers.

The project covers **data exploration** and **business problem-solving** using:
- INNER JOIN
- LEFT JOIN
- Aggregate functions (SUM, COUNT, AVG)
- Conditional filtering
- Grouping & ordering

---

## 📂 Database Structure

### 1. customers Table
| Column       | Type          | Description               |
|--------------|--------------|---------------------------|
| customer_id  | SERIAL (PK)  | Unique customer ID         |
| first_name   | VARCHAR(50)  | Customer first name        |
| last_name    | VARCHAR(50)  | Customer last name         |
| email        | VARCHAR(100) | Email address              |
| phone        | VARCHAR(15)  | Contact number             |
| city         | VARCHAR(50)  | City of residence          |

### 2. accounts Table
| Column       | Type            | Description                      |
|--------------|----------------|----------------------------------|
| account_id   | SERIAL (PK)    | Unique account ID                 |
| customer_id  | INT (FK)       | Links to customers.customer_id    |
| account_type | VARCHAR(50)    | Savings / Current account         |
| balance      | DECIMAL(12,2)  | Current balance                   |
| branch       | VARCHAR(50)    | Bank branch name                  |

---

## 🛠 Table Creation

```sql
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(15),
    city VARCHAR(50)
);

CREATE TABLE accounts (
    account_id SERIAL PRIMARY KEY,
    customer_id INT,
    account_type VARCHAR(50),
    balance DECIMAL(12,2),
    branch VARCHAR(50),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
```

---

## 📊 Business Problems & Queries

1. **Show customer details with their account information**
```sql
SELECT c.customer_id, c.first_name, c.last_name, a.account_type, a.balance
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id;
```

2. **Show customers with no accounts**
```sql
SELECT c.*
FROM customers c
LEFT JOIN accounts a ON c.customer_id = a.customer_id
WHERE a.account_id IS NULL;
```

3. **Total balance of each customer**
```sql
SELECT c.first_name, c.last_name, SUM(a.balance) AS Total_balance
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
GROUP BY c.first_name, c.last_name;
```

4. **Show only customers who have a Savings account**
```sql
SELECT c.first_name, c.last_name, a.account_type
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
WHERE a.account_type = 'Savings';
```

5. **Find customers who have only Current accounts**
```sql
SELECT c.customer_id, c.first_name, c.last_name
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING BOOL_AND(a.account_type = 'Current');
```

6. **Display all accounts with customer names**
```sql
SELECT a.account_id, c.first_name, c.last_name, a.account_type, a.balance
FROM accounts a
JOIN customers c ON a.customer_id = c.customer_id;
```

7. **Show customers from 'Mumbai' and their accounts**
```sql
SELECT c.first_name, c.last_name, a.account_type, a.balance, c.city
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
WHERE c.city = 'Mumbai';
```

8. **Find customers with more than one account**
```sql
SELECT c.customer_id, c.first_name, c.last_name, COUNT(a.account_id) AS account_count
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(a.account_id) > 1;
```

9. **Show accounts with balance greater than ₹50,000**
```sql
SELECT c.first_name, c.last_name, a.account_type, a.balance
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
WHERE a.balance > 50000;
```

10. **List customers and accounts ordered by balance**
```sql
SELECT c.first_name, c.last_name, a.account_type, a.balance
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
ORDER BY a.balance DESC;
```

11. **Find top 3 customers with highest total balance**
```sql
SELECT c.first_name, c.last_name, SUM(a.balance) AS total_balance
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
GROUP BY c.first_name, c.last_name
ORDER BY total_balance DESC
LIMIT 3;
```

12. **Show branch-wise total balance**
```sql
SELECT a.branch, SUM(a.balance) AS branch_total_balance
FROM accounts a
GROUP BY a.branch
ORDER BY branch_total_balance DESC;
```

13. **Show customers with both Savings and Current accounts**
```sql
SELECT c.customer_id, c.first_name, c.last_name
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(DISTINCT a.account_type) = 2;
```

14. **Find the average balance for each account type**
```sql
SELECT account_type, AVG(balance) AS avg_balance
FROM accounts
GROUP BY account_type;
```

15. **List all customers even if they don’t have accounts**
```sql
SELECT c.customer_id, c.first_name, c.last_name, a.account_type, a.balance
FROM customers c
LEFT JOIN accounts a ON c.customer_id = a.customer_id;
```

---

## 🎯 Learning Outcomes
- Create tables with **Primary Key** and **Foreign Key** constraints.
- Understand and apply **INNER JOIN** and **LEFT JOIN**.
- Use **aggregate functions** with `GROUP BY` and `HAVING`.
- Solve business problems using SQL joins.

---
## 🙋‍♂️ Author

**Vaibhav Barkade**  
 Data Analyst  
Building practical SQL projects using real-world data.

