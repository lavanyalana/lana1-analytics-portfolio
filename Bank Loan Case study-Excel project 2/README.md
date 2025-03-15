# Bank Loan Case Study

## Exploratory Data Analysis (EDA) - Excel

In this project, I take on the role of a data analyst at a finance company specializing in loans for urban customers. The company faces two major risks:

1. Approving loans for applicants who cannot repay, leading to financial loss.
2. Rejecting applicants who can repay, causing a loss of business.

Using **Exploratory Data Analysis (EDA)**, my goal is to analyze customer and loan attributes to identify patterns that influence loan defaults. This analysis will help the company make better decisions regarding loan approvals, interest rates, and risk management.

---

## Approach

To tackle this problem, I followed a structured approach using **Microsoft Excel**:

1. **Identifying and Handling Missing Data** – Ensuring data completeness and accuracy.
2. **Detecting and Addressing Outliers** – Avoiding misleading results by treating extreme values.
3. **Analyzing Data Imbalance** – Understanding target variable distribution.
4. **Conducting Univariate, Segmented Univariate, and Bivariate Analysis** – Extracting meaningful insights.
5. **Finding Top Correlations in Different Segments** – Identifying key indicators of loan default.

I used **Excel formulas, pivot tables, and visualization tools** to explore patterns in loan defaults.

---

## Task A: Handling Missing Data

- Used **COUNT, IF, and ISBLANK** functions to detect missing values.
- Replaced missing numerical data using **median imputation** to prevent skewing analysis.
- Created a **bar chart** to visualize missing values in key variables.

---

## Task B: Identifying and Handling Outliers

- Used **QUARTILE** and **Interquartile Range (IQR)** to detect outliers.
- Created **Scatter plot** to visualize outliers in `AMT_INCOME_TOTAL`.
- Outliers in `AMT_INCOME_TOTAL` (showing unrealistic income) were marked for investigation.

---

## Task C: Data Imbalance Analysis

- Used **COUNTIF** to compare `TARGET = 1` (payment difficulties) vs. `TARGET = 0` (others).
- Found class imbalance, indicating fewer loan defaults but with significant financial impact.
- Created a **pie chart and bar chart** to illustrate the imbalance.

---

## Task D: Univariate, Segmented Univariate & Bivariate Analysis

### Univariate Analysis:

- Used **COUNT, AVERAGE, MIN, MAX, STDEV.P** formulas for descriptive analysis.
- Created **histograms** for `AMT_INCOME_TOTAL`, `AMT_CREDIT`, `AMT_ANNUITY`, and `AMT_GOODS_PRICE`.

### Segmented Univariate Analysis:

- Compared `AMT_INCOME_TOTAL` distributions for `TARGET = 1` vs. `TARGET = 0`.
  - **Insight:** Higher income amounts correlated with increased defaults.
- Compared `AMT_CREDIT` distributions for **LOAN CONTRACT TYPE** (revolving loans and cash loans).
  - **Insight:** Higher credit amounts correlated with cash loans.

### Bivariate Analysis:

- Created **heatmaps** to analyze relationships between variables.
- `AMT_CREDIT vs. TARGET` showed a **moderate correlation**.
- Created **Loan bin threshold** with bin labels, then classified loan amounts into bins.
- Used **pivot tables** to count the number of applicants falling under `TARGET = 0` or `TARGET = 1` in each range.
- Applied a **heatmap (Red-Yellow-Green)** to visually represent default rates across loan bins.

---

## Task E: Identifying Top Correlations for Loan Defaults

- Used **CORREL** function to calculate correlation between variables and `TARGET`.
- Segmented the data into clients with **payment difficulties (`TARGET = 1`)** and others (`TARGET = 0`).
- Performed **descriptive analysis** to extract meaningful insights.
- Found that **`AMT_INCOME_TOTAL` has a positive relationship with `TARGET`**.
- Created a **correlation heatmap** to highlight the strongest relationships.

---

## Results & Insights

- **Higher loan amounts (`AMT_CREDIT`) are associated with increased default risk**, especially when income is low.
- **Data imbalance in the target variable suggests the need for careful handling in predictive modeling**.
- **Income & Credit Amount are strong indicators of default risk**.
- **Lower-income applicants tend to have a higher loan default rate**.

---

## Tools Used

- **Microsoft Excel** (Formulas, Pivot Tables, Charts, Heatmaps)
- **Descriptive & Correlation Analysis**
- **Data Cleaning Techniques**

---

This project showcases my ability to conduct **Exploratory Data Analysis (EDA) using Excel** and extract meaningful insights to support **data-driven decision-making in finance**.
