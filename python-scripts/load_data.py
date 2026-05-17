import pandas as pd
import mysql.connector
import os
from dotenv import load_dotenv

load_dotenv()

# Load CSV
df = pd.read_csv(os.getenv("CSV_PATH"), encoding="latin1")

# Convert dates (THIS IS THE FIX)
df["Order Date"] = pd.to_datetime(df["Order Date"], format="%m/%d/%Y").dt.date
df["Ship Date"] = pd.to_datetime(df["Ship Date"], format="%m/%d/%Y").dt.date

# Connect MySQL
conn = mysql.connector.connect(
    host=os.getenv("DB_HOST"),
    user=os.getenv("DB_USER"),
    password=os.getenv("DB_PASSWORD"),
    database=os.getenv("DB_NAME")
)

cursor = conn.cursor()

cursor.execute("TRUNCATE TABLE superstore_raw")

for _, row in df.iterrows():
    cursor.execute("""
        INSERT INTO superstore_raw (
            row_id, order_id, order_date, ship_date, ship_mode,
            customer_id, customer_name, segment, country, city,
            state, postal_code, region, product_id, category,
            sub_category, product_name, sales, quantity, discount, profit
        ) VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)
    """, tuple(row))

conn.commit()
cursor.close()
conn.close()

print("Data loaded successfully")