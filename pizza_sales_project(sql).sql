create database Pizza_sales;

use Pizza_sales;

create table orders(
order_id int not null,
order_date date not null,
order_time time not null,
primary key (order_id)

);

create table order_details (
order_details_id int not null,
order_id int not null,
pizza_id text not null,
quantity int not null,
primary key(order_details_id)
);


-- 1. Retrieve the total number of orders

select count(order_id) as Total_orders from orders;

-- 2.Calculate the total revenue generated from pizza sales.

select 
round(sum(order_details.quantity * pizzas.price),2) as total_sales
from order_details join pizzas
on pizzas.pizza_id= order_details.pizza_id;

-- 3. Identify the highest priced pizza
SELECT pizza_types.name ,pizzas.price
FROM pizza_types
JOIN pizzas 
ON pizza_types.pizza_type_id = pizzas.pizza_type_id
ORDER BY pizzas.price DESC
limit 1
;


-- 4. Identify the most common pizza size ordered.

select quantity,count(order_details_id)
from order_details group by quantity;


select pizzas.size , count(order_details.order_details_id) as order_count
from pizzas join order_details 
on pizzas.pizza_id = order_details.pizza_id
group by pizzas.size
order by order_count desc
limit 1
;


-- 5. List the top 5 most ordered pizza types along with their quantities.

SELECT pizza_types.name, SUM(order_details.quantity) AS total_quantity
FROM order_details
JOIN pizzas ON order_details.pizza_id = pizzas.pizza_id
JOIN pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
GROUP BY pizza_types.name
ORDER BY total_quantity DESC
LIMIT 5;

-- 6.Join the necessary tables to find the total quantity of each pizza category ordered.


SELECT pizza_types.category,
sum(order_details .quantity ) as quantity
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join 
order_details 
on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.category
order by quantity desc;

-- 7.Join relevant tables to find the category-wise distribution of pizzas.

select category, count(name) from pizza_types
group by category;


-- 8. Determine the distribution of orders by hour of the day.

select hour(order_time) as hour, 
count(order_id) as order_count from orders
group by order_time
;

-- 9. Group the orders by date and calculate the average number of pizzas ordered per day.

SELECT AVG(quantity) 
FROM 
    (SELECT orders.order_date, SUM(order_details.quantity) AS quantity
     FROM orders
     JOIN order_details ON orders.order_id = order_details.order_id
     GROUP BY orders.order_date) AS Order_quantity;


-- End of Project