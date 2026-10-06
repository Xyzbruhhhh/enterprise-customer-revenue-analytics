-- ============================================================
-- Enterprise Customer & Revenue Intelligence Platform
-- Business Analysis Queries
-- Dataset: Olist Brazilian E-Commerce
-- ============================================================

-- 1.verify data

USE enterprise_analytics;

SELECT COUNT(*) AS total_customers
FROM customers;

SELECT COUNT(*) AS total_orders
FROM orders;

SELECT COUNT(*) AS total_order_items
FROM order_items;

SELECT COUNT(*) AS total_products
FROM products;

SELECT COUNT(*) AS total_sellers
FROM sellers;

SELECT COUNT(*) AS total_payments
FROM payments;

SELECT COUNT(*) AS total_reviews
FROM reviews;

-- 2. how much revenue did the business generate
--Product revenue + Freight = Total order-item value
SELECT
    ROUND(SUM(price), 2) AS total_product_revenue
FROM order_items;
SELECT
    ROUND(SUM(freight_value), 2) AS total_freight_value
FROM order_items;
SELECT
    ROUND(SUM(price + freight_value), 2) AS total_order_value
FROM order_items;

--3. monthly earnings and revenue
SELECT
    DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS month,
    ROUND(SUM(oi.price), 2) AS revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY
    DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m')
ORDER BY month;
-- 4.A) how many orders were placed each month
SELECT
    DATE_FORMAT(
        order_purchase_timestamp,
        '%Y-%m'
    ) AS month,

    COUNT(*) AS orders

FROM orders

GROUP BY
    DATE_FORMAT(
        order_purchase_timestamp,
        '%Y-%m'
    )

ORDER BY month;

-- 4B. MONTHLY DELIVERED ORDERS

SELECT
    DATE_FORMAT(
        order_purchase_timestamp,
        '%Y-%m'
    ) AS month,

    COUNT(DISTINCT order_id) AS delivered_orders

FROM orders

WHERE order_status = 'delivered'

GROUP BY
    DATE_FORMAT(
        order_purchase_timestamp,
        '%Y-%m'
    )

ORDER BY month;

-- 5. Average order value
SELECT
    order_id,
    ROUND(SUM(price), 2) AS order_value
FROM order_items
GROUP BY order_id;
-- average order value (AOV)
SELECT
    ROUND(
        AVG(order_value),
        2
    ) AS average_order_value
FROM (
    SELECT
        order_id,
        SUM(price) AS order_value
    FROM order_items
    GROUP BY order_id
) AS order_totals;

-- 6. which product categories generate the most revenue
SELECT
    p.product_category_name_english AS category,

    ROUND(
        SUM(oi.price),
        2
    ) AS revenue

FROM order_items oi

JOIN products p
    ON oi.product_id = p.product_id

JOIN orders o
    ON oi.order_id = o.order_id

WHERE o.order_status = 'delivered'

GROUP BY
    p.product_category_name_english

ORDER BY
    revenue DESC

LIMIT 10;

-- 7. whcih states generate the most revenue
SELECT
    c.customer_state AS state,

    ROUND(
        SUM(oi.price),
        2
    ) AS revenue

FROM customers c

JOIN orders o
    ON c.customer_id = o.customer_id

JOIN order_items oi
    ON o.order_id = oi.order_id

WHERE o.order_status = 'delivered'

GROUP BY
    c.customer_state

ORDER BY
    revenue DESC;
--8. delivery performance
SELECT
    ROUND(
        AVG(delivery_days),
        2
    ) AS average_delivery_days,

    ROUND(
        AVG(delivery_delay_days),
        2
    ) AS average_delivery_delay_days

FROM orders

WHERE is_delivered = 1;

--9. late delivery rate
SELECT
    ROUND(
        100.0 * SUM(is_late) / COUNT(*),
        2
    ) AS late_delivery_rate_percent

FROM orders

WHERE is_delivered = 1;

--10. customer satisfaction
SELECT
    review_score,
    COUNT(*) AS number_of_reviews

