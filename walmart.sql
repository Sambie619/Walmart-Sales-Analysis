select * from walmart;
drop table walmart;
SELECT COUNT(*) FROM walmart;
select distinct payment_method from walmart;
SELECT payment_method,COUNT(*)FROM walmart GROUP BY payment_method;
SELECT COUNT(DISTINCT branch) FROM walmart;
SELECT Max(quantity) FROM walmart;
SELECT MIN(quantity) FROM walmart;
--Business Problems

--Different payment method and number of transactions, number of qty sold
SELECT 
	 payment_method,
	 COUNT(*) as no_payments,
	 SUM(quantity) as no_qty_sold
FROM walmart
GROUP BY payment_method;
-- Identify the highest-rated category in each branch, displaying the branch, category
-- AVG RATING

SELECT * 
FROM
(	SELECT 
		branch,
		category,
		AVG(rating) as avg_rating,
		RANK() OVER(PARTITION BY branch ORDER BY AVG(rating) DESC) as rank
	FROM walmart
	GROUP BY 1, 2
)
WHERE rank = 1

-- Identify the busiest day for each branch based on the number of transactions

SELECT * 
FROM
	(SELECT 
		branch,
		TO_CHAR(TO_DATE(date, 'DD/MM/YY'), 'Day') as day_name,
		COUNT(*) as no_transactions,
		RANK() OVER(PARTITION BY branch ORDER BY COUNT(*) DESC) as rank
	FROM walmart
	GROUP BY 1, 2
	)
WHERE rank = 1

-- Calculate the total quantity of items sold per payment method. List payment_method and total_quantity.
SELECT 
	 payment_method,
	 -- COUNT(*) as no_payments,
	 SUM(quantity) as no_qty_sold
FROM walmart
GROUP BY payment_method

-- Determine the average, minimum, and maximum rating of category for each city. 
-- List the city, average_rating, min_rating, and max_rating.

SELECT 
	city,
	category,
	MIN(rating) as min_rating,
	MAX(rating) as max_rating,
	AVG(rating) as avg_rating
FROM walmart
GROUP BY 1, 2

-- Calculate the total profit for each category by considering total_profit as
-- (unit_price * quantity * profit_margin). 
-- List category and total_profit, ordered from highest to lowest profit.

SELECT 
	category,
	SUM(total) as total_revenue,
	SUM(total * profit_margin) as profit
FROM walmart
GROUP BY 1

-- Determine the most common payment method for each Branch. 
-- Display Branch and the preferred_payment_method.

WITH cte AS
(SELECT 
	branch,
	payment_method,
	COUNT(*) as total_trans,
	RANK() OVER(PARTITION BY branch ORDER BY COUNT(*) DESC) as rank
FROM walmart
GROUP BY 1, 2
)
SELECT *
FROM cte
WHERE rank = 1

-- Categorize sales into 3 group MORNING, AFTERNOON, EVENING 
-- Find out each of the shift and number of invoices

SELECT
	branch,
CASE 
		WHEN EXTRACT(HOUR FROM(time::time)) < 12 THEN 'Morning'
		WHEN EXTRACT(HOUR FROM(time::time)) BETWEEN 12 AND 17 THEN 'Afternoon'
		ELSE 'Evening'
	END day_time,
	COUNT(*)
FROM walmart
GROUP BY 1, 2
ORDER BY 1, 3 DESC
;
-- #9 Identify 5 branch with highest decrese ratio in 
-- revevenue compare to last year(current year 2023 and last year 2022)
-- rdr == last_rev-cr_rev/ls_rev*100

SELECT *,
EXTRACT(YEAR FROM TO_DATE(date, 'DD/MM/YY')) as formated_date
FROM walmart;

-- 2022 sales
WITH revenue_2022
AS
(
	SELECT 
		branch,
		SUM(total) as revenue
	FROM walmart
	WHERE EXTRACT(YEAR FROM TO_DATE(date, 'DD/MM/YY')) = 2022 -- psql
	-- WHERE YEAR(TO_DATE(date, 'DD/MM/YY')) = 2022 -- mysql
	GROUP BY 1
),

revenue_2023
AS
(

	SELECT 
		branch,
		SUM(total) as revenue
	FROM walmart
	WHERE EXTRACT(YEAR FROM TO_DATE(date, 'DD/MM/YY')) = 2023
	GROUP BY 1
)

SELECT 
	ls.branch,
	ls.revenue as last_year_revenue,
	cs.revenue as cr_year_revenue,
	ROUND(
		(ls.revenue - cs.revenue)::numeric/
		ls.revenue::numeric * 100, 
		2) as rev_dec_ratio
FROM revenue_2022 as ls
JOIN
revenue_2023 as cs
ON ls.branch = cs.branch
WHERE 
	ls.revenue > cs.revenue
ORDER BY 4 DESC
LIMIT 5;

--Branch Performance
select branch,city,sum(total)as total_sales,avg(rating)as avg_rating 
from walmart group by branch,city order by total_sales desc;
--found that avg rating by customers do not have a relation with higher sales

--Revenue per Branch and Category
SELECT 
    branch,
    category,
    SUM(total) AS total_sales,
    SUM(total * profit_margin) AS net_profit
FROM walmart
GROUP BY branch, category
ORDER BY branch, total_sales DESC;
--top 3 revenue generating category per branch
SELECT branch, category, total_sales, net_profit
FROM (
    SELECT 
        branch,
        category,
        SUM(total) AS total_sales,
        SUM(total * profit_margin) AS net_profit,
        ROW_NUMBER() OVER (PARTITION BY branch ORDER BY SUM(total) DESC) AS sales_rank
    FROM walmart
    GROUP BY branch, category
) ranked
WHERE sales_rank <= 3
ORDER BY branch, sales_rank;

--Branch Competition Mapping(Compare cities with multiple branches and which one performs better)


SELECT 
    city,
    branch,
    SUM(total) AS total_sales,
    SUM(total * profit_margin) AS net_profit,
    RANK() OVER (PARTITION BY city ORDER BY SUM(total) DESC) AS revenue_rank,
    RANK() OVER (PARTITION BY city ORDER BY SUM(total * profit_margin) DESC) AS profit_rank
FROM walmart
GROUP BY city,branch
ORDER BY total_sales DESC;












