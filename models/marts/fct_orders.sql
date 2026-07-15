with orders as (

    select * from {{ ref('stg_orders') }}

),

customers as (

    select * from {{ ref('stg_customers') }}

)

select
    orders.order_id,
    orders.customer_id,
    customers.customer_name,
    orders.order_date,
    orders.order_status,
    1 as order_count
from orders
left join customers
    on orders.customer_id = customers.customer_id
