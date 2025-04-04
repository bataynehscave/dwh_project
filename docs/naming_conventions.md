# 📘 Data Warehouse Naming Conventions

This document defines the standard naming conventions for schemas, tables, columns, views, and other database objects in the data warehouse to ensure consistency, clarity, and ease of understanding.

---

## 📚 Table of Contents

1. [General Guidelines](#general-guidelines)  
2. [Table Naming Conventions](#table-naming-conventions)  
   - [Bronze Layer](#bronze-layer)  
   - [Silver Layer](#silver-layer)  
   - [Gold Layer](#gold-layer)  
3. [Column Naming Conventions](#column-naming-conventions)  
   - [Surrogate Keys](#surrogate-keys)  
   - [Technical Columns](#technical-columns)  
4. [Stored Procedure Naming](#stored-procedure-naming)  

---

## 🧾 General Guidelines

- Use `snake_case` with lowercase letters and underscores (`_`) to separate words.
- All names must be in **English**.
- Avoid using **SQL reserved keywords** as object names.

---

## 🗃️ Table Naming Conventions

### 🟤 Bronze Layer

- Use the original table name from the source system, prefixed by the source system name.

**Format:**  
```
<source_system>_<entity>
```

**Definitions:**  
- `<source_system>`: The name of the source system (e.g., `crm`, `erp`)  
- `<entity>`: The exact table name from the source system  

**Example:**  
`crm_customer_info` → Customer information from the CRM system

---

### ⚪ Silver Layer

- Follows the same convention as the Bronze layer: use the source system and original entity name.

**Format:**  
```
<source_system>_<entity>
```

**Example:**  
`erp_invoice_details` → Invoice details from the ERP system

---

### 🟡 Gold Layer

- Use business-aligned, descriptive names prefixed by the table category.

**Format:**  
```
<category>_<entity>
```

**Definitions:**  
- `<category>`: Table type, such as `dim`, `fact`, or `agg`  
- `<entity>`: Descriptive business entity name  

**Examples:**  
- `dim_customers` → Customer dimension table  
- `fact_sales` → Sales fact table  

#### 📑 Category Prefix Glossary

| Prefix   | Description             | Examples                          |
|----------|-------------------------|-----------------------------------|
| `dim_`   | Dimension table         | `dim_customer`, `dim_product`     |
| `fact_`  | Fact table              | `fact_sales`, `fact_orders`       |
| `agg_`   | Aggregated data table   | `agg_sales_monthly`, `agg_customers` |

---

## 🧱 Column Naming Conventions

### 🔑 Surrogate Keys

- Primary keys in dimension tables must end with `_key`.

**Format:**  
```
<entity>_key
```

**Example:**  
`customer_key` → Primary key in the `dim_customers` table

---

### ⚙️ Technical Columns

- System-generated metadata columns must begin with the `dwh_` prefix.

**Format:**  
```
dwh_<description>
```

**Examples:**  
- `dwh_load_date` → Date the record was loaded  
- `dwh_updated_by` → System or process that last updated the record  

---

## 🛠️ Stored Procedure Naming

Stored procedures related to data loading should follow a standard naming format based on the layer they serve.

**Format:**  
```
load_<layer>
```

**Definitions:**  
- `<layer>`: The data layer, such as `bronze`, `silver`, or `gold`  

**Examples:**  
- `load_bronze` → Procedure to load data into the Bronze layer  
- `load_gold` → Procedure to load transformed data into the Gold layer  
