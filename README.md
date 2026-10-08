# Job Market & Skills Demand Analytics

## Project Overview

**Job Market & Skills Demand Analytics** is a data analytics project focused on understanding the Indian technology job market through job postings, hiring demand, required skills, salary patterns, experience requirements, locations, work modes, company characteristics, and fresher opportunities.

The project uses **Python for data cleaning, preparation, exploratory analysis, feature engineering, and visualization**, and **SQL for business-oriented analysis and KPI generation**.

The objective is to transform raw job-market data into structured analytical outputs that can answer practical business and career-related questions such as:

- Which technology roles have the highest hiring demand?
- Which cities have the highest concentration of technology jobs?
- Which technical skills are most frequently required?
- How does salary vary across roles and experience levels?
- Which roles provide more opportunities for freshers?
- What work modes are most common?
- Which companies are hiring the most?
- How transparent are companies about salary?
- How does hiring vary by company size?
- What is the relationship between experience and salary?
- Which roles combine strong demand with attractive salary levels?

---

## Business Objective

The main objective of this project is to analyze job-market data and generate **actionable business insights** related to hiring demand, skills, compensation, geography, experience, and employment opportunities.

The analysis is structured around the following business areas:

1. Market Size
2. Hiring Demand
3. Geographic Hiring
4. Skill Demand
5. Salary Analysis
6. Experience Analysis
7. Fresher Opportunities
8. Work Mode
9. Company Hiring
10. Company Size
11. Salary Transparency
12. Job Posting Recency

---

## Dataset

The project uses an Indian technology job-market dataset.

The dataset is analyzed at the **job-posting level**, with additional skill-level data created for skill-demand analysis.

### Main Dataset

`indian_tech_jobs_2026.csv`

Contains the original job-market records.

### Cleaned Dataset

`indian_tech_jobs_2026_cleaned.csv`

Contains the cleaned and analysis-ready job records.

### Skill Dataset

`job_market_skill_table.csv`

Contains individual skills extracted from job postings.

The skill table contains:

- `job_id`
- `skills_required_clean`
- `skill`

Each job can therefore be associated with multiple required skills.

---

## Dataset Scale

The cleaned job-market dataset contains approximately:

- **23,201 job postings**
- **50 columns**

The skill-level dataset contains approximately:

- **176,394 skill records**
- **3 columns**

The exact values are preserved in the generated project files and reports.

---

# Project Workflow

The project follows a structured data analytics workflow:

```text
Raw Job Data
      ↓
Data Profiling
      ↓
Data Cleaning
      ↓
Data Validation
      ↓
Feature Engineering
      ↓
Skill Extraction
      ↓
Exploratory Data Analysis
      ↓
Business Metrics
      ↓
SQL Analysis
      ↓
Visualization
      ↓
Business Insights
