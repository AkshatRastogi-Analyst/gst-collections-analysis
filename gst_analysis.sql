-- GST Collections Analysis (India), full year FY 2025-26 compared with FY 2024-25
-- All amounts are in Rs crore. Data is from the official GST revenue releases.
-- "Gross GST" here means CGST + SGST + IGST (cess not included), so both years are like-for-like.
-- FY 2025-26 means April 2025 to March 2026. FY 2024-25 means April 2024 to March 2025.
--
-- Only simple SQL is used: SELECT, WHERE, ORDER BY, LIMIT, SUM, GROUP BY, ROUND and basic maths.
-- The one formula used again and again:
--     Growth % = (new - old) * 100.0 / old

-- ---------- STEP 1: Make the tables ----------
DROP TABLE IF EXISTS gst_monthly;
DROP TABLE IF EXISTS gst_year;

-- One row per month. Both years sit side by side.
CREATE TABLE gst_monthly (
    fy_month    INT,          -- 1 = April ... 12 = March
    month_name  VARCHAR(10),
    quarter     INT,          -- 1 = Apr-Jun, 2 = Jul-Sep, 3 = Oct-Dec, 4 = Jan-Mar
    fy2025      NUMERIC,      -- GST collected in that month of FY 2024-25
    fy2026      NUMERIC       -- GST collected in that month of FY 2025-26
);

-- Only ONE row. Full-year totals, both years side by side.
CREATE TABLE gst_year (
    total_fy2025     NUMERIC,
    total_fy2026     NUMERIC,
    import_fy2025    NUMERIC,   -- GST collected on imports
    import_fy2026    NUMERIC,
    domestic_fy2025  NUMERIC,   -- GST from sales inside India (total - imports)
    domestic_fy2026  NUMERIC
);

-- ---------- STEP 2: Put the data in ----------
INSERT INTO gst_monthly (fy_month, month_name, quarter, fy2025, fy2026) VALUES
(1,  'April',     1, 197007, 223265),
(2,  'May',       1, 160455, 188172),
(3,  'June',      1, 160653, 171106),
(4,  'July',      2, 169122, 183065),
(5,  'August',    2, 162894, 174116),
(6,  'September', 2, 161299, 177365),
(7,  'October',   3, 174796, 188124),
(8,  'November',  3, 169016, 170276),
(9,  'December',  3, 164556, 174550),
(10, 'January',   4, 182094, 193384),
(11, 'February',  4, 169779, 183609),
(12, 'March',     4, 183845, 200064);

INSERT INTO gst_year VALUES
(2055515, 2227096,    -- total
  521710,  595327,    -- imports
 1533805, 1631769);   -- domestic


-- ---------- STEP 3: Questions ----------

-- Question 1: How much did GST grow in each month compared with the same month last year?
-- Say it like this: "New number minus old number, times 100, divided by old number."
SELECT month_name,
       fy2025,
       fy2026,
       ROUND((fy2026 - fy2025) * 100.0 / fy2025, 1) AS growth_percent
FROM gst_monthly
ORDER BY fy_month;


-- Question 2: What was the total GST for the full year, and how much did it grow?
SELECT SUM(fy2025) AS total_fy2025,
       SUM(fy2026) AS total_fy2026,
       ROUND((SUM(fy2026) - SUM(fy2025)) * 100.0 / SUM(fy2025), 1) AS growth_percent
FROM gst_monthly;


-- Question 3: Which month had the highest GST in FY 2025-26?
SELECT month_name, fy2026
FROM gst_monthly
ORDER BY fy2026 DESC
LIMIT 1;


-- Question 4: Which month grew the fastest, and which grew the slowest?
-- Fastest (biggest growth first):
SELECT month_name,
       ROUND((fy2026 - fy2025) * 100.0 / fy2025, 1) AS growth_percent
FROM gst_monthly
ORDER BY growth_percent DESC
LIMIT 1;

-- Slowest (smallest growth first):
SELECT month_name,
       ROUND((fy2026 - fy2025) * 100.0 / fy2025, 1) AS growth_percent
FROM gst_monthly
ORDER BY growth_percent ASC
LIMIT 1;


-- Question 5: Which months grew by less than 7%?
SELECT month_name,
       ROUND((fy2026 - fy2025) * 100.0 / fy2025, 1) AS growth_percent
FROM gst_monthly
WHERE (fy2026 - fy2025) * 100.0 / fy2025 < 7
ORDER BY fy_month;


-- Question 6: How did each quarter do?
-- GROUP BY puts the 3 months of each quarter together, SUM adds them up.
SELECT quarter,
       SUM(fy2025) AS quarter_fy2025,
       SUM(fy2026) AS quarter_fy2026,
       ROUND((SUM(fy2026) - SUM(fy2025)) * 100.0 / SUM(fy2025), 1) AS growth_percent
FROM gst_monthly
GROUP BY quarter
ORDER BY quarter;


-- Question 7: Did domestic sales or imports grow faster over the full year?
SELECT ROUND((domestic_fy2026 - domestic_fy2025) * 100.0 / domestic_fy2025, 1) AS domestic_growth_percent,
       ROUND((import_fy2026 - import_fy2025) * 100.0 / import_fy2025, 1)       AS import_growth_percent
FROM gst_year;


-- Question 8: What share of the full-year GST came from imports?
-- Share % = part * 100 / total
SELECT ROUND(import_fy2025 * 100.0 / total_fy2025, 1) AS import_share_fy2025_percent,
       ROUND(import_fy2026 * 100.0 / total_fy2026, 1) AS import_share_fy2026_percent
FROM gst_year;
