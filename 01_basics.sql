-- 1.Number of orders in each status

select order_status, count(order_status) as order_count
from orders
group by order_status
order by count(order_status) desc;

-- 2. Unique Customers by State (Top 10)

select customer_state, count(distinct customer_unique_id) as unique_customers
from customers
group by customer_state
order by unique_customers desc
limit 10;

-- 3. Orders by State (Top 10)

select customer_state, count(order_id) as count_order
from customers
join orders on customers.customer_id = orders.customer_id
where order_status = 'delivered'
group by customer_state
order by count_order desc
LIMIT 10;