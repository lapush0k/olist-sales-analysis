-- Revenue by purchase month (delivered orders, item price only)

select strftime('%Y-%m', order_purchase_timestamp) as month, round(sum(price), 2) as revenue 
from order_items
join orders on orders.order_id = order_items.order_id
where order_status = 'delivered'
group by month
order by month;

-- Top 10 categories by revenue

select coalesce(t.product_category_name_english, p.product_category_name, 'unknown') as category, round(sum(oi.price), 2) as revenue
from order_items oi
join orders o on o.order_id = oi.order_id
join products p on p.product_id = oi.product_id
left join product_category_name_translation t on t.product_category_name = p.product_category_name
where o.order_status = 'delivered'
group by category
order by revenue desc
limit 10;

-- Average order value (delivered orders, item price only, freight excluded)

select round(sum(oi.price) / count(distinct oi.order_id), 2) as average_check
from order_items oi
join orders o on oi.order_id = o.order_id
where o.order_status = 'delivered';