# 🏗️ Data Warehouse & Analytics Project

> A production-style data warehousing and analytics solution built with SQL, demonstrating end-to-end data engineering from raw ingestion to business-ready insights.

![SQL](https://img.shields.io/badge/SQL-Data%20Warehouse-blue?style=flat-square&logo=microsoftsqlserver)
![Architecture](https://img.shields.io/badge/Architecture-Medallion-orange?style=flat-square)
![Status](https://img.shields.io/badge/Status-Complete-brightgreen?style=flat-square)

---

## 📌 Project Overview

This project showcases a complete **Data Warehouse** built using the **Medallion Architecture** (Bronze → Silver → Gold), consolidating data from two source systems into an analytics-ready data model.

It is designed as a portfolio project to demonstrate:

- Data pipeline design and ETL development
- Data quality handling and transformation logic
- Dimensional modelling with STAR Schema
- SQL-based analytical reporting and business insights

---

## 🗂️ Repository Structure

```
├── datasets/                  # Raw source data (CSV files — ERP & CRM)
├── scripts/
│   ├── bronze/                # Raw ingestion layer
│   ├── silver/                # Cleaned and transformed layer
│   └── gold/                  # Business-ready dimensional model
├── tests/                     # Data quality checks
├── docs/
│   ├── data_flow_diagram.png  # End-to-end pipeline diagram
│   └── integration_model.png  # Gold layer STAR Schema diagram
└── README.md
```

---

## 🏛️ Architecture: Medallion Data Warehouse

This project follows the **Medallion Architecture**, a layered approach to progressively refine raw data into trusted, analytics-ready datasets.

| Layer | Purpose |
|-------|---------|
| 🥉 **Bronze** | Raw data ingested as-is from ERP and CRM CSV source files |
| 🥈 **Silver** | Cleaned, standardised, and deduplicated data ready for integration |
| 🥇 **Gold** | Business-facing dimensional model (STAR Schema) optimised for analytics |

### Data Flow Diagram
<img width="697" height="483" alt="dwh_gold_layer_data_flow_diagram" src="https://github.com/user-attachments/assets/a1c653a2-b3db-44bf-a25c-4bca67f350fa" />

The diagram illustrates how data moves through each layer — from source CSV files through the Bronze, Silver, and Gold layers.

### Gold Layer Integration Model
<img width="696" height="458" alt="dwh_integration_model_gold_layer" src="https://github.com/user-attachments/assets/e40c88ba-464d-4b08-a4f5-6df2183afe1d" />

The STAR Schema in the Gold layer consists of:

- `dim_customer` — Customer dimension built from CRM data
- `dim_product` — Product dimension built from ERP data
- `fact_sales` — Central fact table linking dimensions with transactional sales metrics

---

## ⚙️ Project Requirements & Specifications

### Objective

Develop a modern Data Warehouse using SQL to consolidate sales data from multiple source systems, enabling reliable analytical reporting and informed decision-making.

### Scope & Decisions

| Dimension | Decision |
|-----------|---------|
| **Data Sources** | Two source systems — ERP and CRM — provided as CSV files |
| **Data Quality** | Cleansing and issue resolution applied in the Silver layer |
| **Integration** | Both sources merged into a unified analytical model |
| **Historisation** | Out of scope — latest snapshot only |
| **Output** | STAR Schema dimensional model in Gold layer |

---

## 📊 Analytics & Reporting

SQL-based analytical queries are built on top of the Gold layer to deliver actionable business insights across three domains:

**Customer Behaviour**
- Segmentation by purchase frequency and lifetime value
- Identifying high-value vs at-risk customers

**Product Performance**
- Top and bottom performing products by revenue
- Category-level sales contribution

**Sales Trends**
- Period-over-period revenue comparisons
- Seasonal patterns and growth metrics

These insights are designed to give business stakeholders the metrics needed for strategic decision-making.

---

## 🔧 Tools & Technologies

| Tool | Usage |
|------|-------|
| **SQL Server / T-SQL** | Core data warehouse development |
| **CSV (ERP & CRM)** | Source data files |
| **Medallion Architecture** | Layered pipeline design |
| **STAR Schema** | Gold layer dimensional modelling |
| **Notion** | Project management and progress tracking |

---

## 📋 Project Management

Project tasks, milestones, and progress are tracked using Notion:

🔗 [View Project Board on Notion](https://www.notion.so/Data-Warehouse-Project-36398e138f92804da543cce8a3325bfb?source=copy_link)

---

## 👤 About Me

Hi, I'm **Shiran**, a Commercial Operations Leader sharpening skills in Data Engineering and Analytics.

This project reflects my hands-on approach to learning: building real, structured solutions that mirror industry practices rather than following tutorials passively.

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Shiran%20Batuvita-0A66C2?style=flat-square&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/shiran-batuvita/)

---

## 📄 License

This project is licensed under the [MIT License](LICENSE). You are free to use, modify, and distribute it with proper attribution.