FROM reviews

GROUP BY review_score

ORDER BY review_score;
-- average review score
SELECT
    ROUND(
        AVG(review_score),
        2
    ) AS average_review_score

FROM reviews;
--11. payment methods
SELECT
    payment_type,

    COUNT(*) AS transactions,

    ROUND(
        SUM(payment_value),
        2
    ) AS payment_value

FROM payments

GROUP BY payment_type

ORDER BY payment_value DESC;

-- ============================================================
-- 12. TOP CUSTOMERS BY REVENUE
-- ============================================================

SELECT
    c.customer_unique_id,

    COUNT(DISTINCT o.order_id) AS total_orders,

    ROUND(
        SUM(oi.price),
        2
    ) AS total_revenue

FROM customers c

JOIN orders o
    ON c.customer_id = o.customer_id

JOIN order_items oi
    ON o.order_id = oi.order_id

WHERE o.order_status = 'delivered'

GROUP BY
    c.customer_unique_id

ORDER BY
    total_revenue DESC

LIMIT 20;

-- ============================================================
-- 13. REPEAT VS ONE-TIME CUSTOMERS
-- ============================================================

WITH customer_orders AS (

    SELECT
        c.customer_unique_id,

        COUNT(DISTINCT o.order_id) AS order_count

    FROM customers c

    JOIN orders o
        ON c.customer_id = o.customer_id

    WHERE o.order_status = 'delivered'

    GROUP BY
        c.customer_unique_id
)

SELECT
    CASE
        WHEN order_count = 1
            THEN 'One-Time Customer'
        ELSE 'Repeat Customer'
    END AS customer_type,

    COUNT(*) AS customer_count

FROM customer_orders

GROUP BY
    CASE
        WHEN order_count = 1
            THEN 'One-Time Customer'
        ELSE 'Repeat Customer'
    END;
-- ============================================================
-- 14. REPEAT CUSTOMER RATE
-- ============================================================

WITH customer_orders AS (

    SELECT
        c.customer_unique_id,

        COUNT(DISTINCT o.order_id) AS order_count

    FROM customers c

    JOIN orders o
        ON c.customer_id = o.customer_id

    WHERE o.order_status = 'delivered'

    GROUP BY
        c.customer_unique_id
)

SELECT
    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN order_count > 1 THEN 1
                ELSE 0
            END
        )
        / COUNT(*),
        2
    ) AS repeat_customer_rate_percent

FROM customer_orders;

-- ============================================================
-- 15. REVENUE BY CUSTOMER TYPE
-- ============================================================

WITH customer_orders AS (

    SELECT
        c.customer_unique_id,

        COUNT(DISTINCT o.order_id) AS order_count

    FROM customers c

    JOIN orders o
        ON c.customer_id = o.customer_id

    WHERE o.order_status = 'delivered'

    GROUP BY
        c.customer_unique_id
)

SELECT
    CASE
        WHEN co.order_count = 1
            THEN 'One-Time Customer'
        ELSE 'Repeat Customer'
    END AS customer_type,

    ROUND(
        SUM(oi.price),
        2
    ) AS revenue

FROM customer_orders co

JOIN customers c
    ON co.customer_unique_id = c.customer_unique_id

JOIN orders o
    ON c.customer_id = o.customer_id

JOIN order_items oi
    ON o.order_id = oi.order_id

WHERE o.order_status = 'delivered'

GROUP BY
    CASE
        WHEN co.order_count = 1
            THEN 'One-Time Customer'
        ELSE 'Repeat Customer'
    END;
-- ============================================================
-- 16. CUSTOMER LIFETIME VALUE
-- ============================================================

SELECT
    c.customer_unique_id,

    COUNT(DISTINCT o.order_id) AS total_orders,

    ROUND(
        SUM(oi.price),
        2
    ) AS lifetime_revenue

FROM customers c

JOIN orders o
    ON c.customer_id = o.customer_id

JOIN order_items oi
    ON o.order_id = oi.order_id

WHERE o.order_status = 'delivered'

