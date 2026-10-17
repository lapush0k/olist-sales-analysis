-- Average delivery time and share of late orders
-- (delivered orders with a delivery date only; late = delivered after estimated date, compared by date)

select round(avg(julianday(order_delivered_customer_date) - julianday(order_purchase_timestamp)), 1) as avg_delivery_days,
round(100.0 * avg(case when date(order_delivered_customer_date) > date(order_estimated_delivery_date) then 1.0 else 0 end), 1) as late_pct
from orders
where order_status = 'delivered'
and order_delivered_customer_date is not null;

-- Share of customers with more than one order
with orders_per_customer as (
select c.customer_unique_id, count(*) as orders_cnt
from orders o
join customers c on c.customer_id = o.customer_id
where o.order_status = 'delivered'
group by c.customer_unique_id
)
select count(*) as total_customers,
sum(case when orders_cnt > 1 then 1 else 0 end) as repeat_customers,
round(100.0 * avg(case when orders_cnt > 1 then 1.0 else 0 end), 2) as repeat_pct
from orders_per_customer;