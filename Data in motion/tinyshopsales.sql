Drop table customers;
CREATE TABLE customers (
    customer_id integer PRIMARY KEY,
    first_name varchar(100),
    last_name varchar(100),
    email varchar(100)
);

CREATE TABLE products (
    product_id integer PRIMARY KEY,
    product_name varchar(100),
    price decimal
);

CREATE TABLE orders (
    order_id integer PRIMARY KEY,
    customer_id integer,
    order_date date
);

CREATE TABLE order_items (
    order_id integer,
    product_id integer,
    quantity integer
);

INSERT INTO customers (customer_id, first_name, last_name, email) VALUES
(1, 'John', 'Doe', 'johndoe@email.com'),
(2, 'Jane', 'Smith', 'janesmith@email.com'),
(3, 'Bob', 'Johnson', 'bobjohnson@email.com'),
(4, 'Alice', 'Brown', 'alicebrown@email.com'),
(5, 'Charlie', 'Davis', 'charliedavis@email.com'),
(6, 'Eva', 'Fisher', 'evafisher@email.com'),
(7, 'George', 'Harris', 'georgeharris@email.com'),
(8, 'Ivy', 'Jones', 'ivyjones@email.com'),
(9, 'Kevin', 'Miller', 'kevinmiller@email.com'),
(10, 'Lily', 'Nelson', 'lilynelson@email.com'),
(11, 'Oliver', 'Patterson', 'oliverpatterson@email.com'),
(12, 'Quinn', 'Roberts', 'quinnroberts@email.com'),
(13, 'Sophia', 'Thomas', 'sophiathomas@email.com');

INSERT INTO products (product_id, product_name, price) VALUES
(1, 'Product A', 10.00),
(2, 'Product B', 15.00),
(3, 'Product C', 20.00),
(4, 'Product D', 25.00),
(5, 'Product E', 30.00),
(6, 'Product F', 35.00),
(7, 'Product G', 40.00),
(8, 'Product H', 45.00),
(9, 'Product I', 50.00),
(10, 'Product J', 55.00),
(11, 'Product K', 60.00),
(12, 'Product L', 65.00),
(13, 'Product M', 70.00);

INSERT INTO orders (order_id, customer_id, order_date) VALUES
(1, 1, '2023-05-01'),
(2, 2, '2023-05-02'),
(3, 3, '2023-05-03'),
(4, 1, '2023-05-04'),
(5, 2, '2023-05-05'),
(6, 3, '2023-05-06'),
(7, 4, '2023-05-07'),
(8, 5, '2023-05-08'),
(9, 6, '2023-05-09'),
(10, 7, '2023-05-10'),
(11, 8, '2023-05-11'),
(12, 9, '2023-05-12'),
(13, 10, '2023-05-13'),
(14, 11, '2023-05-14'),
(15, 12, '2023-05-15'),
(16, 13, '2023-05-16');

INSERT INTO order_items (order_id, product_id, quantity) VALUES
(1, 1, 2),
(1, 2, 1),
(2, 2, 1),
(2, 3, 3),
(3, 1, 1),
(3, 3, 2),
(4, 2, 4),
(4, 3, 1),
(5, 1, 1),
(5, 3, 2),
(6, 2, 3),
(6, 1, 1),
(7, 4, 1),
(7, 5, 2),
(8, 6, 3),
(8, 7, 1),
(9, 8, 2),
(9, 9, 1),
(10, 10, 3),
(10, 11, 2),
(11, 12, 1),
(11, 13, 3),
(12, 4, 2),
(12, 5, 1),
(13, 6, 3),
(13, 7, 2),
(14, 8, 1),
(14, 9, 2),
(15, 10, 3),
(15, 11, 1),
(16, 12, 2),
(16, 13, 3);

select * from customers;
select * from products;
select * from orders;
select * from order_items;

/* Which product has the highest price? Only return a single row.*/
select product_name,price
from products
order by price desc
limit 1;

/* Which customer has made the most orders?*/

with cte as
(
select customer_id,count(order_id) as 'TotalOrders'
from orders
Group by customer_id
)
select customer_id,TotalOrders
from cte
where TotalOrders = (select max(TotalOrders)from cte);

/* What’s the total revenue per product?*/
with cte as
(
select p.product_name,(p.price *  oi.quantity) as totalproducts
from products p
join order_items oi
on p.product_id = oi.product_id
)
select product_name,sum(totalproducts) as maxproduct
from cte
Group by product_name
Order by product_name;

/*Find the day with the highest revenue. */

select o.order_date,dayname(order_date) as day,sum(oi.quantity * p.price) as totalrevenue
from orders o
join order_items oi
on o.order_id = oi.order_id 
join products p 
on p.product_id = oi.product_id
Group by o.order_date
Order by totalrevenue DESC
Limit 1;

/* Find the first order (by date) for each customer.*/
with cte as
(
select c.customer_id,concat(c.first_name, ' ',c.last_name) as customer_name,o.order_date,row_number() over(partition by customer_id) as rnk
from customers c
join orders o
on c.customer_id = o.customer_id
)
select customer_id,customer_name,order_date
from cte
where rnk = 1;

/* Find the top 3 customers who have ordered the most distinct products*/
select count(distinct(p.product_name)) as totalcount,c.customer_id,concat(first_name,' ',last_name) as customer_name
from customers c 
join orders o 
on o.customer_id= c.customer_id
join order_items oi 
on oi.order_id = o.order_id
join products p 
on p.product_id = oi.product_id
Group by 2,3
Order by customer_id
limit 3;

/* Which product has been bought the least in terms of quantity?*/
select p.product_name,sum(oi.quantity) as leastqty
from order_items oi
join products p 
on p.product_id= oi.product_id
Group by 1
Order by leastqty;

/* What is the median order total?*/
with totalorder as
(
select o.order_id,sum(p.price * oi.quantity) as totalrevenue
from products p
join order_items oi
on p.product_id = oi.product_id
join orders o 
on o.order_id = oi.order_id
Group by 1
)
select avg(totalrevenue) as median
from totalorder;

/* For each order, determine if it was ‘Expensive’ (total over 300), ‘Affordable’ (total over 100), or ‘Cheap’.*/
with cte as
(
select o.order_id,sum(p.price * oi.quantity) as Total
from orders o
join order_items oi  on oi.order_id = o.order_id
join products p on p.product_id = oi.product_id
Group by 1
)
select order_id,case when Total > 300 then 'Expensive'
			         when Total between 100 and 300 then 'Affordable'
                     else 'Cheap'
                     end as Price_Tag
from cte;

/*Find customers who have ordered the product with the highest price. */
select concat(first_name,' ',last_name) as customer_name,sum(oi.quantity * p.price) as TotalPrice
from customers c
join orders o on o.customer_id = c.customer_id
join order_items oi on oi.order_id = o.order_id
join products p on p.product_id = oi.product_id
Group by 1
Order by TotalPrice DESC
Limit 1;

