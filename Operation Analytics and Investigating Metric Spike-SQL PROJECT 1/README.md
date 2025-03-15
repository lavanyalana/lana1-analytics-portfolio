Operational Analytics & Investigating Metric Spike - Advanced SQL

Project Overview

  Operational Analytics plays a crucial role in evaluating and optimizing a company's end-to-end operations. In this project, I conducted two case studies focusing on job data analysis and user engagement trends. As a Lead Data Analyst, I collaborated with operations, support, and marketing teams to extract insights, track key performance indicators, and investigate sudden metric spikes.

  Approach & Methodology

- To carry out this project, I followed a structured data analysis process:

- Importing Data – Imported large CSV files into MySQL using query-based methods.

- Understanding the Data – Examined datasets to grasp their structure and key attributes.

- Query Execution – Wrote SQL queries to extract meaningful insights.

- Analysis & Interpretation – Processed query results to address specific business tasks.

- Reporting & Documentation – Compiled findings into a structured format for business stakeholders.

Case Study 1: Job Data Analysis

  Task A: Jobs Reviewed Over Time

Objective: Analyze job review trends and calculate the number of jobs reviewed per hour for each day in November 2020.

Converted time spent on job reviews (given in seconds) to hours.

Identified fluctuations in job reviews per day.

Key Finding: Only two jobs were reviewed on November 28 & 30, while other days had one job reviewed each.

  Task B: Throughput Analysis

Objective: Calculate the 7-day rolling average of throughput (number of events per second).

Computed both daily metrics and 7-day rolling averages.

Key Finding: Due to the dataset containing only six days of data, daily metrics were prioritized.

  Task C: Language Share Analysis

Objective: Determine the percentage share of each language over the last 30 days.

The dataset contained only six days of data, so calculations were adjusted accordingly.

Key Finding: Persian language had the highest percentage share compared to others.

  Task D: Duplicate Rows Detection

Objective: Identify duplicate rows in the job data.

Checked for duplicate records using SQL.

Key Finding: No duplicate rows were found (all values were unique).

Case Study 2: Investigating Metric Spike

  Task A: Weekly User Engagement

Objective: Measure user activity on a weekly basis.

- Approach 1: Measured engagement for each event type per week.

- Approach 2: Measured total user engagement across all event types per week.

  Task B: User Growth Analysis

Objective: Track user growth trends over time.

- Result 1: Extracted user engagement data per device type for each month (four months total).

- Result 2: Computed average user growth per device, identifying devices with the highest engagement.

  Task C: Weekly Retention Analysis

- Objective: Analyze user retention based on sign-up cohorts.

- Identified activated users (those who signed up).

- Tracked last active week per user.

- Key Finding: Calculated retention percentage to analyze user loyalty.

  Task D: Weekly Engagement Per Device

- Objective: Compare engagement levels across different devices on a weekly basis.

- Output 1: Measured engagement for specific devices (e.g., Acer Aspire Desktop).

- Output 2: Calculated weekly engagement percentages for all devices (e.g., MacBook Pro had 22% engagement in Week 17).

  Task E: Email Engagement Analysis

- Objective: Assess user interaction with email services.

- Four engagement actions analyzed: Email opened, email clicked, email sent, and re-engagement.

- SQL CTEs were used to calculate user counts and engagement percentages.

  Key Insights & Business Impact

1. Jobs Reviewed Over Time – Identified fluctuations in job reviews, improving workforce planning.

2. Throughput Analysis – Provided data on job completion rates for optimizing workflows.

3. Language Share Analysis – Helped in resource allocation and market targeting for different language demographics.

4. Weekly User Engagement – Identified fluctuations in user interactions, refining engagement strategies.

5. User Growth Analysis – Tracked new user sign-ups, highlighting growth trends and retention challenges.

6. Weekly Retention Analysis – Provided insights into user loyalty and long-term engagement.

7. Weekly Engagement Per Device – Compared engagement across devices to optimize user experience.

8. Email Engagement Analysis – Evaluated email campaign effectiveness, guiding improvements in communication strategies.


   Project Takeaways & Learnings

- Strengthened SQL proficiency with advanced queries, CTEs, and window functions.
- Extracted actionable business insights from real-world datasets.
- Improved decision-making through data-driven analysis.
- Refined data storytelling & reporting skills to communicate findings effectively.



