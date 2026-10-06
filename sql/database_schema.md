# Enterprise Analytics Database Schema

## 🗄️ Database Overview

The project uses a relational MySQL database named:

`enterprise_analytics`

The database integrates customer, order, product, seller, payment, and review data to support end-to-end business analysis.

---

## 🏗️ Entity Relationship Overview

```text
Customers
    │
    │ 1 : Many
    ▼
  Orders
    │
    ├──────────────────► Payments
    │
    ├──────────────────► Reviews
    │
    │ 1 : Many
    ▼
Order Items
    │
    ├──────────────────► Products
    │
    └──────────────────► Sellers
```

The relational structure allows transactional data to be connected across multiple business dimensions for revenue, customer, product, seller, operational, and satisfaction analysis.

---

## 📋 Database Tables

The database contains the following primary analytical tables:

1. Customers
2. Orders
3. Order Items
4. Products
5. Sellers
6. Payments
7. Reviews

---

## 👥 1. Customers

The `customers` table contains information about customers associated with orders.

### Key Fields

| Column | Description |
|---|---|
| `customer_id` | Unique identifier for the customer record |
| `customer_unique_id` | Unique identifier representing the actual customer |
| `customer_zip_code_prefix` | Customer ZIP code prefix |
| `customer_city` | Customer city |
| `customer_state` | Customer state |

### Analytical Use

The table supports analysis of:

- Customer distribution
- Customer purchasing behavior
- Customer geography
- Repeat customers
- Customer segmentation
- Customer revenue contribution

---

## 🛒 2. Orders

The `orders` table contains order-level information and order lifecycle dates.

### Key Fields

| Column | Description |
|---|---|
| `order_id` | Unique identifier for an order |
| `customer_id` | Customer associated with the order |
| `order_status` | Current status of the order |
| `order_purchase_timestamp` | Date and time when the order was purchased |
| `order_approved_at` | Date and time when the order was approved |
| `order_delivered_carrier_date` | Date when the order was handed to the carrier |
| `order_delivered_customer_date` | Date when the order was delivered to the customer |
| `order_estimated_delivery_date` | Estimated delivery date |

### Analytical Use

The table supports analysis of:

- Order volume
- Revenue trends
- Order status
- Delivery performance
- Late deliveries
- Delivery time
- Monthly performance
- Customer purchasing activity

---

## 📦 3. Order Items

The `order_items` table contains individual products associated with orders.

An order can contain multiple order-item records.

### Key Fields

| Column | Description |
|---|---|
| `order_id` | Order associated with the item |
| `order_item_id` | Sequential item identifier within an order |
| `product_id` | Product associated with the item |
| `seller_id` | Seller responsible for the item |
| `shipping_limit_date` | Seller shipping deadline |
| `price` | Product price |
| `freight_value` | Freight/shipping value |

### Analytical Use

The table supports analysis of:

- Product revenue
- Freight value
- Order value
- Product performance
- Seller performance
- Category performance
- Revenue contribution

---

## 🛍️ 4. Products

The `products` table contains product-level information.

### Key Fields

| Column | Description |
|---|---|
| `product_id` | Unique identifier for the product |
| `product_category_name` | Product category |
| `product_weight_g` | Product weight in grams |
| `product_length_cm` | Product length in centimeters |
| `product_height_cm` | Product height in centimeters |
| `product_width_cm` | Product width in centimeters |

### Analytical Use

The table supports analysis of:

- Product performance
- Product categories
- Category revenue
- Product characteristics
- High-performing products

---

## 🏪 5. Sellers

The `sellers` table contains information about sellers participating in the marketplace.

### Key Fields

| Column | Description |
|---|---|
| `seller_id` | Unique identifier for the seller |
| `seller_zip_code_prefix` | Seller ZIP code prefix |
| `seller_city` | Seller city |
| `seller_state` | Seller state |

### Analytical Use

The table supports analysis of:

- Seller revenue
- Seller order volume
- Seller geography
- Seller delivery performance
- High-risk sellers
- Seller-level operational performance

---

## 💳 6. Payments

The `payments` table contains payment information associated with orders.

### Key Fields

| Column | Description |
|---|---|
| `order_id` | Order associated with the payment |
| `payment_sequential` | Sequence number of the payment within an order |
| `payment_type` | Payment method used |
| `payment_installments` | Number of payment installments |
| `payment_value` | Payment amount |

### Analytical Use

The table supports analysis of:

- Payment methods
- Payment values
- Installment behavior
- Payment distribution
- Customer payment preferences

---

## ⭐ 7. Reviews

The `reviews` table contains customer review information.

### Key Fields

| Column | Description |
|---|---|
| `review_id` | Unique identifier for the review |
| `order_id` | Order associated with the review |
| `review_score` | Customer rating from 1 to 5 |
| `review_comment_title` | Review title |
| `review_comment_message` | Review message |
| `review_creation_date` | Date the review was created |
| `review_answer_timestamp` | Timestamp of the review response |

