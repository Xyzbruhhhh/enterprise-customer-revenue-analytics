from pathlib import Path

import pandas as pd
from sqlalchemy import create_engine, text
from dotenv import load_dotenv
import os


# ============================================================
# PROJECT PATHS
# ============================================================

PROJECT_ROOT = Path(
    r"C:\Users\donna\OneDrive\Desktop\Enterprise-Customer-Revenue-Analytics"
)

PROCESSED_DIR = PROJECT_ROOT / "data" / "processed"

ENV_FILE = PROJECT_ROOT / ".env"


# ============================================================
# LOAD ENVIRONMENT VARIABLES
# ============================================================

load_dotenv(ENV_FILE)

DB_HOST = os.getenv("DB_HOST")
DB_PORT = os.getenv("DB_PORT", "3306")
DB_USER = os.getenv("DB_USER")
DB_PASSWORD = os.getenv("DB_PASSWORD")
DB_NAME = os.getenv("DB_NAME")


# ============================================================
# CHECK DATABASE CONFIGURATION
# ============================================================

print("Database configuration:")
print(f"Host: {DB_HOST}")
print(f"Port: {DB_PORT}")
print(f"User: {DB_USER}")
print(f"Database: {DB_NAME}")


# ============================================================
# CREATE MYSQL CONNECTION
# ============================================================

connection_string = (
    f"mysql+pymysql://"
    f"{DB_USER}:{DB_PASSWORD}@"
    f"{DB_HOST}:{DB_PORT}/"
    f"{DB_NAME}"
)

engine = create_engine(connection_string)


# ============================================================
# TEST CONNECTION
# ============================================================

try:

    with engine.connect() as connection:

        result = connection.execute(
            text("SELECT DATABASE();")
        )

        database_name = result.scalar()

        print(
            f"\nSuccessfully connected to MySQL database: "
            f"{database_name}"
        )

except Exception as error:

    print("\nDatabase connection failed.")

    print("Error:")
    print(error)

    raise


# ============================================================
# LOAD CSV FUNCTION
# ============================================================

def load_table(
    csv_filename,
    table_name
):

    csv_path = PROCESSED_DIR / csv_filename

    if not csv_path.exists():

        raise FileNotFoundError(
            f"CSV file not found: {csv_path}"
        )

    print(
        f"\nLoading {csv_filename}..."
    )

    df = pd.read_csv(csv_path)

    print(
        f"Rows found: {len(df):,}"
    )

    df.to_sql(
        table_name,
        con=engine,
        if_exists="append",
        index=False,
        chunksize=5000
    )

    print(
        f"Successfully loaded "
        f"{len(df):,} rows into {table_name}"
    )


# ============================================================
# LOAD TABLES IN FOREIGN-KEY ORDER
# ============================================================

load_table(
    "customers_clean.csv",
    "customers"
)

load_table(
    "products_clean.csv",
    "products"
)

load_table(
    "sellers_clean.csv",
    "sellers"
)

load_table(
    "orders_clean.csv",
    "orders"
)

load_table(
    "order_items_clean.csv",
    "order_items"
)

load_table(
    "payments_clean.csv",
    "payments"
)

load_table(
    "reviews_clean.csv",
    "reviews"
)


# ============================================================
# FINISHED
# ============================================================

print(
    "\n=========================================="
)

print(
    "ETL DATABASE LOAD COMPLETED SUCCESSFULLY"
)

print(
    "=========================================="
)