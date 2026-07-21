# marketing-growth-analytics-pipeline
End-to-end marketing &amp; growth analytics pipeline using BigQuery and Looker Studio, featuring KPI modeling, true sequential funnel analysis, and customer engagement insights.

 End-to-End Marketing & Growth Analytics Pipeline

From raw events to executive insights

This project demonstrates an end-to-end analytics pipeline built using Google Cloud Platform (GCS + BigQuery) and Looker Studio to analyze revenue performance, customer funnel behavior, and engagement health.
It mirrors how modern analytics teams structure data, apply business logic, and deliver decision-ready dashboards.

Project Objective

The goal of this project was to answer three core business questions:

How is revenue trending over time?

Where are customers dropping off in the funnel?

Are customers still engaged or at risk of churn?

Architecture Overview

The project follows a layered analytics architecture to ensure scalability, clarity, and lineage.

Google Cloud Storage (CSV files)
        ↓
BigQuery – Raw Layer
        ↓
BigQuery – Staging Layer
        ↓
BigQuery – Mart Layer
        ↓
Looker Studio Dashboard

Data Layers Explained
🔹 Raw Layer

Source data uploaded as CSV files into Google Cloud Storage

Loaded into BigQuery raw tables

No transformations applied

Purpose: preserve original data for traceability

🔹 Staging Layer

Cleaned and standardized data

Key transformations:

Removed null identifiers

Standardized date formats

Normalized event types

Purpose: prepare data for analytics logic

🔹 Mart Layer

Business-ready analytical tables built using SQL:

Daily KPIs

Revenue

Orders

Active customers

Average Order Value (AOV)

True Sequential Funnel

visit → page_view → email_open → click → purchase

Enforced correct event order per customer

Customer Latest Activity

One row per customer

Captures most recent interaction

Customer Engagement / Recency

Days since last activity

Engagement buckets (active → churn risk)

These tables are optimized for reporting and dashboards.

<img width="1122" height="733" alt="image" src="https://github.com/user-attachments/assets/78c0fb28-9880-484a-89d8-73556a558a30" />

📈 Key Analytics & Insights
1️⃣ Revenue & KPI Analysis


Built daily KPIs and applied a 7-day moving average to smooth volatility

Enabled executives to see true performance trends instead of daily noise

📌 Insight: Revenue trends were stable once short-term fluctuations were smoothed.

2️⃣ True Sequential Funnel Analysis

Implemented a true funnel, ensuring customers progressed through steps in order

Avoided misleading “event count” funnels

📌 Insight:
The largest drop-off occurs between visit and page_view, indicating a landing page or traffic quality optimization opportunity.

3️⃣ Customer Engagement & Churn Signals

Identified each customer’s most recent activity

Calculated recency using the dataset’s latest event date (for realistic historical analysis)

Bucketed customers into:

0–7 days (active)

8–30 days (cooling)

31–60 days (disengaging)

60+ days (churn risk)

📌 Insight:
Most customers are active within the last 30 days, but a significant portion is cooling off — a strong re-engagement opportunity.

📊 Dashboard (Looker Studio)

The final dashboard is designed using FAANG-style data storytelling principles:

Sections:

Executive Snapshot

Revenue, Orders, Active Customers, AOV

Revenue Performance

7-day moving average trend

Funnel Drop-Off Analysis

True sequential funnel

Conversion bottlenecks

Customer Engagement Health

Recency distribution

Churn risk visibility

📌 The dashboard answers:

What’s happening?

Why is it happening?

What should we do next?

Tech Stack

Google Cloud Storage – data ingestion

BigQuery – data warehousing & SQL analytics

Looker Studio – visualization & dashboards

SQL – window functions, CTEs, analytics logic


🧠 Key Takeaways

✔ End-to-end ETL & analytics engineering thinking
✔ Advanced SQL (CTEs, window functions, sequential logic)
✔ Funnel & growth analytics
✔ Customer engagement and churn modeling
✔ Executive-ready dashboard design

