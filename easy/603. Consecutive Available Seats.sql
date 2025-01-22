-- Question 37
-- Several friends at a cinema ticket office would like to reserve consecutive available seats.
-- Can you help to query all the consecutive available seats order by the seat_id using the following cinema table?
-- | seat_id | free |
-- |---------|------|
-- | 1       | 1    |
-- | 2       | 0    |
-- | 3       | 1    |
-- | 4       | 1    |
-- | 5       | 1    |
 

-- Your query should return the following result for the sample case above.
 

-- | seat_id |
-- |---------|
-- | 3       |
-- | 4       |
-- | 5       |
-- Note:
-- The seat_id is an auto increment int, and free is bool ('1' means free, and '0' means occupied.).
-- Consecutive available seats are more than 2(inclusive) seats consecutively available.



-- Outer query: Selecting the seat_id of available seats that are part of consecutive available seats
SELECT seat_id
FROM (
    -- Subquery: Calculating the next and previous seat's availability for each row
    SELECT seat_id, free,
           -- lead(free, 1) gives the value of 'free' from the next row (next seat)
           LEAD(free, 1) OVER () AS next,
           -- lag(free, 1) gives the value of 'free' from the previous row (previous seat)
           LAG(free, 1) OVER () AS prev
    FROM cinema
) a
-- Filter to include only rows where the current seat is free and either the next or previous seat is also free
WHERE a.free = TRUE AND (next = TRUE OR prev = TRUE)
-- Order the result by seat_id so that the seat_ids are listed in ascending order
ORDER BY seat_id;
