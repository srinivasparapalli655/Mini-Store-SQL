CREATE DATABASE IF NOT EXISTS MiniStoreDB;
USE MiniStoreDB;

CREATE TABLE customers (
    Customer_ID VARCHAR(10) PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Email VARCHAR(255),
    City VARCHAR(100),
    Registration_Date DATE,
    Age INT CHECK (Age > 0 AND Age < 120),
    Total_Spent DECIMAL(10,2) CHECK (Total_Spent >= 0)
);

DROP TABLE IF EXISTS products;

CREATE TABLE products (
    Product_ID VARCHAR(10) PRIMARY KEY,
    Product_Name VARCHAR(255) NOT NULL,
    Category VARCHAR(100),
    Supplier VARCHAR(100),
    Price DECIMAL(10,2) CHECK (Price > 0),
    Quantity_In_Stock INT CHECK (Quantity_In_Stock >= 0),
    Reorder_Level INT,
    Rating DECIMAL(3,1) CHECK (Rating >= 0 AND Rating <= 5)
);

CREATE TABLE orders (
    Order_ID VARCHAR(10) PRIMARY KEY,
    Customer_ID VARCHAR(10) NOT NULL,
    Order_Date DATE,
    Payment_Method ENUM('Cash','Credit','Installment'),
    Employee_ID VARCHAR(10),
    Total_Amount DECIMAL(10,2) CHECK (Total_Amount >= 0),
    Discount DECIMAL(10,2) CHECK (Discount >= 0),
    FOREIGN KEY (Customer_ID) REFERENCES customers(Customer_ID)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE order_items (
    Order_Item_ID VARCHAR(10) PRIMARY KEY,
    Order_ID VARCHAR(10) NOT NULL,
    Product_ID VARCHAR(10) NOT NULL,
    Quantity INT CHECK (Quantity > 0),
    Unit_Price DECIMAL(10,2) CHECK (Unit_Price > 0),
    Total_Price DECIMAL(10,2) CHECK (Total_Price > 0),
    FOREIGN KEY (Order_ID) REFERENCES orders(Order_ID)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (Product_ID) REFERENCES products(Product_ID)
        ON UPDATE CASCADE ON DELETE CASCADE
);


-- List all customers who have spent more than 10,000.
select name from customers where total_spent>10000;

-- Retrieve all products in the “Furniture” category.
select product_name from products where category="furniture";

-- Show all orders placed in 2025.
select *from orders where year(order_date)=2025;

-- Find products with a rating greater than 4.
select product_name from products where rating>4;

-- Calculate total revenue per product.
select product_name,sum(total_price) from products join order_items on order_items.product_id=products.product_id group by product_name;

-- Find the number of orders per customer.
select name,sum(total_amount) from customers join orders on orders.customer_id=customers.customer_id group by name;

-- Find the highest-spending customer.
select name,total_spent from customers order by total_spent desc limit 1;

-- Find average quantity sold per product.
select product_name,avg(quantity) from products join order_items on order_items.product_id=products.product_id group by product_name;

-- Show order details including customer name, product name, and quantity.
select name,product_name,quantity from customer join orders on orders.customer_id=customers.customer_id join order_items on order_items.order_id=orders.order_id join products on products.product_id=order_items.product_id;

-- Find total revenue per customer using JOIN.
select name,orders.customer_id,sum(total_amount) from customers join orders on orders.customer_id=customers.customer_id group by name,customer_id;

-- List products never ordered.
select product_name,quantity from products join order_items on order_items.product_id=products.product_id where quantity=null group by product_name,quantity;



-- Find customers who ordered products from "DellStore".
select name,supplier from customers join orders on orders.customer_id=customers.customer_id join order_items on order_items.order_id=orders.order_id join products on products.product_id=order_items.product_id where supplier="dellstore";

-- List orders with total amount > 5000.
select product_name,total_amount from products join order_items on order_items.product_id=products.product_id join orders on order_items.order_id=orders.order_id where total_amount>5000;

-- Show total revenue per product category having revenue > 10,000.
select product_name,sum(total_price) from products join order_items on order_items.product_id=products.product_id group by product_name having sum(total_price)>10000;

-- Categorize customers as 'High Spender' (>10000) or 'Low Spender'.
select name,total_spent, case when total_spent>10000 then "high spender" else "low spender" end as "spender category" from customers group by name,total_spent;

-- Rank products by total quantity sold.
select product_name,products.product_id,sum(quantity),rank() over(order by sum(quantity) desc) as rank_no from products join order_items on products.product_id=order_items.product_id group by products.product_id,quantity;

-- List top 5 customers based on total spending.
select name,sum(total_spent) from customers group by name order by sum(total_spent) desc limit 5;

-- Find the most popular category (highest quantity sold).
select product_name,sum(quantity),products.product_id from products join order_items on products.product_id=order_items.product_id group by product_name,product_id order by sum(quantity) desc limit 1;

