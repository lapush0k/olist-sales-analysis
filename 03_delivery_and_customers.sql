-- Average delivery time and share of late orders
-- (delivered orders with a delivery date only; late = delivered after estimated date, compared by date)

select round(avg(julianday(order_delivered_customer_date) - julianday(order_purchase_timestamp)), 1) as avg_delivery_days,
round(100.0 * avg(case when date(order_delivered_customer_date) > date(order_estimated_delivery_date) then 1.0 else 0 end), 1) as late_pct
from orders
where order_status = 'delivered'
and order_delivered_customer_date is not null
and order_delivered_customer_date != '';