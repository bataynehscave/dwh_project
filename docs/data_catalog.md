# 📘 Data Catalog: Gold Layer

## Overview
The **Gold Layer** represents the curated, business-friendly data model optimized for analytics and reporting. It consists of **dimension tables** for descriptive attributes and **fact tables** for quantitative metrics.

---

## 📁 Tables

### 1. `gold.dim_customers`
- **Description:** Contains enriched customer information, including demographics and geographic data.
- **Schema:**

| 🧱 Column Name     | 🔤 Data Type   | 📄 Description                                                                 |
|-------------------|----------------|--------------------------------------------------------------------------------|
| `customer_key`     | `INT`          | Surrogate key uniquely identifying each customer record.                      |
| `customer_id`      | `INT`          | Unique ID assigned to the customer.                                           |
| `customer_number`  | `NVARCHAR(50)` | External alphanumeric customer identifier.                                   |
| `first_name`       | `NVARCHAR(50)` | Customer's given name.                                                       |
| `last_name`        | `NVARCHAR(50)` | Customer's family or surname.                                                |
| `country`          | `NVARCHAR(50)` | Customer's country of residence.                                             |
| `marital_status`   | `NVARCHAR(50)` | Marital status (e.g., Single, Married).                                      |
| `gender`           | `NVARCHAR(50)` | Gender identity (e.g., Male, Female, N/A).                                   |
| `birthdate`        | `DATE`         | Date of birth (e.g., 1971-10-06).                                             |
| `create_date`      | `DATE`         | Date the customer record was created in the system.                          |

---

### 2. `gold.dim_products`
- **Description:** Contains information about products and related attributes such as category and cost.
- **Schema:**

| 🧱 Column Name         | 🔤 Data Type   | 📄 Description                                                                 |
|------------------------|----------------|--------------------------------------------------------------------------------|
| `product_key`          | `INT`          | Surrogate key uniquely identifying each product.                              |
| `product_id`           | `INT`          | Internal product identifier.                                                  |
| `product_number`       | `NVARCHAR(50)` | Structured alphanumeric product code.                                         |
| `product_name`         | `NVARCHAR(50)` | Descriptive name of the product.                                              |
| `category_id`          | `NVARCHAR(50)` | Unique identifier for the product's category.                                 |
| `category`             | `NVARCHAR(50)` | Broad product classification (e.g., Bikes, Components).                       |
| `subcategory`          | `NVARCHAR(50)` | Specific product type within the category.                                    |
| `maintenance_required` | `NVARCHAR(50)` | Indicates if maintenance is needed (`Yes` or `No`).                           |
| `cost`                 | `INT`          | Base cost of the product.                                                     |
| `product_line`         | `NVARCHAR(50)` | Product series or line (e.g., Road, Mountain).                                |
| `start_date`           | `DATE`         | Product launch or availability date.                                          |

---

### 3. `gold.fact_sales`
- **Description:** Records all transactional sales data including order details and metrics.
- **Schema:**

| 🧱 Column Name     | 🔤 Data Type   | 📄 Description                                                                 |
|--------------------|----------------|--------------------------------------------------------------------------------|
| `order_number`     | `NVARCHAR(50)` | Unique alphanumeric identifier for each sales order (e.g., 'SO54496').        |
| `product_key`      | `INT`          | Foreign key to the product dimension table.                                   |
| `customer_key`     | `INT`          | Foreign key to the customer dimension table.                                  |
| `order_date`       | `DATE`         | Date when the order was placed.                                               |
| `shipping_date`    | `DATE`         | Date when the order was shipped.                                              |
| `due_date`         | `DATE`         | Payment due date.                                                             |
| `sales_amount`     | `INT`          | Total sale value for the line item.                                           |
| `quantity`         | `INT`          | Number of units sold.                                                         |
| `price`            | `INT`          | Price per unit of the product.                                                |
