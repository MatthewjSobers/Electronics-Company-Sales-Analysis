Electronics Store Sales Data Analysis
This project explores sales data from an electronics store, aiming to uncover key factors influencing the company's sales. The workflow includes data cleaning, analysis, SQL queries, and visualization in Power BI to present findings.

In the first part of the analysis we will explore the data in general, such as ranking customers, produts and ratings by spending totals, distributions of the different data features, different relationshis between the features etc. Following this will be in depth analysis answering these following questions:

1. Which customer spent the most for each product type.
2. What are the top selling products.
3. Does gender influence spending habits in terms of amount spent.
4. Which ages spent the most money.
5. Do loyalty members spend more than non loyalty members.
6. Which products types have the highest rating and how does it correlate with sales volume.
7. Does unit price affect the number of items sold.
8. How did sales vary in terms of product type.
9. What were the most used payement methods and how much was spent.
10. What is average rating for customers who purchased add-ons and those who didn't and overall does the presence of add_ons purchased effect the sales.
11. Are there any peaks in sales depending on the season of the purchase date

Project Workflow
1. Data Import and Cleaning
The dataset was imported into Oracle SQL for preprocessing. The data contains various fields like CUSTOMER_ID, AGE, PRODUCT_ID, TOTAL_PRICE, ORDER_STATUS, PAYMENT_METHOD, and more.
Key steps in the cleaning process:
Handled missing values.
Corrected data types for numerical and date fields.
Ensured consistent format across relevant columns.
Correct erronous values.
3. SQL Analysis
Several SQL queries were developed to answer critical business questions, such as:
What are the top-selling products?
What are the demographic trends (age, gender) among the customers?
Which payment methods are preferred by customers?
What factors influence the total sales (loyalty membership, shipping type, product categories)?
Views were created in SQL to simplify data transfer and visualization in Power BI.
4. Power BI Dashboard
A Power BI dashboard was created to visualize the insights drawn from SQL analysis, displaying key metrics like:
Sales trends over time.
Sales by product category.
The relationship between customer demographics and sales.
Sales breakdown by product type and by season


Key Findings
The analysis revealed several factors that influence the company's sales:

Product types and loyalty membership are strong predictors of high sales.
Age groups between 25-40 are the most frequent purchasers.
Shipping type and payment method also impact overall sales, with express shipping and digital payment methods contributing significantly.
Tools Used
SQL (Oracle SQL Developer): Data cleaning, preprocessing, and analysis.
Power BI: Data visualization and dashboard creation.
How to Use This Repository
Clone the repository to your local machine.
Open the SQL files to explore the queries used for analysis.
Review the Power BI dashboard files to explore visualizations and insights.
Feel free to fork this repository or open an issue if you have any questions or suggestions.

