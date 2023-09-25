{{ config(
    materialized='ephemeral' 
) }}

with customers as (
    select * from {{ ref('stg_customers') }}
),

orders as (
    select * from {{ ref('stg_orders' ) }}
),

repeat_customers as (
    select
        customer_id,
        status,
        count(distinct order_id) as num_orders

    from orders
    group by customer_id, status
),

final as (
    select
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        repeat_customers.num_orders,
        repeat_customers.status

    from customers
    left join
        repeat_customers
        on customers.customer_id = repeat_customers.customer_id
where num_orders > 1
)

select * from final
order by num_orders desc