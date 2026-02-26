
Medallion Architecture Overview

This project implements a three-layer Medallion Architecture using Databricks Serverless SQL.

Bronze Layer

Raw ingestion from Unity Catalog Volume

No transformation

Source of truth

Preserves original schema

Silver Layer

Data cleaning

Type casting

Business rule validation

Delta CHECK constraints

Referential integrity enforcement

Gold Layer

Business-level aggregations

KPI generation

Reporting-ready dataset

Why Medallion?

Separates raw data from business logic

Enables debugging

Improves governance

Supports incremental processing

Follows modern Lakehouse best practices