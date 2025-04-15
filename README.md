
# 📊 Monthly Revenue and Order Insights - SQL Analysis

This project focuses on extracting meaningful business insights from a relational e-commerce database using MySQL queries. The insights cover order volume, revenue, product performance, customer behavior, and shipment status, all broken down on a monthly basis.

---

## 🧰 Technologies Used

- **MySQL** for database querying
- **Online Shop 2024: dataset
Link: https://www.kaggle.com/datasets/marthadimgba/online-shop-2024 ** with 8+ tables (orders, payments, products, etc.)
```

---

## 📦 Getting Started

1. Import your database schema and data.
2. Run the SQL queries using MySQL Workbench, CLI, or a compatible DB client.
```

---
## 📁 Database Tables Used

- **customers**  
  `customer_id, first_name, last_name, address, email, phone_number`

- **orders**  
  `order_id, order_date, customer_id, total_price`

- **order_items**  
  `order_item_id, order_id, product_id, quantity, price_at_purchase`

- **products**  
  `product_id, product_name, category, price, supplier_id`

- **reviews**  
  `review_id, product_id, customer_id, rating, review_text, review_date`

- **payments**  
  `payment_id, order_id, payment_method, amount, transaction_status`

- **shipments**  
  `shipment_id, order_id, shipment_date, carrier, tracking_number, delivery_date, shipment_status`

- **suppliers**  
  `supplier_id, supplier_name, contact_name, address, phone_number, email`

---

## 🔍 Key SQL Queries and Insights

### 1. 📦 Basic Monthly Summary
```sql
SELECT YEAR(order_date) AS year,MONTH(order_date) AS month,SUM(total_price) AS revenue,COUNT(DISTINCT order_id) AS orders
FROM orders
GROUP BY year, month
ORDER BY year, month;
```

### 2. 📅 Monthly Insights for Specific Year (e.g., 2024)
```sql
SELECT 
    MONTH(order_date), COUNT(DISTINCT order_id) AS order_volume, SUM(total_price) AS monthly_revenue
FROM orders
WHERE YEAR(order_date) = 2024
GROUP BY MONTH(order_date)
ORDER BY month;
```

### 3. 🏆 Top 5 Revenue Months
```sql
SELECT 
    YEAR(order_date), MONTH(order_date), SUM(total_price) AS revenue
FROM orders
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY revenue DESC
LIMIT 5;
```

### 4. Monthly Average Order Value (AOV)
```sql
SELECT 
YEAR(order_date) AS year,MONTH(order_date) AS month,SUM(total_price) AS revenue,COUNT(DISTINCT order_id) AS orders,
ROUND(SUM(total_price)/COUNT(DISTINCT order_id), 2) AS aov
FROM orders
GROUP BY year, month
ORDER BY year, month;
```

### 5. 👤 Quarterly Summary View
```sql
SELECT YEAR(order_date) AS year,QUARTER(order_date) AS quarter,SUM(total_price) AS revenue,COUNT(DISTINCT order_id) AS orders
FROM orders
GROUP BY year, quarter
ORDER BY year, quarter;
```

---

## 🧠 Additional Business Insights

### ✔️ Successful Payments Per Month
```sql
SELECT 
    YEAR(o.order_date), MONTH(o.order_date), SUM(p.amount) AS successful_payments
FROM payments p
JOIN orders o ON p.order_id = o.order_id
WHERE p.transaction_status = 'Success'
GROUP BY YEAR(o.order_date), MONTH(o.order_date);
```

### 🚚 Orders Not Yet Shipped
```sql
SELECT 
    YEAR(o.order_date), MONTH(o.order_date), COUNT(DISTINCT o.order_id) AS unshipped_orders
FROM orders o
LEFT JOIN shipments s ON o.order_id = s.order_id
WHERE s.shipment_status IS NULL OR s.shipment_status != 'Shipped'
GROUP BY YEAR(o.order_date), MONTH(o.order_date);
```

### 💵 Average Order Value
```sql
SELECT 
    YEAR(order_date), MONTH(order_date), AVG(total_price) AS avg_order_value
FROM orders
GROUP BY YEAR(order_date), MONTH(order_date);
```

### 🌟 Monthly Review Trends
```sql
SELECT 
    YEAR(review_date), MONTH(review_date), COUNT(review_id) AS total_reviews, ROUND(AVG(rating), 2) AS avg_rating
FROM reviews
GROUP BY YEAR(review_date), MONTH(review_date);
```

### 🛒 Top 5 Selling Products by Quantity
```sql
SELECT 
    YEAR(o.order_date), MONTH(o.order_date), p.product_name,
    SUM(oi.quantity) AS total_quantity_sold
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY YEAR(o.order_date), MONTH(o.order_date), p.product_name
ORDER BY total_quantity_sold DESC
LIMIT 5;
```

---

## Files attached

### TASK 6.sql -- MySQL file
### 1.png-10.png -- images showing results table
```

This project is licensed under the MIT License.
---

