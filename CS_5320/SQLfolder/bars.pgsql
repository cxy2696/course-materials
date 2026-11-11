-- =============================================================================
-- CS 5320 (Database Systems) -- chocolate-bar review queries
-- =============================================================================
--
-- Run from the CS_5320 folder so the relative \copy path resolves:
--
--     createdb bars
--     psql -d bars -f SQLfolder/bars.pgsql
--
-- The data comes from `csv/chocolate_bars.csv` (2,530 reviews).  The file is
-- loaded with psql's client-side \copy, so no server-side file permissions are
-- needed.
-- =============================================================================

DROP TABLE IF EXISTS bars;

CREATE TABLE bars (
    id              integer PRIMARY KEY,
    manufacturer    text,
    company_location text,
    year_reviewed   integer,
    bean_origin     text,
    bar_name        text,
    cocoa_percent   numeric(5, 2),
    num_ingredients numeric(5, 2),
    ingredients     text,
    review          text,
    rating          numeric(3, 2)
);

\copy bars FROM 'csv/chocolate_bars.csv' WITH (FORMAT csv, HEADER true)

-- Q1. What is the average rating across all reviews?
\echo 'Q1: average rating'
SELECT round(avg(rating), 3) AS average_rating
FROM bars;

-- Q2. Which manufacturer has the most reviews?
\echo 'Q2: manufacturer with the most reviews'
SELECT manufacturer, count(*) AS review_count
FROM bars
GROUP BY manufacturer
ORDER BY review_count DESC, manufacturer
LIMIT 1;

-- Q3. How many reviews mention "earthy"?
\echo 'Q3: reviews mentioning earthy'
SELECT count(*) AS earthy_count
FROM bars
WHERE review ILIKE '%earthy%';

-- Q4. Which manufacturers have more than 25 bars above 71% cocoa?
\echo 'Q4: manufacturers with >25 high-cocoa bars'
SELECT manufacturer
FROM bars
WHERE cocoa_percent > 71
GROUP BY manufacturer
HAVING count(*) > 25
ORDER BY manufacturer;

-- Q5. How many distinct bars were not reviewed in 2018?
\echo 'Q5: bars without a 2018 review'
SELECT count(DISTINCT bar_name) AS bar_count
FROM bars
WHERE bar_name NOT IN (
    SELECT bar_name
    FROM bars
    WHERE year_reviewed = 2018
);

-- Q6. How many (earlier, later) review pairs improved their rating?
\echo 'Q6: review pairs with a higher later rating'
SELECT count(*) AS improved_review_pairs
FROM bars AS earlier
JOIN bars AS later
  ON earlier.bar_name = later.bar_name
 AND later.year_reviewed > earlier.year_reviewed
 AND later.rating > earlier.rating;

-- Q7. How many manufacturers sell bars made in their own country?
\echo 'Q7: manufacturers using domestic beans'
SELECT count(DISTINCT manufacturer) AS manufacturer_count
FROM bars
WHERE bean_origin = company_location;

-- Q8. How many pairs of different bars share the same review text?
\echo 'Q8: pairs of bars sharing a review'
SELECT count(*) AS review_pairs_count
FROM bars AS first
JOIN bars AS second
  ON first.review = second.review
 AND first.bar_name <> second.bar_name
 AND first.id < second.id;

-- Q9. Compare the average rating of above-average and below-average cocoa bars.
\echo 'Q9: average rating by cocoa level'
WITH average_cocoa AS (
    SELECT avg(cocoa_percent) AS cutoff FROM bars
)
SELECT
    round(avg(rating) FILTER (WHERE cocoa_percent > cutoff), 3) AS avg_rating_above,
    round(avg(rating) FILTER (WHERE cocoa_percent < cutoff), 3) AS avg_rating_below
FROM bars, average_cocoa;

-- Q10. How many bars were reviewed in every year represented in the data?
\echo 'Q10: bars reviewed in every year'
WITH bar_years AS (
    SELECT bar_name, count(DISTINCT year_reviewed) AS years_reviewed
    FROM bars
    GROUP BY bar_name
),
total_years AS (
    SELECT count(DISTINCT year_reviewed) AS years_available FROM bars
)
SELECT count(*) AS bars_reviewed_every_year
FROM bar_years, total_years
WHERE bar_years.years_reviewed = total_years.years_available;
