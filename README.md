# Electronics Store Sales Data Analysis <br>
This project explores sales data from an electronics store, aiming to uncover key factors influencing the company's sales. The workflow includes *data cleaning, analysis, SQL queries, and visualization in Power BI* to present findings.

### Technologies Used
Oracle SQL, Power BI

In the first part of the analysis we will explore the data in general, such as ranking customers, produts and ratings by spending totals, distributions of the different data features, different relationshis between the features etc. Following this will be in depth analysis answering these following questions:

1. Are there any peaks in sales depending on the season of the purchase date
2. What are the top selling products.
3. Does gender influence spending habits in terms of amount spent.
4. Which ages spent the most money.
5. Do loyalty members spend more than non loyalty members.
6. Which products types have the highest rating and how does it correlate with sales volume.
7. Does unit price affect the number of items sold.
8. How did sales vary in terms of product type.
9. What were the most used payement methods and how much was spent.
10. What is average rating for customers who purchased add-ons and those who didn't and overall does the presence of add_ons purchased effect the sales.

### Project Workflow
#### 1. Data Import and Cleaning
The dataset was imported into Oracle SQL for preprocessing. The data contains various fields like CUSTOMER_ID, AGE, PRODUCT_ID, TOTAL_PRICE, ORDER_STATUS, PAYMENT_METHOD, and more.
Key steps in the cleaning process:
Handled missing values.
Corrected data types for numerical and date fields.
Ensured consistent format across relevant columns.
Correct erronous values.
#### 2. SQL Analysis
Several SQL queries were developed to answer critical business questions, such as:
What are the top-selling products?
What are the demographic trends (age, gender) among the customers?
Which payment methods are preferred by customers?
What factors influence the total sales (loyalty membership, shipping type, product categories)?
Views were created in SQL to simplify data transfer and visualization in Power BI.
#### 3. Power BI Dashboard
A Power BI dashboard was created to visualize the insights drawn from SQL analysis, displaying key metrics like:
Sales trends over time.
Sales by product category.
The relationship between customer demographics and sales.
Sales breakdown by product type and by season

### Key Findings
The analysis revealed several factors that influence the company's sales:

1. We can see that the sales peak in the summer and spring and are the lowest in the fall and the winter.
2. The top selling products are the smartphones SMP234 and SKU1004, the smartwatch SKU1003 and the tablet TBL245 meanwhile the lowest selling product is the smartphone SKU1001.
3. In regards to total money spent, Male customers spent approximately 1 000 000$ more then Female customers. Furthermore both genders have approximately the same average amount spent per order, meaning that Male's made more purchases.
4. The young adults (17-30) spent the least (11 876 949$) followed by the adults (29-45) (15 415 967$) then the senior group (45+), with the most (36 309 077$).
5. Loyalty members on average spend the same amount per purchase, however in total, the non loyalty members (49 976 751$) spent much more than loyalty numbers (13 625 242$) which can be due to the fact that there were 15 657 non loyalty members compared to 4 342 loyalty members.
6. Smartphones and smartwatches had the highest rating and they also had the highest total sales, meaning that generally, higher rated items sell better.
7. We find that the unit price does not effect units sold.
8. Smartphones were by far the best selling product in terms of total sales (21 516 103$) and units sold (5978). Smartwatches, laptops and tables all aproximately sold the same, less than smartphones but more than headphones which sold the least well (4 037 270$ and 2010 units sold).
9. Credit cards were the payment method used the most (5868 times) and acounted for 18 913 772$ in sales, followed by bank transfer, paypal, cash, and lastly, debit card, which was used the least (2471 times) and sold 6 736 217$
10. The average rating was approximately the same for both (precence of add ons or not), however, orders that contained add ons sold significantly more (48 184 250$) than if not (15 417 743$), meaning that the presence of add ons greatly affects the total sales.

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

