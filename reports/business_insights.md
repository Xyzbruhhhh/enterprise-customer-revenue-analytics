# Enterprise Customer & Revenue Intelligence
## Business Insights Report

### Dataset
Olist Brazilian E-Commerce Public Dataset

### Objective
Analyze customer behavior, revenue performance, product categories,
seller performance, delivery operations, and customer satisfaction
to identify actionable business insights.

## 1. Executive Summary

This analysis evaluates e-commerce performance across revenue,
customers, products, sellers, delivery operations, payments, and
customer satisfaction.

The analysis combines SQL-based business analysis with an interactive
Power BI dashboard to identify revenue drivers, customer behavior,
operational risks, and opportunities for improvement.

## 2. Revenue Performance

### Key findings

- Total product revenue: 13221498.11
- Total freight value: 2198275.64
- Total orders: 96478
- Average order value: 137.04
- Monthly revenue trend: Revenue peaked in November 2017 at 987,765.37, while December 2016 had the lowest recorded monthly revenue at 10.90.


### Business interpretation

Revenue performance varies across time and product categories.
The highest-performing categories contribute a significant portion
of overall revenue.

### Recommendations

- Focus inventory and marketing efforts on high-performing categories.
- Monitor monthly revenue trends to identify periods of growth or decline.
- Evaluate whether high-revenue categories also maintain strong
  customer satisfaction.
## 3. Customer Insights

### Key findings

- Total delivered customers analyzed: 93,358
- Repeat customers: 2,801
- Repeat customer rate: 3.00%
- High-value customers: 941
- Medium-value customers: 2,693
- Low-value customers: 89,724
- Top customer lifetime revenue: 13,440.00
- Top 20% of customers generated 56.62% of revenue.

### Business interpretation

The analysis shows a predominantly one-time customer base, with only
3.00% of customers making more than one delivered purchase.

The high-value customer segment is relatively small, consisting of 941
customers, while the majority of customers fall into the low-value
segment.

The top 20% of customers generated 56.62% of total revenue, indicating
meaningful revenue concentration among higher-value customers.

### Recommendations


- Focus on increasing repeat purchases through customer retention
  strategies.
- Develop targeted loyalty initiatives for high-value customers.
- Investigate why the majority of customers do not make repeat
  purchases.
- Prioritize high-value customer segments for personalized marketing.
## 4. Delivery & Operational Performance

### Key findings

- Average delivery time: 12.56 days
- Average delivery delay: -11.18 days
- Delivered orders analyzed: 96,478
- Late orders: 7,826
- Late delivery rate: 8.11%

### Business interpretation

The average delivered order took approximately 12.56 days from purchase
to customer delivery.

The average delivery delay was -11.18 days, meaning orders were
delivered approximately 11.18 days before the estimated delivery date
on average.

Although most delivered orders were not late, 8.11% of delivered
orders were classified as late.

### Recommendations

- Investigate sellers and regions with unusually high late-delivery
  rates.
- Monitor late delivery as an operational KPI.
- Prioritize high-volume sellers with elevated late-delivery rates.
### Customer Satisfaction

- Total reviews: 99,224
- Average review score: 4.09 / 5
- 5-star reviews: 57,328
- 4-star reviews: 19,142
- 3-star reviews: 8,179
- 2-star reviews: 3,151
- 1-star reviews: 11,424

Late delivery had a strong association with lower review scores:

- Late delivery orders: 2.57 average review score
- On-time/early orders: 4.29 average review score

This represents a substantial difference in customer satisfaction
between late and on-time/early deliveries.

## 5. Product & Category Performance

### Key findings

- Top revenue category: Health & Beauty — 1,233,131.72
- Second-highest category: Watches & Gifts — 1,166,176.98
- Third-highest category: Bed/Bath/Table — 1,023,434.76
- Top individual product revenue: 63,560.00
- Top product category: Health & Beauty

### Business interpretation

Health & Beauty was the highest-revenue product category in the
analysis, followed by Watches & Gifts and Bed/Bath/Table.

Several high-revenue categories also showed relatively lower customer
review scores, creating potential opportunities for operational and
product-quality improvements.

### Recommendations

- Prioritize high-revenue categories for inventory and marketing.
- Investigate categories with high revenue but lower customer
  satisfaction.
- Monitor revenue and customer satisfaction together when evaluating
  category performance.

## 6. Seller Performance

### Key findings

- Top seller: Seller `4869f7a5dfa277a7dca6462dcf3b52b`
- Seller state: SP
- Orders: 1,124
- Revenue: 226,987.93

Several sellers with at least 50 delivered orders showed elevated
late-delivery rates above 20%.

### Business interpretation

Seller performance varies substantially across delivery reliability.
Some sellers handling meaningful order volumes have relatively high
late-delivery rates and may require operational attention.

### Recommendations

- Monitor seller-level delivery performance.
- Investigate high-volume sellers with elevated late-delivery rates.
- Use seller performance metrics to identify logistics bottlenecks.
### High-Revenue / Low-Satisfaction Categories

Categories with relatively low average review scores despite generating
meaningful revenue included:

- Office Furniture: 266,533.43 revenue, 3.52 average review score
- Bed/Bath/Table: 1,027,333.65 revenue, 3.92 average review score
- Furniture Decor: 712,414.53 revenue, 3.95 average review score

Office Furniture is particularly notable because it combines substantial
revenue with the lowest average review score among the categories
returned by the analysis.

### Recommendation

Investigate product quality, delivery experience, seller performance,
and customer complaints within high-revenue categories with lower
review scores.

## 7. Strategic Recommendations

### 1. Improve customer retention

Only 3.00% of analyzed customers were repeat customers. Increasing
repeat purchases represents a significant opportunity for customer
retention initiatives.

### 2. Protect high-value customers

The top 20% of customers generated 56.62% of revenue. High-value
customers should therefore receive targeted retention and loyalty
strategies.

### 3. Improve delivery reliability

The overall late-delivery rate was 8.11%. Seller-level analysis
identified multiple sellers with late-delivery rates above 20%.

### 4. Prioritize delivery improvements

Late-delivery orders had an average review score of 2.57 compared with
4.29 for on-time/early orders. Improving delivery reliability could
therefore have a meaningful relationship with customer satisfaction.

### 5. Investigate high-revenue / low-satisfaction categories

Categories such as Office Furniture generated substantial revenue
while receiving relatively lower review scores. These categories
should be investigated for product, seller, and logistics issues.

### 6. Use continuous BI monitoring

The Power BI dashboard should be used to monitor revenue, customer
retention, delivery performance, seller risk, and customer satisfaction
over time.
