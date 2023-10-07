CREATE TABLE runners (
  runner_id INTEGER,
  registration_date DATE
);

INSERT INTO runners
  (runner_id, registration_date)
VALUES
  (1, '2021-01-01'),
  (2, '2021-01-03'),
  (3, '2021-01-08'),
  (4, '2021-01-15');
  
  CREATE TABLE customer_orders (
  order_id INTEGER,
  customer_id INTEGER,
  pizza_id INTEGER,
  exclusions VARCHAR(4),
  extras VARCHAR(4),
  order_time TIMESTAMP
);

INSERT INTO customer_orders
  (order_id, customer_id, pizza_id, exclusions, extras, order_time)
VALUES
  ('1', '101', '1', '', '', '2020-01-01 18:05:02'),
  ('2', '101', '1', '', '', '2020-01-01 19:00:52'),
  ('3', '102', '1', '', '', '2020-01-02 23:51:23'),
  ('3', '102', '2', '', NULL, '2020-01-02 23:51:23'),
  ('4', '103', '1', '4', '', '2020-01-04 13:23:46'),
  ('4', '103', '1', '4', '', '2020-01-04 13:23:46'),
  ('4', '103', '2', '4', '', '2020-01-04 13:23:46'),
  ('5', '104', '1', 'null', '1', '2020-01-08 21:00:29'),
  ('6', '101', '2', 'null', 'null', '2020-01-08 21:03:13'),
  ('7', '105', '2', 'null', '1', '2020-01-08 21:20:29'),
  ('8', '102', '1', 'null', 'null', '2020-01-09 23:54:33'),
  ('9', '103', '1', '4', '1, 5', '2020-01-10 11:22:59'),
  ('10', '104', '1', 'null', 'null', '2020-01-11 18:34:49'),
  ('10', '104', '1', '2, 6', '1, 4', '2020-01-11 18:34:49');

CREATE TABLE runner_orders (
  order_id INTEGER,
  runner_id INTEGER,
  pickup_time VARCHAR(19),
  distance VARCHAR(7),
  duration VARCHAR(10),
  cancellation VARCHAR(23)
);

INSERT INTO runner_orders
  (order_id, runner_id, pickup_time, distance, duration, cancellation)
VALUES
  ('1', '1', '2020-01-01 18:15:34', '20km', '32 minutes', ''),
  ('2', '1', '2020-01-01 19:10:54', '20km', '27 minutes', ''),
  ('3', '1', '2020-01-03 00:12:37', '13.4km', '20 mins', NULL),
  ('4', '2', '2020-01-04 13:53:03', '23.4', '40', NULL),
  ('5', '3', '2020-01-08 21:10:57', '10', '15', NULL),
  ('6', '3', 'null', 'null', 'null', 'Restaurant Cancellation'),
  ('7', '2', '2020-01-08 21:30:45', '25km', '25mins', 'null'),
  ('8', '2', '2020-01-10 00:15:02', '23.4 km', '15 minute', 'null'),
  ('9', '2', 'null', 'null', 'null', 'Customer Cancellation'),
  ('10', '1', '2020-01-11 18:50:20', '10km', '10minutes', 'null');
  
  CREATE TABLE pizza_names (
  pizza_id INTEGER,
  pizza_name TEXT
);

INSERT INTO pizza_names
  (pizza_id, pizza_name)
VALUES
  (1, 'Meatlovers'),
  (2, 'Vegetarian');
  
  CREATE TABLE pizza_recipes (
  pizza_id INTEGER,
  toppings TEXT
);

INSERT INTO pizza_recipes
  (pizza_id, toppings)
VALUES
  (1, '1, 2, 3, 4, 5, 6, 8, 10'),
  (2, '4, 6, 7, 9, 11, 12');
  
  CREATE TABLE pizza_toppings (
  topping_id INTEGER,
  topping_name TEXT
);

INSERT INTO pizza_toppings
  (topping_id, topping_name)
