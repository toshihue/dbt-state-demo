select
    customer_id,
    first_name,
    last_name,
    customer_name
from {{ ref('stg_customers') }}
