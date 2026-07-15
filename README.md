# dbt State Demo

This project is intentionally small so dbt state selection behavior is easy to
see in demos.

## DAG

```text
source:jaffle_shop.customers -> stg_customers -> dim_customers
                                      \         -> fct_orders -> agg_orders_by_customer
source:jaffle_shop.orders    -> stg_orders ----/
```

## Models

- `stg_customers`: cleans the raw customer source.
- `stg_orders`: cleans the raw order source.
- `dim_customers`: customer dimension with order history.
- `fct_orders`: order fact table enriched with customer attributes.
- `agg_orders_by_customer`: customer-level order summary.

## Demo commands

```shell
dbt parse
dbt compile --select stg_orders+ stg_customers+
dbt ls --select state:modified+ --state path/to/previous/target
```
