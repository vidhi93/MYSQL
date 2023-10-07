CREATE TABLE sustainable_clothing (
product_id INT PRIMARY KEY,
product_name VARCHAR(100),
category VARCHAR(50),
size VARCHAR(10),
price FLOAT
);

INSERT INTO sustainable_clothing (product_id, product_name, category, size, price)
VALUES
(1, 'Organic Cotton T-Shirt', 'Tops', 'S', 29.99),
(2, 'Recycled Denim Jeans', 'Bottoms', 'M', 79.99),
(3, 'Hemp Crop Top', 'Tops', 'L', 24.99),
(4, 'Bamboo Lounge Pants', 'Bottoms', 'XS', 49.99),
(5, 'Eco-Friendly Hoodie', 'Outerwear', 'XL', 59.99),
(6, 'Linen Button-Down Shirt', 'Tops', 'M', 39.99),
(7, 'Organic Cotton Dress', 'Dresses', 'S', 69.99),
(8, 'Sustainable Swim Shorts', 'Swimwear', 'L', 34.99),
(9, 'Recycled Polyester Jacket', 'Outerwear', 'XL', 89.99),
(10, 'Bamboo Yoga Leggings', 'Activewear', 'XS', 54.99),
(11, 'Hemp Overalls', 'Bottoms', 'M', 74.99),
(12, 'Organic Cotton Sweater', 'Tops', 'L', 49.99),
(13, 'Cork Sandals', 'Footwear', 'S', 39.99),
(14, 'Recycled Nylon Backpack', 'Accessories', 'One Size', 59.99),
(15, 'Organic Cotton Skirt', 'Bottoms', 'XS', 34.99),
(16, 'Hemp Baseball Cap', 'Accessories', 'One Size', 24.99),
(17, 'Upcycled Denim Jacket', 'Outerwear', 'M', 79.99),
(18, 'Linen Jumpsuit', 'Dresses', 'L', 69.99),
(19, 'Organic Cotton Socks', 'Accessories', 'M', 9.99),
(20, 'Bamboo Bathrobe', 'Loungewear', 'XL', 69.99);

CREATE TABLE marketing_campaigns (
campaign_id INT PRIMARY KEY,
campaign_name VARCHAR(100),
product_id INT,
start_date DATE,
end_date DATE,
FOREIGN KEY (product_id) REFERENCES sustainable_clothing (product_id)
);

INSERT INTO marketing_campaigns (campaign_id, campaign_name, product_id, start_date, end_date)
VALUES
(1, 'Summer Sale', 2, '2023-06-01', '2023-06-30'),
(2, 'New Collection Launch', 10, '2023-07-15', '2023-08-15'),
(3, 'Super Save', 7, '2023-08-20', '2023-09-15');

CREATE TABLE transactions (
transaction_id INT PRIMARY KEY,
product_id INT,
quantity INT,
purchase_date DATE,
FOREIGN KEY (product_id) REFERENCES sustainable_clothing (product_id)
);

INSERT INTO transactions (transaction_id, product_id, quantity, purchase_date)
VALUES
(1, 2, 2, '2023-06-02'),
(2, 14, 1, '2023-06-02'),
(3, 5, 2, '2023-06-05'),
(4, 2, 1, '2023-06-07'),
(5, 19, 2, '2023-06-10'),
(6, 2, 1, '2023-06-13'),
(7, 16, 1, '2023-06-13'),
(8, 10, 2, '2023-06-15'),
(9, 2, 1, '2023-06-18'),
(10, 4, 1, '2023-06-22'),
(11, 18, 2, '2023-06-26'),
(12, 2, 1, '2023-06-30'),
(13, 13, 1, '2023-06-30'),
(14, 4, 1, '2023-07-04'),
(15, 6, 2, '2023-07-08'),
(16, 15, 1, '2023-07-08'),
(17, 9, 2, '2023-07-12'),
(18, 20, 1, '2023-07-12'),
(19, 11, 1, '2023-07-16'),
(20, 10, 1, '2023-07-20'),
(21, 12, 2, '2023-07-24'),
(22, 5, 1, '2023-07-29'),
(23, 10, 1, '2023-07-29'),
(24, 10, 1, '2023-08-03'),
(25, 19, 2, '2023-08-08'),
(26, 3, 1, '2023-08-14'),
(27, 10, 1, '2023-08-14'),
(28, 16, 2, '2023-08-20'),
(29, 18, 1, '2023-08-27'),
(30, 12, 2, '2023-09-01'),
(31, 13, 1, '2023-09-05'),
(32, 7, 1, '2023-09-05'),
(33, 6, 1, '2023-09-10'),
(34, 15, 2, '2023-09-14'),
(35, 9, 1, '2023-09-14'),
(36, 11, 2, '2023-09-19'),
(37, 17, 1, '2023-09-23'),
(38, 2, 1, '2023-09-28'),
(39, 14, 1, '2023-09-28'),
(40, 5, 2, '2023-09-30'),
(41, 16, 1, '2023-10-01'),
(42, 12, 2, '2023-10-01'),
(43, 1, 1, '2023-10-01'),
(44, 7, 1, '2023-10-02'),
(45, 18, 2, '2023-10-03'),
(46, 12, 1, '2023-10-03'),
(47, 13, 1, '2023-10-04'),
(48, 4, 1, '2023-10-05'),
(49, 12, 2, '2023-10-05'),
(50, 7, 1, '2023-10-06'),
(51, 4, 2, '2023-10-08'),
(52, 8, 2, '2023-10-08'),
(53, 16, 1, '2023-10-09'),
(54, 19, 1, '2023-10-09'),
(55, 1, 1, '2023-10-10'),
(56, 18, 2, '2023-10-10'),
(57, 2, 1, '2023-10-10'),
(58, 15, 2, '2023-10-11'),
(59, 17, 2, '2023-10-13'),
(60, 13, 1, '2023-10-13'),
(61, 10, 2, '2023-10-13'),
(62, 9, 1, '2023-10-13'),
(63, 19, 2, '2023-10-13'),
(64, 20, 1, '2023-10-14');
select * from sustainable_clothing;
select * from marketing_campaigns;
select * from transactions;

