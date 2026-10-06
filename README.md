# Enterprise Customer & Revenue Intelligence Platform

## 📊 Project Overview

An end-to-end data analytics platform designed to analyze e-commerce
revenue, customer behavior, product performance, seller performance,
delivery operations, and customer satisfaction.

The project demonstrates a complete analytics workflow:

Raw Data → Python ETL → MySQL → SQL Analysis → Power BI → Business Insights

---

## 🎯 Business Objective

The objective is to transform raw e-commerce transaction data into
actionable business insights that can support:

- Revenue growth decisions
- Customer retention strategies
- Product and category optimization
- Seller performance monitoring
- Delivery performance improvement
- Customer satisfaction analysis

---

## 🛠️ Technology Stack

| Area | Technologies |
|---|---|
| Programming | Python |
| Data Processing | Pandas, NumPy |
| Database | MySQL |
| SQL | MySQL SQL, CTEs, Window Functions |
| Visualization | Power BI |
| BI / Analytics | DAX, Power Query |
| Development | VS Code, Jupyter Notebook |
| Version Control | Git, GitHub |

---

## 🏗️ Architecture

```text
Olist E-Commerce Dataset
          ↓
     Data Profiling
          ↓
      Python ETL
          ↓
   Cleaned CSV Data
          ↓
        MySQL
          ↓
     SQL Analysis
          ↓
      Power BI
          ↓
 Interactive Dashboards
          ↓
 Business Insights

📂 Project Structure

 Enterprise-Customer-Revenue-Analytics/
│
├── data/
│   ├── raw/
│   └── processed/
│
├── notebooks/
│   └── 01_data_profiling.ipynb
│
├── reports/
│   └── business_insights.md
│
├── sql/
│   └── 01_business_analysis.sql
│
├── src/
│   ├── data_cleaning/
│   ├── data_ingestion/
│   ├── analysis/
│   └── database/
│
├── powerbi/
│
├── tests/
│
├── .gitignore
├── requirements.txt
└── README.md

🔄 Data Pipeline
1. Data Profiling
The raw datasets were profiled using Python and Pandas to identify:
- Dataset dimensions
- Missing values
- Duplicate records
- Data types
- Order status distribution
- Delivery-date completeness
- Review-data completeness
2. Data Cleaning & ETL
Python was used to:
- Clean column names
- Handle missing values
- Convert date fields
- Create analytical features
- Prepare datasets for database loading
3. Database
Cleaned datasets were loaded into MySQL using a relational schema.
Main tables:
- Customers
- Orders
- Order Items
- Payments
- Reviews
- Products
- Sellers
4. SQL Business Analysis
SQL analysis was performed to evaluate:
- Revenue performance
- Monthly revenue trends
- Average order value
- Customer retention
- Customer segmentation
- Revenue concentration
- Product performance
- Category performance
- Seller performance
- Delivery performance
- Customer satisfaction
- Payment methods
5. Power BI
Power BI was used to build interactive dashboards with:
- KPI cards
- Revenue trends
- Order trends
- Category analysis
- Geographic analysis
- Delivery metrics
- Customer satisfaction
- Seller analysis
- Interactive filters
📈 Power BI Dashboard
Executive Overview
The Executive Overview dashboard provides a high-level view of:
- Revenue
- Orders
- Customers
- Average Order Value
- Late Delivery Rate
- Average Review Score
- Revenue Growth
Operations & Customer Insights
The second dashboard focuses on:
- Delivery performance
- Order status
- Delivery time
- Customer reviews
- Seller geography
- Payment methods
💡 Key Business Insights
Revenue
- November 2017 was the highest-revenue month.
- December 2016 represented a very low-revenue period.
- Revenue performance varies considerably across months.
Customers
- The majority of customers are one-time purchasers.
- Repeat customer rate was approximately 3%.
- A relatively small high-value customer segment contributes a substantial
  share of overall revenue.
- The top 20% of customers generated approximately 56.62% of revenue.
Delivery
- Average delivery time was approximately 12.56 days.
- The average delivery delay was approximately -11.18 days, indicating
  that delivered orders were generally earlier than the estimated date.
- Approximately 8.11% of delivered orders were classified as late.
Customer Satisfaction
- Overall average review score was approximately 4.09/5.
- Late-delivery orders had an average review score of approximately 2.57.
- On-time/early orders had an average review score of approximately 4.29.
This indicates a strong relationship between delivery performance and
customer satisfaction.
Products & Categories
The strongest revenue-generating categories included:
- Health & Beauty
- Watches & Gifts
- Bed/Bath/Table
- Sports & Leisure
- Computers & Accessories
Sellers
Seller performance varied significantly.
Several sellers demonstrated late-delivery rates above 20%, identifying
potential operational-risk areas requiring further investigation.
📊 Business Recommendations
1. Improve Customer Retention
Develop targeted retention campaigns for one-time customers to increase
repeat purchases.
2. Protect High-Value Customers
Prioritize high-value customers with loyalty programs and personalized
offers.
3. Improve Delivery Performance
Investigate sellers with consistently high late-delivery rates and
identify logistical bottlenecks.
4. Monitor Customer Satisfaction
Track review scores alongside delivery performance to identify operational
issues affecting customer experience.
5. Optimize Product Categories
Use category-level revenue and satisfaction metrics to prioritize
high-performing categories while investigating low-rated categories.
📁 Dataset
This project uses the Olist Brazilian E-Commerce Public Dataset.
The raw dataset is intentionally excluded from this GitHub repository
because of its size. The project structure and ETL pipeline are provided
for reproducibility.
🚀 How to Run
Clone the repository
git clone <YOUR_GITHUB_REPOSITORY_URL>
cd Enterprise-Customer-Revenue-Analytics

Create virtual environment
python -m venv .venv

Activate environment
Windows:
.venv\Scripts\activate

Install dependencies
pip install -r requirements.txt

Configure database
Create a .env file:
DB_HOST=localhost
DB_PORT=3306
DB_USER=root
DB_PASSWORD=your_password
DB_NAME=enterprise_analytics

Run ETL
python src/data_cleaning/clean_data.py

Load MySQL
python src/database/load_to_mysql.py

Then open the Power BI report and connect it to the
enterprise_analytics MySQL database.
👩‍💻 Skills Demonstrated
- Python
- Pandas
- NumPy
- SQL
- MySQL
- Data Cleaning
- ETL
- Data Modeling
- Power BI
- DAX
- Power Query
- Business Intelligence
- Exploratory Data Analysis
- Customer Analytics
- Revenue Analytics
- Operational Analytics
- Git
- GitHub