VALUES
  (1, 'Bacon'),
  (2, 'BBQ Sauce'),
  (3, 'Beef'),
  (4, 'Cheese'),
  (5, 'Chicken'),
  (6, 'Mushrooms'),
  (7, 'Onions'),
  (8, 'Pepperoni'),
  (9, 'Peppers'),
  (10, 'Salami'),
  (11, 'Tomatoes'),
  (12, 'Tomato Sauce');

select * from runner_orders;
select * from runners;
select * from customer_orders;
select * from pizza_names;
select * from pizza_recipes;
select * from pizza_toppings;

                                     /*  Data Cleaning  */
 /*1. Changing  all NaN and blank to NULL*/
 /* runner_orders*/
select * from runner_orders;
Drop table runner_orders_temp;

Drop table if exists runner_orders_temp;
Create temporary table runner_orders_temp as 
 select order_id,runner_id,
 case when pickup_time = 'null' then NULL
      else pickup_time
      end as pickup_time,
CASE when distance = 'null' then NULL
     WHEN distance LIKE '%km' THEN trim('km' from distance)
	 else distance
      end as distance,
case when duration like '%minutes' then Trim('minutes' from duration)
     when duration like '%mins' then Trim('mins' from duration)
     when duration like '%minute' then Trim('minute' from duration)
     when duration = 'null' then NULL
     else duration
     end as duration,
     Case when cancellation ='NaN' or cancellation = 'null' then NULL
     when cancellation = '' then NULL
     else cancellation
     end as cancellation
     from runner_orders;
     
     select * from runner_orders_temp;
     
     /*1. Changing  all NaN and blank to NULL*/
 /* customer_orders*/
 
 select * from customer_orders;
 Drop table customer_orders_temp;
 
 Drop table if exists customer_orders_temp;
  create temporary table customer_orders_temp as
 select order_id,customer_id,pizza_id,
 case when exclusions = '' then null
 when exclusions = 'null' then null
 else exclusions
 end as exclusions,
 case when extras = '' then null
 when extras = 'null' then null
 else extras
 end as extras,order_time
 from customer_orders;
 
 select * from customer_orders_temp;
 
 ALTER TABLE runner_orders_temp 
modify COLUMN pickup_time timestamp,
modify column distance numeric,
modify column duration integer;

select * from runner_orders_temp;


/*                A. Pizza Metrics                     */

/* How many pizzas were ordered?*/
select count(order_id)
from customer_orders;
  
  /* How many unique customer orders were made?*/
  select count(distinct(customer_id))
  from customer_orders;
  
  /* How many successful orders were delivered by each runner?*/
  select runner_id,count(runner_id) as 'Total Successful Orders'
  from runner_orders_temp
  where cancellation is NULL
  Group by runner_id;
  
  /* How many of each type of pizza was delivered?*/
  select p.pizza_name,count(p.pizza_id) as 'Delivered'
  from pizza_names p
  join customer_orders_temp c on c.pizza_id = p.pizza_id
  join runner_orders_temp r on r.order_id = c.order_id
  where cancellation is null
  Group by p.pizza_name;
  
  /*How many Vegetarian and Meatlovers were ordered by each customer? */
  select p.pizza_name,c.customer_id,count(c.customer_id) as 'Total Customers Ordered'
  from pizza_names p 
  join customer_orders_temp c on c.pizza_id = p.pizza_id
  Group by p.pizza_name,c.customer_id
  Order by c.customer_id;
  
  /*What was the maximum number of pizzas delivered in a single order?*/
  select r.order_id,count(c.pizza_id) as 'No of Pizzas Delivered'
  from customer_orders_temp c 
  join runner_orders_temp r on r.order_id = c.order_id
  where cancellation is null
  Group by r.order_id
  Order by count(c.pizza_id) DESC
  Limit 1;
  
  /* For each customer, how many delivered pizzas had at least 1 change and how many had no changes?*/
  select c.customer_id,
  count(case when exclusions != '' or extras != '' then 1
       End )as changed,
