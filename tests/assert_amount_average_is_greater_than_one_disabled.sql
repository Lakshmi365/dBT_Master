-- This is a singular test designed to test that the average of a returning customer's order is greater than or equal to one. 
{{ config(enabled = false) }}

select
    customer_id, 
    avg(amount) as average_amount
from {{ ref('orders') }}
group by 1
having count(customer_id) > 1 and average_amount < 1