GROUP BY
    c.customer_unique_id

ORDER BY
    lifetime_revenue DESC

LIMIT 20;
-- ============================================================
-- 18. CUSTOMER REVENUE CONCENTRATION
-- ============================================================

WITH customer_revenue AS (

    SELECT
        c.customer_unique_id,

        SUM(oi.price) AS revenue

    FROM customers c

    JOIN orders o
        ON c.customer_id = o.customer_id

    JOIN order_items oi
        ON o.order_id = oi.order_id

    WHERE o.order_status = 'delivered'

    GROUP BY
        c.customer_unique_id
),

ranked_customers AS (

    SELECT
        customer_unique_id,
        revenue,

        SUM(revenue) OVER (
            ORDER BY revenue DESC
        ) AS cumulative_revenue,

        SUM(revenue) OVER () AS total_revenue

    FROM customer_revenue
)

SELECT
    customer_unique_id,

    ROUND(revenue, 2) AS revenue,

    ROUND(
        100 * cumulative_revenue / total_revenue,
        2
    ) AS cumulative_revenue_percent

FROM ranked_customers

ORDER BY revenue DESC
LIMIT 100;
-- ============================================================
-- 19. SELLER PERFORMANCE
-- ============================================================

SELECT
    s.seller_id,
    s.seller_state,

    COUNT(DISTINCT oi.order_id) AS total_orders,

    ROUND(
        SUM(oi.price),
        2
    ) AS revenue,

    ROUND(
        AVG(oi.price),
        2
    ) AS average_item_value

FROM sellers s

JOIN order_items oi
    ON s.seller_id = oi.seller_id

JOIN orders o
    ON oi.order_id = o.order_id

WHERE o.order_status = 'delivered'

GROUP BY
    s.seller_id,
    s.seller_state

ORDER BY
    revenue DESC

LIMIT 20;
-- ============================================================
-- 20. SELLER DELIVERY PERFORMANCE
-- ============================================================

SELECT
    s.seller_id,
    s.seller_state,

    COUNT(DISTINCT o.order_id) AS delivered_orders,

    ROUND(
        AVG(o.delivery_days),
        2
    ) AS average_delivery_days,

    ROUND(
        AVG(o.delivery_delay_days),
        2
    ) AS average_delivery_delay_days,

    ROUND(
        100.0 * SUM(o.is_late) / COUNT(*),
        2
    ) AS late_delivery_rate

FROM sellers s

JOIN order_items oi
    ON s.seller_id = oi.seller_id

JOIN orders o
    ON oi.order_id = o.order_id

WHERE o.is_delivered = 1

GROUP BY
    s.seller_id,
    s.seller_state

ORDER BY
    late_delivery_rate DESC;
-- ============================================================
-- 21. HIGH-REVENUE / HIGH-RISK SELLERS
-- ============================================================

SELECT
    s.seller_id,
    s.seller_state,

    COUNT(DISTINCT o.order_id) AS delivered_orders,

    ROUND(
        SUM(oi.price),
        2
    ) AS revenue,

    ROUND(
        100.0 * SUM(o.is_late) / COUNT(*),
        2
    ) AS late_delivery_rate

FROM sellers s

JOIN order_items oi
    ON s.seller_id = oi.seller_id

JOIN orders o
    ON oi.order_id = o.order_id

WHERE o.is_delivered = 1

GROUP BY
    s.seller_id,
    s.seller_state

HAVING
    COUNT(DISTINCT o.order_id) >= 50

ORDER BY
    late_delivery_rate DESC,
    revenue DESC;
-- ============================================================
-- 22. LATE DELIVERY VS CUSTOMER SATISFACTION
-- ============================================================

SELECT
    CASE
        WHEN o.is_late = 1
            THEN 'Late Delivery'
        ELSE 'On-Time / Early'
    END AS delivery_status,

    COUNT(DISTINCT o.order_id) AS orders,

    ROUND(
        AVG(r.review_score),
        2
    ) AS average_review_score

FROM orders o

