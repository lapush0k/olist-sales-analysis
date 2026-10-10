-- Revenue by Month (excluding canceled/unavailable orders and freight)

select strftime('%Y-%m', order_purchase_timestamp) as month, round(sum(price), 2) as revenue 
from order_items
join orders on orders.order_id = order_items.order_id
where order_status not in ('canceled', 'unavailable')
group by month
order by month;

