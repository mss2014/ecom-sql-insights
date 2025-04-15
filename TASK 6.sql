use sales_data;
show tables;

#1. Basic Monthly Summary
SELECT YEAR(order_date) AS year,MONTH(order_date) AS month,SUM(total_price) AS revenue,COUNT(DISTINCT order_id) AS orders
FROM orders
GROUP BY year, month
ORDER BY year, month;

#2. Year 2024 Performance
SELECT MONTH(order_date) AS month,COUNT(DISTINCT order_id) AS order_volume,SUM(total_price) AS monthly_revenue
FROM orders
WHERE YEAR(order_date) = 2024
GROUP BY MONTH(order_date)
ORDER BY month;

#3. Top 5 Months by Revenue
SELECT YEAR(order_date) AS year,MONTHNAME(order_date) AS month,SUM(total_price) AS revenue
FROM orders
GROUP BY year, month
ORDER BY revenue DESC
LIMIT 5;

#4. Monthly Average Order Value (AOV)
SELECT YEAR(order_date) AS year,MONTH(order_date) AS month,SUM(total_price) AS revenue,COUNT(DISTINCT order_id) AS orders,
ROUND(SUM(total_price)/COUNT(DISTINCT order_id), 2) AS aov
FROM orders
GROUP BY year, month
ORDER BY year, month;

#5. Quarterly Summary View
SELECT YEAR(order_date) AS year,QUARTER(order_date) AS quarter,SUM(total_price) AS revenue,COUNT(DISTINCT order_id) AS orders
FROM orders
GROUP BY year, quarter
ORDER BY year, quarter;


#6. Monthly Successful Payments
SELECT YEAR(o.order_date) AS year,MONTH(o.order_date) AS month,SUM(p.amount) AS successful_payments
FROM payment p
JOIN orders o ON p.order_id = o.order_id
WHERE p.transaction_status = 'Completed'
GROUP BY YEAR(o.order_date), MONTH(o.order_date)
ORDER BY year, month;

#7 Monthly Orders Not Yet Shipped
SELECT YEAR(o.order_date) AS year,MONTH(o.order_date) AS month,COUNT(DISTINCT o.order_id) AS unshipped_orders
FROM orders o
LEFT JOIN shipments s ON o.order_id = s.order_id
WHERE s.shipment_status IS NULL OR s.shipment_status != 'Shipped'
GROUP BY YEAR(o.order_date), MONTH(o.order_date)
ORDER BY year, month;

#8 Monthly Review Count and Average Rating
SELECT YEAR(review_date) AS year,MONTH(review_date) AS month,COUNT(review_id) AS total_reviews,ROUND(AVG(rating), 2) AS avg_rating
FROM reviews GROUP BY YEAR(review_date), MONTH(review_date) ORDER BY year, month;


#9 Revenue by Product Category (Monthly)
SELECT YEAR(o.order_date) AS year,MONTH(o.order_date) AS month,p.category,SUM(oi.quantity * oi.price_at_purchase) AS category_revenue
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY YEAR(o.order_date), MONTH(o.order_date), p.category
ORDER BY year, month, category;

#10. Top 5 Selling Products by Quantity (Monthly)
SELECT YEAR(o.order_date) AS year,MONTH(o.order_date) AS month,p.product_name,SUM(oi.quantity) AS total_quantity_sold
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY YEAR(o.order_date), MONTH(o.order_date), p.product_name
ORDER BY total_quantity_sold DESC
LIMIT 5;




