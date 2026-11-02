# HR Analytics Dashboard | Power BI

An interactive HR Analytics Dashboard developed using **Power BI, MySQL, Power Query, and DAX** to analyze workforce demographics, employee information, salary, performance, attendance, attrition, and recruitment.

This project transforms HR data into meaningful business insights through interactive dashboards, KPI cards, visualizations, slicers, bookmarks, and employee-level analysis.

---

## Project Overview

The HR Analytics Dashboard provides a comprehensive view of an organization's workforce and HR operations.

It helps analyze employee distribution, workforce composition, compensation, attendance patterns, employee exits, and recruitment performance.

The dashboard consists of **7 interactive pages**, designed to support HR reporting and data-driven decision-making.

## Tools & Technologies

- **Power BI** – Dashboard development and data visualization
- **MySQL** – SQL queries and data analysis
- **Power Query** – Data cleaning and transformation
- **DAX** – Measures, calculated columns, and KPI calculations
- **Microsoft Excel** – Dataset management

## Dashboard Pages

### 1. Employee Life Cycle
- Main navigation and dashboard overview.
- Navigation between different HR analytical sections.

### 2. HR at a Glance
- Total employee headcount.
- Active and exited employees.
- Employee attrition percentage.
- Average employee tenure.
- Employee distribution by department, gender, and location.
- Termination analysis.

### 3. Workforce & Demographics
- Educational diversity.
- Gender diversity by department.
- Job-title-wise employee distribution.
- Employee age-band analysis.
- Employee tenure analysis.
- Location-based workforce distribution.

### 4. Employee Profile
- Employee-level profile selection.
- Employee ID and personal information.
- Employee name, date of birth, gender, and education.
- Job designation and department.
- Employment information and location.
- Dynamic employee information based on selection.

### 5. Salary & Performance
- Total and average salary analysis.
- Gender-wise salary comparison.
- Department-wise salary distribution.
- Salary analysis by age band.
- Location-wise salary analysis.
- Job-title-wise average salary.

### 6. Attendance & Attrition
- Attendance rate.
- Absence rate.
- Total leave days.
- Attrition rate.
- Total present days.
- Department-wise attendance and attrition analysis.
- Attendance trends and leave analysis.
- Exit analysis by reason and type.

### 7. Recruitment & Hiring
- Total open positions.
- Total applications.
- Total hires.
- Average time to hire.
- Hiring conversion rate.
- Department-wise applications.
- Department-wise hiring analysis.

---

## Key Performance Indicators

| KPI | Dashboard Value |
|---|---:|
| Total Employees | 1,000 |
| Active Employees | 956 |
| Exited Employees | 44 |
| Attrition Rate | 4.40% |
| Average Tenure | 4.46 Years |
| Attendance Rate | 89.27% |
| Absence Rate | 6.06% |
| Total Leave Days | 10,959 |
| Total Present Days | 209,537 |
| Open Positions | 958 |
| Total Applications | 10K |
| Total Hires | 421 |
| Average Time to Hire | 42.40 Days |
| Hiring Conversion Rate | 43.95% |

*Values represent the dataset and dashboard at the time of project development.*

## SQL Analysis

SQL was used to perform business-oriented HR data analysis, including:

- Employee headcount analysis.
- Department-wise employee distribution.
- Salary analysis.
- Attendance and absence analysis.
- Leave analysis.
- Attrition and exit analysis.
- Performance analysis.
- Recruitment and hiring analysis.
- Joins, aggregations, subqueries, CTEs, and window functions.

The SQL queries are available in:

`HR-analysis.sql`

## Power BI Features

- Interactive KPI cards.
- Dynamic slicers and filters.
- Bookmark navigators.
- Page navigation.
- Employee-level filtering.
- Interactive charts and tables.
- DAX measures and calculated columns.
- Relational data modeling.

## Project Files

| File | Description |
|---|---|
| `HR_DASHBOARD.pbix` | Power BI project file |
| `HR_DASHBOARD.pdf` | Exported dashboard report |
| `HR-analysis.sql` | SQL analysis queries |
| `HR_Analytics_Dataset.xlsx` | HR dataset |

## How to Use

1. Clone or download this repository.
2. Open `HR_DASHBOARD.pbix` using Power BI Desktop.
3. Configure the required data source if prompted.
4. Refresh the data if the original MySQL connection is available.
5. Explore the dashboard using slicers, filters, bookmarks, and navigation.
6. Refer to `HR_DASHBOARD.pdf` to view the exported report without Power BI Desktop.

## Project Objective

The main objective of this project is to demonstrate practical skills in SQL, data preparation, data modeling, DAX calculations, business intelligence, and interactive dashboard development.

## Author

**Manoj Kumar**

GitHub: [@manojkumar173](https://github.com/manojkumar173)

---

If you find this project useful, feel free to explore the repository and share your feedback.
