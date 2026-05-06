with 

source as (

    select * from {{ source('jaffle_shop', 'orders') }}

),

renamed as (

    select
        id as order_id,
        customer as customer_id,
        order_date,
        status order_status,
        _etl_loaded_at

    from source

)

select * from renamed