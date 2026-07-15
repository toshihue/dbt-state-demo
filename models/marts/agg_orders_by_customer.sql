with orders as (

    select * from {{ ref('fct_orders') }}

),

customers as (

    select * from {{ ref('dim_customers') }}

),

orders_by_customer as (

    select
        customer_id,
        min(order_date) as first_order_date,
        max(order_date) as most_recent_order_date,
        count(*) as order_count,
        count_if(order_status = 'completed') as completed_order_count
    from orders
    group by 1

)

select
    orders_by_customer.customer_id,
    customers.customer_name,
    orders_by_customer.first_order_date,
    orders_by_customer.most_recent_order_date,
    orders_by_customer.order_count,
    orders_by_customer.completed_order_count
from orders_by_customer
left join customers
    on orders_by_customer.customer_id = customers.customer_id
