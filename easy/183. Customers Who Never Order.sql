-- Table: Customers

-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | id          | int     |
-- | name        | varchar |
-- +-------------+---------+
-- id is the primary key (column with unique values) for this table.
-- Each row of this table indicates the ID and name of a customer.
 

-- Table: Orders

-- +-------------+------+
-- | Column Name | Type |
-- +-------------+------+
-- | id          | int  |
-- | customerId  | int  |
-- +-------------+------+
-- id is the primary key (column with unique values) for this table.
-- customerId is a foreign key (reference columns) of the ID from the Customers table.
-- Each row of this table indicates the ID of an order and the ID of the customer who ordered it.
 

-- Write a solution to find all customers who never order anything.

-- Return the result table in any order.

-- The result format is in the following example.

 

-- Example 1:

-- Input: 
-- Customers table:
-- +----+-------+
-- | id | name  |
-- +----+-------+
-- | 1  | Joe   |
-- | 2  | Henry |
-- | 3  | Sam   |
-- | 4  | Max   |
-- +----+-------+
-- Orders table:
-- +----+------------+
-- | id | customerId |
-- +----+------------+
-- | 1  | 3          |
-- | 2  | 1          |
-- +----+------------+
-- Output: 
-- +-----------+
-- | Customers |
-- +-----------+
-- | Henry     |
-- | Max       |
-- +-----------+


-- Using LEFT JOIN to find customers who have never ordered
SELECT a.name
FROM Customers AS a
-- LEFT JOIN is used to return all customers (a) along with matching orders (b).
-- If a customer has no orders, the corresponding columns from Orders table will be NULL.
LEFT JOIN Orders AS b ON a.id = b.customerId
-- The condition WHERE b.customerId IS NULL filters out customers who have placed orders.
-- Only customers with NULL in the b.customerId column (those without any orders) will be included in the result.
WHERE b.customerId IS NULL;

-- Using ALL operator to find customers who have never ordered
SELECT Name AS Customers
FROM Customers
-- The WHERE clause filters customers based on their id.
-- It uses the ALL operator to compare each customer's id to a list of customerIds who have placed orders.
WHERE id != ALL (
    -- This subquery returns all customer ids from the Customers (c) and Orders (o) tables.
    -- It selects customers whose id is associated with an order by checking where c.id equals o.Customerid.
    SELECT c.id
    FROM Customers c, Orders o
    WHERE c.id = o.Customerid
);
-- The condition WHERE id != ALL (...) ensures that only customers whose id does NOT match any of the customerIds in the Orders table are selected.
-- This effectively returns customers who have never placed an order.
