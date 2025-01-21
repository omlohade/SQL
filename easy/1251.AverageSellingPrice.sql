-- Table: Prices

-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | product_id    | int     |
-- | start_date    | date    |
-- | end_date      | date    |
-- | price         | int     |
-- +---------------+---------+
-- (product_id, start_date, end_date) is the primary key (combination of columns with unique values) for this table.
-- Each row of this table indicates the price of the product_id in the period from start_date to end_date.
-- For each product_id there will be no two overlapping periods. That means there will be no two intersecting periods for the same product_id.
 

-- Table: UnitsSold

-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | product_id    | int     |
-- | purchase_date | date    |
-- | units         | int     |
-- +---------------+---------+
-- This table may contain duplicate rows.
-- Each row of this table indicates the date, units, and product_id of each product sold. 
 

-- Write a solution to find the average selling price for each product. average_price should be rounded to 2 decimal places. If a product does not have any sold units, its average selling price is assumed to be 0.

-- Return the result table in any order.

-- The result format is in the following example.

 

-- Example 1:

-- Input: 
-- Prices table:
-- +------------+------------+------------+--------+
-- | product_id | start_date | end_date   | price  |
-- +------------+------------+------------+--------+
-- | 1          | 2019-02-17 | 2019-02-28 | 5      |
-- | 1          | 2019-03-01 | 2019-03-22 | 20     |
-- | 2          | 2019-02-01 | 2019-02-20 | 15     |
-- | 2          | 2019-02-21 | 2019-03-31 | 30     |
-- +------------+------------+------------+--------+
-- UnitsSold table:
-- +------------+---------------+-------+
-- | product_id | purchase_date | units |
-- +------------+---------------+-------+
-- | 1          | 2019-02-25    | 100   |
-- | 1          | 2019-03-01    | 15    |
-- | 2          | 2019-02-10    | 200   |
-- | 2          | 2019-03-22    | 30    |
-- +------------+---------------+-------+
-- Output: 
-- +------------+---------------+
-- | product_id | average_price |
-- +------------+---------------+
-- | 1          | 6.96          |
-- | 2          | 16.96         |
-- +------------+---------------+
-- Explanation: 
-- Average selling price = Total Price of Product / Number of products sold.
-- Average selling price for product 1 = ((100 * 5) + (15 * 20)) / 115 = 6.96
-- Average selling price for product 2 = ((200 * 15) + (30 * 30)) / 230 = 16.96




-- Calculate the average price:
-- Numerator: Sum of (price of the product * units sold) for each product.
-- Denominator: Total number of units sold for the product.
-- Use IFNULL to handle cases where there are no sales (denominator is NULL) and set the average_price to 0.
SELECT 
    ROUND(
    Prices.product_id, 
        IFNULL(
            SUM(Prices.price * UnitsSold.units) / SUM(UnitsSold.units), 
            0
        ), 
        2
    ) AS average_price
FROM 
    Prices
    -- Perform a LEFT JOIN between Prices and UnitsSold tables.
    -- LEFT JOIN ensures that all products in the Prices table are included, 
    -- even if there are no matching rows in the UnitsSold table.
    LEFT JOIN UnitsSold 
    ON 
        Prices.product_id = UnitsSold.product_id 
        -- Ensure that the purchase_date in the UnitsSold table falls within the valid price period
        -- defined by start_date and end_date in the Prices table.
        AND UnitsSold.purchase_date BETWEEN Prices.start_date AND Prices.end_date
-- Group the results by product_id to calculate aggregated values for each product.
GROUP BY 
    Prices.product_id;
