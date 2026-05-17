# Celebal Assignment 2 – SQL Data Analysis

Overview
Performed SQL operations as ststed on the LMS portal using a Superstore dataset, including data exploration, filtering, aggregation, and analytical queries.

Dataset
- `data/SampleSuperstore.csv` – raw dataset used for loading into the database.

File Structure
- `data/` – dataset files  
- `sql-scripts/` – SQL scripts for setup, insertion, and analysis  
- `python-scripts/` – script to load CSV data into database  

## Steps Performed

1. Database Setup
   - Created schema and tables structure using `setup.sql`

2. Data Loading
   - Inserted dataset into database using `insert_data.sql`
   - Automated csv loading into the initial database table named "superstore_raw" using `load_data.py`

3. Data Analysis
   - Inspected table schema and sample records
   - Applied WHERE conditions on region, category, date, and sales
   - Used GROUP BY for:
     - Total sales
     - Quantity sold
     - Average metrics
   - Identified top products and categories using ORDER BY and LIMIT
   - Monthly sales trends
   - Top customers analysis
   - Duplicate detection

8. **Data Validation**
   - Verified row counts
   - Checked data consistency and quality

By
Archit Sahay