/* How many transactions were completed during each marketing campaign? */

select m.campaign_name,count(t.transaction_id) as 'No of transactions'
from transactions t
join marketing_campaigns m on m.product_id = t.product_id
Group by m.campaign_name;


/* Which product had the highest sales quantity?*/
With CTE as
(select s.product_name,sum(t.quantity) as 'Total_Sales'
from sustainable_clothing s
join transactions t on t.product_id = s.product_id
Group by 1
Order by Total_Sales DESC)
select *
from CTE
where Total_Sales IN (select max(Total_Sales) from CTE);

/* What is the total revenue generated from each marketing campaign?*/
select m.campaign_name,round(sum(s.price * t.quantity),2) as 'Total Revenue'
from sustainable_clothing s
join transactions t on t.product_id = s.product_id
join marketing_campaigns m on m.product_id = t.product_id
Group by m.campaign_name;

/* What is the top-selling product category based on the total revenue generated?*/
select s.category,round(sum(s.price * t.quantity),2) as 'Total Revenue'
from sustainable_clothing s
join transactions t on t.product_id = s.product_id
Group by s.category
Order by 2 DESC
Limit 1;

/* Which products had a higher quantity sold compared to the average quantity sold?*/
select s.product_name,t.quantity
from sustainable_clothing s
join transactions t on t.product_id = s.product_id
where quantity > (select avg(quantity) from transactions);

/* What is the average revenue generated per day during the marketing campaigns?*/
select t.purchase_date,round(avg(s.price * t.quantity),2) as 'Average_Revenue'
from sustainable_clothing s 
join transactions t on t.product_id = s.product_id
join marketing_campaigns m on m.product_id = t.product_id
Group by 1
Order by 1;

/* What is the percentage contribution of each product to the total revenue?*/
with cte1 as
(select sum(s.price * t.quantity) as 'TotalRevenue'
from sustainable_clothing s
join transactions t on t.product_id = s.product_id),

cte2 as
(select s.product_name,sum(s.price * t.quantity) as  'ProdRevenue'
from sustainable_clothing s 
join transactions t on t.product_id = s.product_id
Group by 1)

select product_name,round((ProdRevenue * 100 /TotalRevenue),2) as 'Percentage'
from cte1,cte2;

/*Compare the average quantity sold during marketing campaigns to outside the marketing campaigns */

With cte1 as
(select avg(t.quantity) as 'TotalAvgQty'
from transactions t
join sustainable_clothing s on s.product_id = t.product_id
),
cte2 as
(select avg(t.quantity) as 'AvgQtyinCampaigns'
from transactions t
join marketing_campaigns m on m.product_id = t.product_id)
select TotalAvgQty,AvgQtyinCampaigns,TotalAvgQty - AvgQtyinCampaigns as 'AvgQtyOutsideCampaigns'
From cte1,cte2;

/* Compare the revenue generated by products inside the marketing campaigns to outside the campaigns*/
with cte1 as
(select round(sum(s.price * t.quantity),2) as 'TotalRevenueInsideMarketing'
from sustainable_clothing s
join transactions t on t.product_id = s.product_id
join marketing_campaigns m on m.product_id = t.product_id
),
cte2 as
(select round(sum(s.price * t.quantity),2) as 'TotalRevenue'
from sustainable_clothing s
join transactions t on t.product_id = s.product_id)

select TotalRevenue,TotalRevenueInsideMarketing,TotalRevenue-TotalRevenueInsideMarketing as 'TotalRevenueOutsideMarketing'
from cte1,cte2;

/* Rank the products by their average daily quantity sold*/
select s.product_name,avg(t.quantity) as 'AvgQty',dense_rank() over(Order by avg(t.quantity)) as 'Rank'
from sustainable_clothing s 
join transactions t on t.product_id = s.product_id
Group by 1;


