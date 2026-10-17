-- Month-over-month revenue change (delivered orders, 2017-01 to 2018-08)

-- with monthly as (
--     select
--         strftime('%Y-%m', o.order_purchase_timestamp) as month,
--         round(sum(oi.price), 2) as revenue
--     from order_items oi
--     join orders o on o.order_id = oi.order_id
--     where o.order_status = 'delivered'
--       and strftime('%Y-%m', o.order_purchase_timestamp) between '2017-01' and '2018-08'
--     group by month
-- ),
-- with_prev as (
--     select month, revenue,
--         LAG(revenue) over (order by month) as prev_revenue
--     from monthly
-- )
-- select month, revenue, prev_revenue,
--     round(100.0 * (revenue - prev_revenue) / prev_revenue, 1) as change_pct
-- from with_prev
-- order by month;

-- --Cumulative revenue

--  with monthly as (
--     select
--         strftime('%Y-%m', o.order_purchase_timestamp) as month,
--         round(sum(oi.price), 2) as revenue
--     from order_items oi
--     join orders o on o.order_id = oi.order_id
--     where o.order_status = 'delivered'
--       and strftime('%Y-%m', o.order_purchase_timestamp) between '2017-01' and '2018-08'
--     group by month
-- )
-- select month, revenue,
-- sum(revenue) over (order by month) as cumulative_revenue
-- from monthly
-- order by month;

--Top-3 categories by revenue in each state (delivered orders)

with category_revenue as (
   select
     c.customer_state,
     t.product_category_name_english as category,
     round(sum(oi.price), 2) as revenue
   from customers c
   join orders o on c.customer_id=o.customer_id
   join order_items oi on o.order_id=oi.order_id
   join products p on oi.product_id=p.product_id
   left join product_category_name_translation t on p.product_category_name=t.product_category_name
   where o.order_status = 'delivered'
   group by c.customer_state, t.product_category_name_english
   ),
ranked as (
   select customer_state, category, revenue,
    row_number() over (partition by customer_state order by revenue desc) as rn
   from category_revenue
)
select customer_state, category, revenue, rn
from ranked
where rn <= 3
order by customer_state , rn;