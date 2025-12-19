# Mini-Store-SQL
📌 Project Overview This project involves the design and implementation of a relational database for a retail "MiniStore" system. The goal was to create a robust structure to manage customer relationships, inventory tracking, and sales transactions while extracting meaningful business insights through complex SQL queries.

🏗️ Database Schema The database, MiniStoreDB, consists of four primary tables:

customers: Stores demographic information, registration dates, and lifetime spending.

products: Manages inventory details, including suppliers, stock levels, reorder points, and ratings.

orders: Records transaction headers, including payment methods (Cash, Credit, Installment) and total amounts.

order_items: A bridge table containing line-item details for every product within an order.

🛠️ Key Features & SQL Techniques Data Integrity: Used PRIMARY KEY, FOREIGN KEY (with CASCADE actions), and CHECK constraints to ensure data validity.

Advanced Aggregations: Calculated total revenue per product and average quantities sold using SUM, AVG, and GROUP BY.

Business Logic: Categorized customers into "High Spender" and "Low Spender" tiers using CASE statements.

Window Functions: Utilized the RANK() function to order products by sales popularity.

Relational Joins: Performed multi-table joins to connect customers to specific products and suppliers like "DellStore".

📊 Business Insights Derived The included SQL script provides answers to critical business questions, such as:

Who are the top 5 highest-spending customers?

Which products have never been ordered?

What is the most popular product category by volume?

Which product categories generate more than 10,000 in revenue?

What were the order trends for the year 2025?

🚀 How to Use Ensure you have a MySQL-compatible environment installed.

Run the ministore project.sql script to create the database and tables.

Execute the provided query section to see the data analysis in action.
