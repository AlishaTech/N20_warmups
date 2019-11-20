-- For each country calculate the total spending for each customer, and 
TODAY- customer_age
customer_age is an alias for whatever function I come up with to determine how long theyve been a customer since first purchase

-- include a column (called 'difference') showing how much more each customer 
Table join table on column = diffference_column

-- spent compared to the next highest spender in that country. 


-- For the 'difference' column, fill any nulls with zero.


-- ROUND your all of your results to the next penny.
ROUND(not there yet)


WITH order_info AS 

SELECT *, c.customer_id as c_customer_id, o.customer_id as o_customer_id, od.unit_price*od.quantity*(1-od.discount) as total

FROM orders as o 

    JOIN order_details as od ON o.order_id = od.order_id
    
    JOIN products as p ON od.product_id = p.product_id
    
    JOIN customers as c ON o.customer_id = c.customer_id,
    
customer_totals AS

SELECT c_customer_id, country, sum(total) as total

FROM order_info

GROUP BY c_customer_id, country,

top_customers AS  

SELECT *, RANK() OVER(PARTITION BY country ORDER BY total DESC)

FROM customer_totals

SELECT *

FROM top_customers

WHERE rank <= 3; 
    
 3 newest customers in each each country.


-- Get the 3 most frequently ordered products in each city

product_totals AS

SELECT p.product_id, country, sum(total) as total

FROM order_details

GROUP BY p.product_id, country,

top_products AS

SELECT *, RANK() OVER(PARTITION BY country ORDER BY total DESC)

FROM product_totals

SELECT *

FROM top_products

WHERE rank <= 3;


LAG(expression [,offset] [,default]) over_clause;
LAG() function to return the prices from the previous row and calculates the difference between the price of the current row and the previous row
--make this personalized to the exercise
SELECT
   product_name,
   group_name,
   price,
   LAG (price, 1) OVER (
      PARTITION BY group_name
      ORDER BY
         price
   ) AS prev_price,
   price - LAG (price, 1) OVER (
      PARTITION BY group_name
      ORDER BY
         price
   ) AS cur_prev_diff
FROM
   products
INNER JOIN product_groups USING (group_id);


-- hints: 
-- keywords to google - lead, lag, coalesce
-- If rounding isn't working: 
-- https://stackoverflow.com/questions/13113096/how-to-round-an-average-to-2-decimal-places-in-postgresql/20934099