-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | product_id  | int     |
-- | low_fats    | enum    |
-- | recyclable  | enum    |
-- +-------------+---------+
-- product_id is the primary key (column with unique values) for this table.
-- low_fats is an ENUM (category) of type ('Y', 'N') where 'Y' means this product is low fat and 'N' means it is not.
-- recyclable is an ENUM (category) of types ('Y', 'N') where 'Y' means this product is recyclable and 'N' means it is not.
 

-- Write a solution to find the ids of products that are both low fat and recyclable.

-- Return the result table in any order.

-- The result format is in the following example.

 

-- Example 1:

-- Input: 
-- Products table:
-- +-------------+----------+------------+
-- | product_id  | low_fats | recyclable |
-- +-------------+----------+------------+
-- | 0           | Y        | N          |
-- | 1           | Y        | Y          |
-- | 2           | N        | Y          |
-- | 3           | Y        | Y          |
-- | 4           | N        | N          |
-- +-------------+----------+------------+
-- Output: 
-- +-------------+
-- | product_id  |
-- +-------------+
-- | 1           |
-- | 3           |
-- +-------------+
-- Explanation: Only products 1 and 3 are both low fat and recyclable.


SELECT product_id 
FROM Products 
WHERE low_fats = 'Y' AND recyclable = 'Y';



-- with subquery
select product_id from products where low_fats = 'Y' and product_id in (select product_id from products where recyclable = 'Y')


--new concept case when like if else
SELECT product_id
FROM Products
WHERE 
    CASE 
        WHEN low_fats = 'Y' AND recyclable = 'Y' THEN 1
        ELSE 0
    END = 1;

--CTE
WITH LowFatProducts AS (
    SELECT product_id
    FROM Products
    WHERE low_fats = 'Y'
),
RecyclableProducts AS (
    SELECT product_id
    FROM Products
    WHERE recyclable = 'Y'
)
SELECT lfp.product_id
FROM LowFatProducts lfp
INNER JOIN RecyclableProducts rp
ON lfp.product_id = rp.product_id;
