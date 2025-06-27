create database pizzahut;

-- retrive the total numbers of orders placed.
select count(order_id) as total_orders from orders;

-- calculate the total revenue generated from pizza sales.
select 
round(sum(orders_details.quantity * pizzas.price),2) as total_sales
from orders_details join pizzas 
on pizzas.pizza_id = orders_details.pizza_id;

-- Identify the highest-priced pizza.
select pizza_types.name, pizzas.price
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
order by pizzas.price desc limit 1;

-- identify most common pizza size orderd
select pizzas.size, count(orders_details.order_details_id) as order_count
from pizzas join orders_details
on pizzas.pizza_id = orders_details.pizza_id
group by pizzas.size order by order_count desc;

-- list the top 5 most ordered pizza types along with their quantity
select pizza_types.name, 
sum(orders_details.quantity) as quantity
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join orders_details
on orders_details.pizza_id = pizzas.pizza_id
group by pizza_types.name order by quantity desc limit 5;

-- revenue by pizza category
SELECT 
    pizza_types.category,
    ROUND(SUM(orders_details.quantity * pizzas.price), 2) AS category_revenue
FROM 
    orders_details
JOIN pizzas ON orders_details.pizza_id = pizzas.pizza_id
JOIN pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
GROUP BY 
    pizza_types.category
ORDER BY 
    category_revenue DESC;
    
-- Monthly revenue
SELECT 
    DATE_FORMAT(orders.order_date, '%Y-%m') AS month,
    ROUND(SUM(orders_details.quantity * pizzas.price), 2) AS monthly_revenue
FROM 
    orders
JOIN orders_details ON orders.order_id = orders_details.order_id
JOIN pizzas ON orders_details.pizza_id = pizzas.pizza_id
GROUP BY 
    month
ORDER BY 
    month;