count(Case when exclusions is null and extras is null then 1
       end) as unchanged
  from customer_orders_temp c 
  join runner_orders_temp r on r.order_id = c.order_id
  where cancellation is NULL
  Group by c.customer_id
  Order by c.customer_id;
  
  /*How many pizzas were delivered that had both exclusions and extras? */
  select 
  count(case when exclusions != '' and extras != '' then 1
       end) as ExclusionsExtras
       from customer_orders_temp c 
       join runner_orders_temp r on r.order_id = c.order_id
       where cancellation is NULL;
       
/* What was the total volume of pizzas ordered for each hour of the day?*/
select count(pizza_id),hour(order_time)
from customer_orders_temp
Group by hour(order_time);

/* What was the volume of orders for each day of the week?*/
select count(order_id),dayname(order_time)
from customer_orders_temp
Group by dayname(order_time);

                              /* B. Runner and Customer Experience*/

/* How many runners signed up for each 1 week period? (i.e. week starts 2021-01-01)*/
SELECT count(runner_id),week(registration_date + 3) as weekcount
from runners
Group by weekcount;

/* What was the average time in minutes it took for each runner to arrive at the Pizza Runner HQ to pickup the order?*/
with min_cte as(
select r.runner_id,abs(timestampdiff(minute,r.pickup_time, c.order_time)) as'AvgTimeTaken'
from customer_orders_temp c 
join runner_orders_temp r on r.order_id = c.order_id)
select runner_id,round(avg(AvgTimeTaken),2) from min_cte
Group by runner_id;

/*Is there any relationship between the number of pizzas and how long the order takes to prepare? */
	with ctemin as
	(select count(c.order_id) as totalpizzas,time(r.pickup_time-c.order_time) as 'TimeTaken'
	from customer_orders_temp c 
	join runner_orders_temp r on r.order_id =c.order_id
	Group by c.order_id,TimeTaken
	Order by count(c.order_id))
	select totalpizzas,time(avg(TimeTaken))
	from ctemin
    Group by totalpizzas;
    
    /* What was the average distance travelled for each customer?*/
    select c.customer_id,round(avg(r.distance),2) as avgdistance
    from customer_orders_temp c
    join runner_orders_temp r on r.order_id = c.order_id
    Group by c.customer_id;
    
    /*What was the difference between the longest and shortest delivery times for all orders?*/
    select max(duration) - min(duration) as deliverytimediff
    from runner_orders_temp;
    
      
/* What was the average speed for each runner for each delivery and do you notice any trend for these values?*/
select runner_id,order_id,round(avg(distance/duration * 60),2) as avgspeed
from runner_orders_temp
Group by runner_id,order_id
Order by runner_id;

/* What is the successful delivery percentage for each runner? */
with ctecount as (
    select runner_id,count(runner_id) as successfuldelivery,sum(runner_id) as totaldelivery
    from runner_orders_temp
    where cancellation is null
    Group by runner_id)
	select runner_id,(successfuldelivery*100/totaldelivery) as percent
    from ctecount
    Group by runner_id;
    
    /*                    C. Ingredient Optimisation                            */
    /*What are the standard ingredients for each pizza?*/
WITH RECURSIVE SplitStrings AS (
  SELECT
    pizza_id,
    SUBSTRING_INDEX(toppings, ',', 1) AS topping_id,
    SUBSTRING(toppings, LENGTH(SUBSTRING_INDEX(toppings, ',', 1)) + 2) AS remaining_toppings
  FROM pizza_recipes
  WHERE LENGTH(toppings) > 0
  UNION ALL
  SELECT
    pizza_id,
    SUBSTRING_INDEX(remaining_toppings, ',', 1) AS topping_id,
    SUBSTRING(remaining_toppings, LENGTH(SUBSTRING_INDEX(remaining_toppings, ',', 1)) + 2) AS remaining_toppings
  FROM SplitStrings
  WHERE LENGTH(remaining_toppings) > 0
)
SELECT
  ss.pizza_id,
  GROUP_CONCAT(pt.topping_name ORDER BY pt.topping_id SEPARATOR ', ') AS topping_names
