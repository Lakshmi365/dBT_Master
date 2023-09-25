with orders as (
    select
        id as order_id,
        user_id as customer_id,
        order_date,
        status,
        case
            when status not in ('returned', 'return_pending')
                then order_date
        end as valid_order_date

    from {{ source('jaffle_shop', 'orders') }}

)

select * from orders