with 

source as (

    select * from {{ source('jaffle_shop', 'orders') }}

),

renamed as (

    select
    id as order_id,
    customer as customer_id,
    ordered_at as ordered_date,
    store_id,
    subtotal as sub_total,
    tax_paid,
    order_total
    from source

)

select * from renamed