JOIN reviews r
    ON o.order_id = r.order_id

WHERE o.is_delivered = 1

GROUP BY
    CASE
        WHEN o.is_late = 1
            THEN 'Late Delivery'
        ELSE 'On-Time / Early'
    END;
-- ============================================================
-- 23. TOP PRODUCTS BY REVENUE
-- ============================================================

SELECT
    oi.product_id,

    p.product_category_name_english AS category,

    COUNT(DISTINCT oi.order_id) AS orders,

    ROUND(
        SUM(oi.price),
        2
    ) AS revenue,

    ROUND(
        AVG(oi.price),
        2
    ) AS average_price

FROM order_items oi

JOIN products p
    ON oi.product_id = p.product_id

JOIN orders o
    ON oi.order_id = o.order_id

WHERE o.order_status = 'delivered'

GROUP BY
    oi.product_id,
    p.product_category_name_english

ORDER BY
    revenue DESC

LIMIT 20;
-- ============================================================
-- 24. CATEGORY PERFORMANCE
-- ============================================================

SELECT
    p.product_category_name_english AS category,

    COUNT(DISTINCT oi.order_id) AS orders,

    COUNT(DISTINCT oi.product_id) AS products,

    ROUND(
        SUM(oi.price),
        2
    ) AS revenue,

    ROUND(
        AVG(oi.price),
        2
    ) AS average_item_price

FROM order_items oi

JOIN products p
    ON oi.product_id = p.product_id

JOIN orders o
    ON oi.order_id = o.order_id

WHERE o.order_status = 'delivered'

GROUP BY
    p.product_category_name_english

ORDER BY
    revenue DESC;
-- ============================================================
-- 25. CATEGORY REVENUE CONTRIBUTION
-- ============================================================

WITH category_revenue AS (

    SELECT
        p.product_category_name_english AS category,

        SUM(oi.price) AS revenue

    FROM order_items oi

    JOIN products p
        ON oi.product_id = p.product_id

    JOIN orders o
        ON oi.order_id = o.order_id

    WHERE o.order_status = 'delivered'

    GROUP BY
        p.product_category_name_english
)

SELECT
    category,

    ROUND(
        revenue,
        2
    ) AS revenue,

    ROUND(
        100 * revenue / SUM(revenue) OVER (),
        2
    ) AS revenue_contribution_percent

FROM category_revenue

ORDER BY
    revenue DESC;
-- ============================================================
-- 26. CATEGORY REVENUE VS CUSTOMER SATISFACTION
-- ============================================================

SELECT
    p.product_category_name_english AS category,

    ROUND(
        SUM(oi.price),
        2
    ) AS revenue,

    ROUND(
        AVG(r.review_score),
        2
    ) AS average_review_score,

    COUNT(DISTINCT r.review_id) AS review_count

FROM order_items oi

JOIN products p
    ON oi.product_id = p.product_id

JOIN orders o
    ON oi.order_id = o.order_id

JOIN reviews r
    ON o.order_id = r.order_id

WHERE o.order_status = 'delivered'

GROUP BY
    p.product_category_name_english

HAVING
    COUNT(DISTINCT r.review_id) >= 50

ORDER BY
    average_review_score ASC;
-- ============================================================
-- 27. HIGH-REVENUE / LOW-SATISFACTION CATEGORIES
-- ============================================================

SELECT
    p.product_category_name_english AS category,

    ROUND(
        SUM(oi.price),
        2
    ) AS revenue,

    ROUND(
        AVG(r.review_score),
        2
    ) AS average_review_score,

    COUNT(DISTINCT r.review_id) AS review_count

FROM order_items oi

JOIN products p
    ON oi.product_id = p.product_id

JOIN orders o
    ON oi.order_id = o.order_id

JOIN reviews r
    ON o.order_id = r.order_id

WHERE o.order_status = 'delivered'

GROUP BY
    p.product_category_name_english

HAVING
    COUNT(DISTINCT r.review_id) >= 50
    AND AVG(r.review_score) < 3.5

ORDER BY
    revenue DESC;