### Analytical Use

The table supports analysis of:

- Customer satisfaction
- Review score distribution
- Product/category satisfaction
- Seller satisfaction
- Delivery impact on customer experience

---

## 🔗 Table Relationships

The database uses relationships between the main business entities.

| Parent Table | Child Table | Key Relationship | Cardinality |
|---|---|---|---|
| Customers | Orders | `customer_id` | 1 : Many |
| Orders | Order Items | `order_id` | 1 : Many |
| Products | Order Items | `product_id` | 1 : Many |
| Sellers | Order Items | `seller_id` | 1 : Many |
| Orders | Payments | `order_id` | 1 : Many |
| Orders | Reviews | `order_id` | 1 : Many |

---

## 🔄 Relationship Flow

### Customer → Orders

A customer can place multiple orders.

```text
Customers
    │
    │ customer_id
    ▼
Orders
```

### Orders → Order Items

An order can contain multiple products.

```text
Orders
    │
    │ order_id
    ▼
Order Items
```

### Products → Order Items

A product can appear in multiple order-item records.

```text
Products
    │
    │ product_id
    ▼
Order Items
```

### Sellers → Order Items

A seller can be associated with multiple order items.

```text
Sellers
    │
    │ seller_id
    ▼
Order Items
```

### Orders → Payments

An order can have one or more payment records.

```text
Orders
    │
    │ order_id
    ▼
Payments
```

### Orders → Reviews

Orders can be associated with customer reviews.

```text
Orders
    │
    │ order_id
    ▼
Reviews
```

---

## 📊 Analytical Model

The relational database supports analysis across several business dimensions.

```text
                    ┌─────────────┐
                    │  Customers  │
                    └──────┬──────┘
                           │
                           ▼
                    ┌─────────────┐
                    │   Orders    │
                    └──────┬──────┘
                           │
                 ┌─────────┼─────────┐
                 ▼         ▼         ▼
          ┌──────────┐ ┌────────┐ ┌─────────┐
          │Order Items│ │Payments│ │ Reviews │
          └────┬─────┘ └────────┘ └─────────┘
               │
          ┌────┴────┐
          ▼         ▼
     ┌─────────┐ ┌─────────┐
     │ Products│ │ Sellers │
     └─────────┘ └─────────┘
```

This structure allows business questions to be answered by joining transactional and dimensional information across the database.

---

## 📈 Business Analysis Supported

The database model supports the following analytical areas.

### Revenue Analytics

- Total product revenue
- Freight value
- Monthly revenue
- Average order value
- Revenue by category
- Revenue by customer state
- Revenue by seller

### Customer Analytics

- Total customers
- Repeat customers
- Customer segmentation
- Customer lifetime value
- Revenue concentration
- High-value customers

### Product Analytics

- Top products
- Top categories
- Category revenue contribution
- Product-level performance
- Category satisfaction

### Seller Analytics

- Seller revenue
- Seller order volume
- Seller delivery performance
- High-risk sellers
- Seller geographic distribution

### Operational Analytics

- Average delivery time
- Late delivery rate
- Order status distribution
- Delivery performance by seller

### Customer Satisfaction Analytics

- Average review score
- Review score distribution
- Delivery performance vs. review score
- Category satisfaction
- Seller satisfaction

### Payment Analytics

- Payment method distribution
- Payment value
- Installment behavior

---

## 🔐 Data Integrity & Design Considerations

The database structure separates major business entities into dedicated tables rather than storing all information in a single table.

This supports:

- Reduced data redundancy
- Easier querying
- Clear entity relationships
- Scalable analytical queries
- Consistent business analysis
- Integration with Power BI

Primary and foreign-key relationships are used to maintain connections between related business entities.

---

## 🔗 Integration with Power BI

The MySQL database serves as the primary analytical data source for the Power BI dashboards.

The workflow is:

```text
Python ETL
     ↓
Cleaned Data
     ↓
MySQL Database
     ↓
Power BI
     ↓
DAX Measures
     ↓
Interactive Dashboards
```

Power BI uses the relational model to analyze:

- Revenue
- Customers
- Orders
- Products
- Sellers
- Payments
- Reviews

---

## 📁 Related Project Files

### SQL Business Analysis

`sql/01_business_analysis.sql`

Contains the SQL queries used for business analysis and insight generation.

### Business Insights Report

`reports/business_insights.md`

Contains the major findings and strategic recommendations derived from the analysis.

### Data Profiling

`notebooks/01_data_profiling.ipynb`

Contains the initial exploratory data profiling and data-quality analysis.

---

## 🎯 Purpose of the Data Model

The database model provides a structured foundation for the entire analytics pipeline.

It connects transactional data with customer, product, seller, payment, and review information, enabling the project to move from raw data to SQL analysis and finally to interactive Power BI business intelligence dashboards.