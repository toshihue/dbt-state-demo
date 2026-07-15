select
    customer_id,
    customer_name,
    min(order_date) as first_order_date,
    max(order_date) as most_recent_order_date,
    count(*) as order_count,
    count_if(order_status = 'completed') as completed_order_count
from {{ ref('fct_orders') }}
group by
    customer_id,
    customer_name
