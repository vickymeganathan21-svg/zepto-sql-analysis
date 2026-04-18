# Zepto SQL Data Analysis Project

## Project Overview

In this project, I worked on analyzing a Zepto product dataset using SQL. The main goal was to clean the data, perform necessary transformations, and extract useful insights related to product pricing, discounts, and availability.

This project helped me understand how raw data can be turned into meaningful business insights using SQL.

---

## Dataset Description

The dataset contains product-level information such as:

* `name` – Product name
* `category` – Product category
* `mrp` – Maximum Retail Price (stored in paisa)
* `disc_sp` – Discounted selling price (in paisa)
* `dis_percent` – Discount percentage
* `available_quan` – Available quantity
* `outofstock` – Stock availability status

---

## Data Cleaning

* Removed invalid records like products with MRP = 0
* Checked for null or missing values
* Ensured all numeric columns had correct data types
* Fixed minor inconsistencies in the dataset

---

## Data Transformation

* Converted price values from paisa to rupees for better understanding
* Calculated discount amount for each product
* Used rounding to make outputs cleaner and more readable

---

## Key Analysis Performed

* Identified products with higher discounts
* Compared price ranges across different categories
* Found the most expensive and least expensive products
* Calculated average product pricing
* Checked whether discount percentages are applied correctly

---

## Key Insights

* Only a small number of products fall into the higher price range
* Discounts vary across categories
* Some discount values do not exactly match calculated values
* The dataset includes both budget-friendly and premium products

---

## Tools & Technologies

* PostgreSQL (pgAdmin 4)
* SQL (Joins, Aggregations, Window Functions)

---

## Skills Demonstrated

* Writing SQL queries
* Data cleaning and preprocessing
* Data transformation
* Basic business analysis
* Problem-solving

---

## Project Structure

```id="k3z9xq"
zepto-sql-analysis/
│
├── dataset/
├── queries.sql
├── insights.txt
└── README.md
```

---

## Conclusion

This project provided hands-on experience in working with real-world data using SQL. It improved my understanding of data cleaning, analysis, and deriving insights that can support decision-making.

---
