from pathlib import Path
import pandas as pd
import numpy as np
PROJECT_ROOT = Path(
    r"C:\Users\donna\OneDrive\Desktop\Enterprise-Customer-Revenue-Analytics"
)

RAW_DIR = PROJECT_ROOT / "data" / "raw"
PROCESSED_DIR = PROJECT_ROOT / "data" / "processed"

PROCESSED_DIR.mkdir(parents=True, exist_ok=True)
def load_csv(filename):
    """Load a CSV file from the raw data directory."""
    filepath = RAW_DIR / filename

    if not filepath.exists():
        raise FileNotFoundError(
            f"File not found: {filepath}"
        )

    return pd.read_csv(filepath)
customers = load_csv(
    "olist_customers_dataset.csv"
)

orders = load_csv(
    "olist_orders_dataset.csv"
)

order_items = load_csv(
    "olist_order_items_dataset.csv"
)

payments = load_csv(
    "olist_order_payments_dataset.csv"
)

reviews = load_csv(
    "olist_order_reviews_dataset.csv"
)

products = load_csv(
    "olist_products_dataset.csv"
)

sellers = load_csv(
    "olist_sellers_dataset.csv"
)

category_translation = load_csv(
    "product_category_name_translation.csv"
)
def clean_customers(df):
    df = df.copy()

    # Remove completely duplicated records
    df = df.drop_duplicates()

    # Standardize text fields
    text_columns = [
        "customer_city",
        "customer_state"
    ]

    for column in text_columns:
        df[column] = (
            df[column]
            .astype("string")
            .str.strip()
            .str.lower()
        )

    return df
customers = clean_customers(customers)
def clean_orders(df):
    df = df.copy()

    # Remove exact duplicate records
    df = df.drop_duplicates()

    # Convert timestamps
    date_columns = [
        "order_purchase_timestamp",
        "order_approved_at",
        "order_delivered_carrier_date",
        "order_delivered_customer_date",
        "order_estimated_delivery_date"
    ]

    for column in date_columns:
        df[column] = pd.to_datetime(
            df[column],
            errors="coerce"
        )

    # Standardize order status
    df["order_status"] = (
        df["order_status"]
        .astype("string")
        .str.strip()
        .str.lower()
    )

    return df

orders = clean_orders(orders)
def add_order_metrics(df):
    df = df.copy()

    # Delivery time in days
    df["delivery_days"] = (
        df["order_delivered_customer_date"]
        - df["order_purchase_timestamp"]
    ).dt.total_seconds() / (60 * 60 * 24)

    # Delivery delay compared with estimate
    df["delivery_delay_days"] = (
        df["order_delivered_customer_date"]
        - df["order_estimated_delivery_date"]
    ).dt.total_seconds() / (60 * 60 * 24)

    # Flag late deliveries
    df["is_late"] = (
        df["delivery_delay_days"] > 0
    ).astype("Int64")

    # Flag successfully delivered orders
    df["is_delivered"] = (
        df["order_status"] == "delivered"
    ).astype("Int64")

    return df
orders = add_order_metrics(orders)
def clean_order_items(df):
    df = df.copy()

    df = df.drop_duplicates()

    # Ensure numeric columns are numeric
    numeric_columns = [
        "order_item_id",
        "price",
        "freight_value"
    ]

    for column in numeric_columns:
        df[column] = pd.to_numeric(
            df[column],
            errors="coerce"
        )

    # Convert shipping date
    df["shipping_limit_date"] = pd.to_datetime(
        df["shipping_limit_date"],
        errors="coerce"
    )

    return df
order_items = clean_order_items(order_items)
def add_sales_metrics(df):
    df = df.copy()

    df["gross_item_value"] = (
        df["price"] * 1
    )

    df["total_item_value"] = (
        df["price"] + df["freight_value"]
    )

    return df
order_items = add_sales_metrics(order_items)
def clean_payments(df):
    df = df.copy()

    df = df.drop_duplicates()

    df["payment_type"] = (
        df["payment_type"]
        .astype("string")
        .str.strip()
        .str.lower()
    )

    df["payment_value"] = pd.to_numeric(
        df["payment_value"],
        errors="coerce"
    )

    df["payment_installments"] = pd.to_numeric(
        df["payment_installments"],
        errors="coerce"
    )

    return df
payments = clean_payments(payments)
def clean_reviews(df):
    df = df.copy()

    df = df.drop_duplicates()

    date_columns = [
        "review_creation_date",
        "review_answer_timestamp"
    ]

    for column in date_columns:
        df[column] = pd.to_datetime(
            df[column],
            errors="coerce"
        )

    # Keep missing comments as NULL.
    # They are optional fields.

    return df
reviews = clean_reviews(reviews)
def clean_products(df):
    df = df.copy()

    df = df.drop_duplicates()

    # Standardize category text
    df["product_category_name"] = (
        df["product_category_name"]
        .astype("string")
        .str.strip()
        .str.lower()
    )

    numeric_columns = [
    "product_name_lenght",
    "product_description_lenght",
    "product_photos_qty",
    "product_weight_g",
    "product_length_cm",
    "product_height_cm",
    "product_width_cm"
]

    for column in numeric_columns:
        df[column] = pd.to_numeric(
            df[column],
            errors="coerce"
        )

    return df
products = clean_products(products)
products = products.merge(
    category_translation,
    on="product_category_name",
    how="left"
)
products = products.rename(
    columns={
        "product_category_name_english":
        "product_category_name_english"
    }
)
products["product_category_name_english"] = (
    products["product_category_name_english"]
    .fillna("unknown")
)
def clean_sellers(df):
    df = df.copy()

    df = df.drop_duplicates()

    df["seller_city"] = (
        df["seller_city"]
        .astype("string")
        .str.strip()
        .str.lower()
    )

    df["seller_state"] = (
        df["seller_state"]
        .astype("string")
        .str.strip()
        .str.upper()
    )

    return df
sellers = clean_sellers(sellers)
output_tables = {
    "customers_clean": customers,
    "orders_clean": orders,
    "order_items_clean": order_items,
    "payments_clean": payments,
    "reviews_clean": reviews,
    "products_clean": products,
    "sellers_clean": sellers
}

for name, df in output_tables.items():
    output_path = PROCESSED_DIR / f"{name}.csv"

    df.to_csv(
        output_path,
        index=False
    )

    print(
        f"Saved {name}: "
        f"{len(df):,} rows"
    )
if __name__ == "__main__":
    print("ETL pipeline completed successfully.")

