-- Revenue by Month (excluding canceled/unavailable orders and freight)

select strftime('%Y-%m', order_purchase_timestamp) as month, round(sum(price), 2) as revenue 
from order_items
join orders on orders.order_id = order_items.order_id
where order_status not in ('canceled', 'unavailable')
group by month
order by month;

--Top 10 categories by revenue (excluding canceled/unavailable orders, excluding freight)
select coalesce(t.product_category_name_english, p.product_category_name, 'unknown') as category, round(sum(oi.price), 2) as revenue
from order_items oi
join orders o on o.order_id = oi.order_id
join products p on p.product_id = oi.product_id
left join product_category_name_translation t on t.product_category_name = p.product_category_name
where o.order_status not in ('canceled', 'unavailable')
group by category
order by revenue desc
limit 10;
