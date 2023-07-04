create database fortray;
use fortray;

create table sales(`Row ID` int, `Order ID` varchar(100), `Order Date` date, `Ship Date` date, `Ship Mode` varchar(100), `Customer ID` varchar(100), `Customer Name` text, Country text, City text, State text, 
Region text, `Product ID` varchar(100), Category varchar(50), SubCategory varchar(100), Product varchar(100), Sales double, Quantity double, Discount double, Profit double);  

create table returns(Returned text, `Order ID` varchar(100));

load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Return_Data.csv'
into table returns
fields terminated by ','
enclosed by '"'
lines terminated by '\r\n'
ignore 1 rows;

drop table if exists sales;

load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Orders_Data.csv'
into table sales
fields terminated by ','
enclosed by '"'
lines terminated by '\r\n'
ignore 1 rows;

describe sales;

select * from sales;
select * from returns;

alter table sales change `Row ID` Row_id int;
alter table sales change `Order ID` Order_id varchar(100);
alter table sales change `Order Date` Order_date date;
alter table sales change `Ship Mode` Ship_mode varchar(100);
alter table sales change `Customer ID` Customer_ID varchar(100);
alter table sales change `Customer Name` Customer_name text;
alter table sales change `Product ID` Product_id varchar(100);


-- 1. Sales/Profit for all the months of 2017
select year(Order_date) as Year, round(sum(sales),0) as Total_Sales, round(sum(profit),0) as Total_Profit from sales
where year(Order_date)= '2017'
group by year(Order_date);

-- 2. Categorywise Sales
select Category, round(sum(Sales),0) as Total_Sales from sales
group by Category;

-- 3. Sales by Category & Subcategory
select Category, SubCategory, round(sum(Sales),0) as Total_Sales from sales
group by Category, SubCategory;

-- 4. Sales vs Profit by state
select State,round(sum(sales),0) as Total_sales, round(sum(profit),0) as Total_profit from sales
group by State;

-- 5. Sales by Quarters for all the years by State and Category
select State, Category, year(Order_date) as Year, quarter(Order_date) as Quarter, round(sum(Sales),0) as Total_sales from sales
group by Category, State, Year , Quarter, sales;
