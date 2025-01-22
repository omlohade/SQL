-- Table: Orders

-- +-----------------+----------+
-- | Column Name     | Type     |
-- +-----------------+----------+
-- | order_number    | int      |
-- | customer_number | int      |
-- +-----------------+----------+
-- order_number is the primary key (column with unique values) for this table.
-- This table contains information about the order ID and the customer ID.
 

-- Write a solution to find the customer_number for the customer who has placed the largest number of orders.

-- The test cases are generated so that exactly one customer will have placed more orders than any other customer.

-- The result format is in the following example.

 

-- Example 1:

-- Input: 
-- Orders table:
-- +--------------+-----------------+
-- | order_number | customer_number |
-- +--------------+-----------------+
-- | 1            | 1               |
-- | 2            | 2               |
-- | 3            | 3               |
-- | 4            | 3               |
-- +--------------+-----------------+
-- Output: 
-- +-----------------+
-- | customer_number |
-- +-----------------+
-- | 3               |
-- +-----------------+
-- Explanation: 
-- The customer with number 3 has two orders, which is greater than either customer 1 or 2 because each of them only has one order. 
-- So the result is customer_number 3.
 

-- Follow up: What if more than one customer has the largest number of orders, can you find all the customer_number in this case?


-- Main query begins here
SELECT a.customer_number  
FROM (
    -- Subquery (CTE or derived table) starts here
    SELECT customer_number, 
           COUNT(customer_number) AS count_costomer -- Counting the number of orders for each customer
    FROM Orders -- The table that contains order records
    GROUP BY customer_number -- Grouping by customer_number to get the order count per customer
) a -- The alias "a" is given to the subquery result

-- Sorting the results by the order count in descending order
ORDER BY a.count_costomer DESC

-- Limiting the result to only the top customer (the one with the most orders)
LIMIT 1;
