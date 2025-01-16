
-- Table: Ads

-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | ad_id         | int     |
-- | user_id       | int     |
-- | action        | enum    |
-- +---------------+---------+
-- (ad_id, user_id) is the primary key for this table.
-- Each row of this table contains the ID of an Ad, the ID of a user and the action taken by this user regarding this Ad.
-- The action column is an ENUM type of ('Clicked', 'Viewed', 'Ignored').
 

-- A company is running Ads and wants to calculate the performance of each Ad.

-- Performance of the Ad is measured using Click-Through Rate (CTR) where:



-- Write an SQL query to find the ctr of each Ad.

-- Round ctr to 2 decimal points. Order the result table by ctr in descending order and by ad_id in ascending order in case of a tie.

-- The query result format is in the following example:

-- Ads table:
-- +-------+---------+---------+
-- | ad_id | user_id | action  |
-- +-------+---------+---------+
-- | 1     | 1       | Clicked |
-- | 2     | 2       | Clicked |
-- | 3     | 3       | Viewed  |
-- | 5     | 5       | Ignored |
-- | 1     | 7       | Ignored |
-- | 2     | 7       | Viewed  |
-- | 3     | 5       | Clicked |
-- | 1     | 4       | Viewed  |
-- | 2     | 11      | Viewed  |
-- | 1     | 2       | Clicked |
-- +-------+---------+---------+
-- Result table:
-- +-------+-------+
-- | ad_id | ctr   |
-- +-------+-------+
-- | 1     | 66.67 |
-- | 3     | 50.00 |
-- | 2     | 33.33 |
-- | 5     | 0.00  |
-- +-------+-------+
-- for ad_id = 1, ctr = (2/(2+1)) * 100 = 66.67
-- for ad_id = 2, ctr = (1/(1+2)) * 100 = 33.33
-- for ad_id = 3, ctr = (1/(1+1)) * 100 = 50.00
-- for ad_id = 5, ctr = 0.00, Note that ad_id = 5 has no clicks or views.
-- Note that we don't care about Ignored Ads.
-- Result table is ordered by the ctr. in case of a tie we order them by ad_id



-- SQL Query 1: Using GROUP BY and CASE WHEN
-- This query calculates the CTR (Click-Through Rate) for each ad directly using a single query.

-- Select the ad_id and calculate the CTR (Click-Through Rate) rounded to 2 decimal places
SELECT 
    ad_id, 
    ROUND((
        SUM(CASE WHEN action = 'Clicked' THEN 1 ELSE 0 END) * 1.0 / -- Count the number of clicks
        NULLIF(SUM(CASE WHEN action IN ('Clicked', 'Viewed') THEN 1 ELSE 0 END), 0) -- Count clicks + views and avoid division by zero
    ) * 100, 2) AS ctr -- Multiply by 100 to convert to percentage and round to 2 decimal places
FROM Ads
GROUP BY ad_id -- Group the data by each ad_id to calculate metrics per ad
ORDER BY ctr DESC, ad_id ASC; -- Order by CTR in descending order, and by ad_id in ascending order if CTRs are tied

-- SQL Query 2: Using Subqueries
-- This query breaks the computation into two steps by first calculating clicks and views in a subquery, 
-- then calculating CTR in the outer query.

-- Outer query selects ad_id and calculates CTR rounded to 2 decimal places
SELECT 
    ad_id, 
    ROUND((clicks * 1.0 / NULLIF(views, 0)) * 100, 2) AS ctr -- Calculate CTR and handle division by zero using NULLIF
FROM (
    -- Subquery calculates clicks and views for each ad_id
    SELECT 
        ad_id, 
        SUM(CASE WHEN action = 'Clicked' THEN 1 ELSE 0 END) AS clicks, -- Count the number of clicks for each ad_id
        SUM(CASE WHEN action IN ('Clicked', 'Viewed') THEN 1 ELSE 0 END) AS views -- Count clicks + views for each ad_id
    FROM Ads
    GROUP BY ad_id -- Group by ad_id to aggregate the metrics
) AS subquery -- Use subquery results in the outer query
ORDER BY ctr DESC, ad_id ASC; -- Order by CTR in descending order, and by ad_id in ascending order if CTRs are tied
