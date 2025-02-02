-- In social network like Facebook or Twitter, people send friend requests and accept others’ requests as well. Now given two tables as below:
 

-- Table: friend_request
-- | sender_id | send_to_id |request_date|
-- |-----------|------------|------------|
-- | 1         | 2          | 2016_06-01 |
-- | 1         | 3          | 2016_06-01 |
-- | 1         | 4          | 2016_06-01 |
-- | 2         | 3          | 2016_06-02 |
-- | 3         | 4          | 2016-06-09 |
 

-- Table: request_accepted
-- | requester_id | accepter_id |accept_date |
-- |--------------|-------------|------------|
-- | 1            | 2           | 2016_06-03 |
-- | 1            | 3           | 2016-06-08 |
-- | 2            | 3           | 2016-06-08 |
-- | 3            | 4           | 2016-06-09 |
-- | 3            | 4           | 2016-06-10 |
 

-- Write a query to find the overall acceptance rate of requests rounded to 2 decimals, which is the number of acceptance divide the number of requests.
 

-- For the sample data above, your query should return the following result.
 

-- |accept_rate|
-- |-----------|
-- |       0.80|
 

-- Note:
-- The accepted requests are not necessarily from the table friend_request. In this case, you just need to simply count the total accepted requests (no matter whether they are in the original requests), and divide it by the number of requests to get the acceptance rate.
-- It is possible that a sender sends multiple requests to the same receiver, and a request could be accepted more than once. In this case, the ‘duplicated’ requests or acceptances are only counted once.
-- If there is no requests at all, you should return 0.00 as the accept_rate.
 

-- Explanation: There are 4 unique accepted requests, and there are 5 requests in total. 
-- So the rate is 0.80.


-- Calculate the acceptance rate of friend requests
SELECT 
    -- Calculate the acceptance rate and round to 2 decimal places
    ROUND(
        CASE 
            -- Avoid division by zero by checking if there are requests
            WHEN COUNT(DISTINCT f.sender_id, f.send_to_id) = 0 THEN 0.00
            ELSE COUNT(DISTINCT r.requester_id, r.accepter_id) * 1.0 / COUNT(DISTINCT f.sender_id, f.send_to_id)
        END, 2
    ) AS accept_rate
FROM 
    friend_request f
    -- Perform a LEFT JOIN with request_accepted to count accepted requests
    LEFT JOIN request_accepted r 
    ON f.sender_id = r.requester_id AND f.send_to_id = r.accepter_id;

-- Explanation:
-- 1. COUNT(DISTINCT f.sender_id, f.send_to_id): Counts unique friend requests.
-- 2. COUNT(DISTINCT r.requester_id, r.accepter_id): Counts unique accepted requests.
-- 3. Using CASE to handle division by zero when there are no requests.
-- 4. Multiplying by 1.0 ensures floating point division.
-- 5. ROUND(..., 2) rounds the result to two decimal places.

-- The query calculates the acceptance rate of friend requests by counting the number of unique accepted requests and dividing it by the number of unique requests. It uses a LEFT JOIN to ensure that all friend requests are considered, even if they were not accepted. The query also handles the case where there are no requests by returning 0.00 as the acceptance rate. The result is rounded to two decimal places using the ROUND function.



--now without using join
SELECT 
    ROUND(
        CASE 
            WHEN (SELECT COUNT(DISTINCT sender_id, send_to_id) FROM friend_request) = 0 THEN 0.00
            ELSE (SELECT COUNT(DISTINCT requester_id, accepter_id) FROM request_accepted) * 1.0 / (SELECT COUNT(DISTINCT sender_id, send_to_id) FROM friend_request)
        END, 2
    ) AS accept_rate;








-- First, let's break this down into steps:
-- 1. Get unique friend requests (handle duplicates)
-- 2. Get unique accepted requests (handle duplicates)
-- 3. Calculate the ratio and handle edge case
-- 4. Round to 2 decimal places

WITH unique_requests AS (
    -- Get count of unique requests by removing duplicates using DISTINCT
    -- This handles case where same person sends multiple requests to same receiver
    SELECT COUNT(DISTINCT sender_id, send_to_id) as total_requests
    FROM friend_request
),
unique_accepts AS (
    -- Get count of unique accepted requests
    -- Using DISTINCT to handle cases where same request is accepted multiple times
    SELECT COUNT(DISTINCT requester_id, accepter_id) as total_accepts
    FROM request_accepted
)

SELECT 
    -- CASE statement handles scenario where there are no requests (avoid divide by zero)
    -- CAST as DECIMAL ensures floating point division
    -- ROUND to 2 decimal places as required
    ROUND(
        CASE 
            WHEN total_requests = 0 THEN 0.00
            ELSE CAST(total_accepts AS DECIMAL) / total_requests
        END, 
    2) as accept_rate
FROM unique_requests, unique_accepts;
