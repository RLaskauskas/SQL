------WHERE------

WHERE name LIKE 'C%';
WHERE name LIKE '%one%';
WHERE name NOT LIKE '%one%';

WHERE name IN ('Walmart', 'Target', 'Nordstrom');
WHERE name NOT IN ('Walmart', 'Target', 'Nordstrom');

WHERE gloss_qty BETWEEN 24 AND 29;
WHERE standard_qty = 0 AND (gloss_qty > 1000 OR poster_qty > 1000);

------Having------

HAVING SUM(total) > 1000;

------Aggregations------

COUNT(),SUM(),MIN(),MAX(),AVG(), ROUND(), POW(base, exponent).

------Dates------

DATE_TRUNC(date_expression, date_part)
DATE(timestamp_expression)
EXTRACT(part FROM date_expression)
DATE_ADD(date_expression, INTERVAL value part)
DATE_SUB(date_expression, INTERVAL value part)
DATE_DIFF(date1, date2, part)

------CASE------

CASE 
    WHEN condition1 THEN result1
    WHEN condition2 THEN result2
    ELSE default_result
END


------Cleaning------

NULLIF(metric.weight_kg, 0)
LEFT(UPPER(name), 1) AS first_letter
STRPOS("Hello World", "World") -- Returns 7, meaning "World" starts at the 7th position
SUBSTR("BigQuery Database", 10, 8) -- Returns "Database" because it extracts 8 characters starting from position 10
"Hello" || " " || "World"
CONCAT("Hello", " ", "World")
CAST("123" AS INT)
CAST(TIMESTAMP "2025-05-05 12:30:00" AS DATE)
SAFE_CAST("abc" AS INT) -- Instead of an error, it returns NULL
COALESCE(phone_number, email, 'No Contact Info') -- If phone_number is null, it checks email. If both are null, it returns "No Contact Info"
IFNULL(phone_number, 'No Phone')

------REGEXP------

REGEXP_CONTAINS(name, r'John') AS has_john -- Returns TRUE for any name that contains "John" (e.g., "John Smith")
REGEXP_EXTRACT(email, r'@(.+)') AS domain  -- REGEXP_EXTRACT(email, r'@(.+)') AS domain
REGEXP_REPLACE(email, r'^[^@]+', '****') AS masked_email -- Changes "user@gmail.com" → "****@gmail.com"

WHEN REGEXP_REPLACE(LOWER(diabetes_type), r'[^a-z0-9]', '') LIKE ANY ('%type1%', '%typeą%') THEN 'Type 1'
WHEN LOWER(activity_level) IN ('not active', 'inactive', '1') THEN 'Not Active'

------Window Functions------

SUM(standard_amt_usd) OVER (ORDER BY occurred_at) AS running_total
SUM(standard_amt_usd) OVER (PARTITION BY DATE_TRUNC('year', occurred_at) ORDER BY occurred_at) AS running_total
ROW_NUMBER() OVER (PARTITION BY account_id ORDER BY total DESC) AS total_rank    -- 1, 2, 3, 4...
RANK() OVER (PARTITION BY account_id ORDER BY total DESC) AS total_rank          -- 1, 1, 3, 4...
DENSE_RANK() OVER (PARTITION BY account_id ORDER BY total DESC) AS total_rank    -- 1, 1, 2, 3...
LEAD(total_amt_usd) OVER (ORDER BY occurred_at) AS lead,
LEAD(total_amt_usd) OVER (ORDER BY occurred_at) - total_amt_usd AS lead_difference
NTILE(4) OVER (PARTITION BY account_id ORDER BY standard_qty) AS standard_quartile

