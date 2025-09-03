# 🛒 Walmart Sales & Profitability Analysis  

## 📌 Project Overview  
This project is an **end-to-end data analysis solution** designed to extract **critical business insights** from Walmart sales data.  

We utilize:  
- **Python** for data processing and cleaning  
- **SQL (PostgreSQL + MySQL)** for advanced querying and business problem solving  
- **Structured problem-solving techniques** to translate raw data into **actionable business strategies**  

This project is ideal for **data analysts** looking to build skills in:  
- Data manipulation (Pandas, SQLAlchemy)  
- SQL querying & analytics (aggregations, window functions, joins)  
- Data pipeline creation & business intelligence storytelling  

---

## 🚀 Project Steps  

### 1. Set Up the Environment  
- **Tools Used**: Visual Studio Code (VS Code), Python, SQL (MySQL and PostgreSQL)  
- **Goal**: Organize a structured workspace for smooth development and data handling.  

---

### 2. Set Up Kaggle API  
- Obtain Kaggle API token (`kaggle.json`) and configure locally.  
- Download dataset with:  
  ```bash
  kaggle datasets download -d <dataset-path>
  ```  
- Store datasets in `/data` folder for easy access.  

---

### 3. Download Walmart Sales Data  
- **Source**: Kaggle – Walmart Sales Dataset  
- **Data**: ~10,000 invoices across multiple branches, categories, payment methods, and customer ratings.  
- **Storage**: Saved into `data/` folder.  

---

### 4. Install Required Libraries and Load Data  
```bash
pip install pandas numpy sqlalchemy mysql-connector-python psycopg2
```  
- Load dataset into Pandas for **exploration & cleaning**.  

---

### 5. Explore the Data  
- Used `.info()`, `.describe()`, `.head()` to understand structure.  
- Columns included: `branch`, `city`, `category`, `unit_price`, `quantity`, `total`, `profit_margin`, `payment_method`, `rating`, `date`, `time`.  

---

### 6. Data Cleaning  
- **Removed duplicates** to avoid double-counting.  
- **Handled missing values** (drop or impute).  
- **Converted types**:  
  - Dates → `datetime`  
  - Prices & totals → `float`  
- **Created consistent currency formats**.  

---

### 7. Feature Engineering  
- Created new fields:  
  - **Net Profit** = `total * profit_margin`  
  - **Sales Shift** = Morning / Afternoon / Evening (based on transaction time)  
- This enabled **profitability analysis** and **time-based sales segmentation**.  

---

### 8. Load Data into MySQL & PostgreSQL  
- Connected via **SQLAlchemy**.  
- Created tables & inserted cleaned data.  
- Verified row counts and schema consistency across both databases.  

---

### 9. SQL Analysis – Business Problems Solved  

#### 🔹 Payment Method Insights  
- E-wallets were the **most popular**, but cash still strong in some cities.  
- Digital payments correlated with **higher transaction frequency**.  

#### 🔹 Customer Experience vs Revenue  
- Higher customer ratings **did not always equal higher revenue**.  
- Some branches with average ratings **still dominated sales** (location-driven).  

#### 🔹 Profit Optimization by Category  
- **Electronics & Appliances**: high sales, low margins → candidate for repricing.  
- **Health & Beauty**: high profit margins → candidate for expansion.  

#### 🔹 Branch-Wise Product Strategy  
- Top 3 categories by branch were **different for each location**.  
- Insight: adopt **branch-specific product placement**.  

#### 🔹 Branch Competition in Cities  
- Some cities had multiple branches → **clear internal competition**.  
- Usually, **one branch dominated revenue & profit**.  
- Underperforming branches need **location-specific campaigns**.  

#### 🔹 Sales Seasonality & Customer Flow  
- **Afternoon & Evening** → peak transaction times.  
- **Weekends** → higher basket sizes.  
- Suggests **staffing & inventory adjustments** for peak hours.  

#### 🔹 Year-over-Year Performance  
- Some branches showed **declining revenue from 2022 → 2023**.  
- These require **management review & strategy refresh**.  

---

### 10. Project Publishing & Documentation  
- All queries documented in `walmart.sql`.  
- Findings summarized in `README.md`.  
- Future plans include dashboard integration.  

---

## 📊 Results & Insights  

1. **Sales Insights**  
   - Top branches by revenue differ by city.  
   - E-wallets dominate modern branches, cash dominates traditional ones.  

2. **Profitability**  
   - Not all high-sales categories are profitable.  
   - Electronics drain margin, Health & Beauty drive margin.  

3. **Customer Behavior**  
   - Peak shopping: afternoons, evenings, weekends.  
   - Ratings are **not a strong predictor of sales**.  

4. **Branch Competition**  
   - In multi-branch cities, **one branch dominates** → weaker ones must innovate.  

---

## 📌 Future Enhancements  
- Build dashboards in **Power BI/Tableau**.  
- Run **price elasticity modeling** to simulate discounts.  
- Automate **ETL pipeline** for real-time ingestion & reporting.  

---

## 🛠️ Requirements  
- Python 3.8+  
- PostgreSQL & MySQL  
- Libraries: `pandas`, `numpy`, `sqlalchemy`, `mysql-connector-python`, `psycopg2`  
- Kaggle API  

---

## 📂 Project Structure  
```
|-- data/             # Raw & cleaned datasets
|-- sql_queries/      # All SQL scripts (walmart.sql)
|-- notebooks/        # Jupyter notebooks (Python exploration)
|-- README.md         # Documentation
|-- requirements.txt  # Required Python libraries
|-- main.py           # Data loading & processing pipeline
```

---

## 📢 License  
MIT License  

---

## 🙏 Acknowledgments  
- **Dataset**: Kaggle – Walmart Sales Dataset  
- **Inspiration**: Walmart’s real-world business case studies  