FROM SplitStrings ss
JOIN pizza_toppings pt ON pt.topping_id = ss.topping_id
GROUP BY ss.pizza_id;

/* What was the most commonly added extra?*/
with recursive spiltextras as (
select pizza_id,
substring_index(extras,',',1) as extras,
substring(extras,length(substring_index(extras,',',1))+2) as remainingtoppings
from customer_orders_temp
where length(extras) > 0
Union All
select pizza_id,
substring_index(remainingtoppings,',',1) as extras,
substring(remainingtoppings,length(substring_index(remainingtoppings,',',1)) + 2) as remainingtoppings
from spiltextras 
where length(remainingtoppings)>0
)
select t.topping_name,count(topping_name)
from spiltextras se
join pizza_toppings t on t.topping_id = se.extras
Group by t.topping_name;

/*What was the most common exclusion? */
with recursive spiltexclusions as (
select pizza_id,
substring_index(exclusions,',',1) as exclusions,
substring(exclusions,length(substring_index(exclusions,',',1)) + 2) as remainingtoppings
from customer_orders_temp
where length(exclusions) > 0
Union all
select pizza_id,
substring_index(remainingtoppings,',',1) as exclusions,
substring(remainingtoppings,length(substring_index(remainingtoppings,',',1)) + 2) as remainingtoppings
from spiltexclusions
where length(remainingtoppings) > 0
)
select t.topping_name,count(topping_name)
from spiltexclusions se
join pizza_toppings t on t.topping_id = se.exclusions
Group by t.topping_name;

/* Generate an order item for each record in the customers_orders table in the format of one of the following:
Meat Lovers
Meat Lovers - Exclude Beef
Meat Lovers - Extra Bacon
Meat Lovers - Exclude Cheese, Bacon - Extra Mushroom, Peppers */

SELECT
  c.order_id,
  CONCAT(
    p.pizza_name,
    IF(c.exclusions != '', CONCAT(' - Exclude ', GROUP_CONCAT(pt.topping_name ORDER BY pt.topping_id SEPARATOR ', ')), ''),
    IF(c.extras != '', CONCAT(' - Extra ', GROUP_CONCAT(pt.topping_name ORDER BY pt.topping_id SEPARATOR ', ')), '')
  ) AS order_item
FROM customer_orders c
JOIN pizza_names p ON c.pizza_id = p.pizza_id
LEFT JOIN pizza_toppings pt ON FIND_IN_SET(pt.topping_id, c.exclusions) > 0 OR FIND_IN_SET(pt.topping_id, c.extras) > 0
GROUP BY c.order_id, p.pizza_name, c.exclusions, c.extras;

/*  Generate an alphabetically ordered comma separated ingredient list for each pizza order from the customer_orders table and add a 2x in front of any relevant ingredients
For example: "Meat Lovers: 2xBacon, Beef, ... , Salami"*/
SELECT
    c.order_id,
    CONCAT(
        p.pizza_name,
        ': ',
        GROUP_CONCAT(
            CASE
                WHEN pt.topping_id IS NOT NULL THEN
                    CONCAT(
                        CASE
                            WHEN c.exclusions LIKE CONCAT('%', pt.topping_id, '%') THEN '2x'
                            ELSE ''
                        END,
                        pt.topping_name
                    )
            END
            ORDER BY pt.topping_name
            SEPARATOR ', '
        )
    ) AS ingredient_list
FROM customer_orders c
JOIN pizza_names p ON c.pizza_id = p.pizza_id
LEFT JOIN pizza_recipes pr ON c.pizza_id = pr.pizza_id
LEFT JOIN pizza_toppings pt ON FIND_IN_SET(pt.topping_id, pr.toppings) > 0 OR c.exclusions LIKE CONCAT('%', pt.topping_id, '%')
GROUP BY c.order_id, p.pizza_name
ORDER BY c.order_id;
