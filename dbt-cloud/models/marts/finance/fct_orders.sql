with orders as  (
    select * from {{ ref ('stg_jaffle_shop__orders' )}}
),

customers as (
    select * from {{ ref ('stg_jaffle_shop__customers') }}
),

stores as (
    select * from {{ ref ('stg_jaffle_shop__stores') }}
),

 final as (

    select
        orders.order_id as order_id,
        orders.customer_id as customer_id,
        orders.store_id as store_id,
        coalesce (orders.order_total, 0) as order_total,
        orders.tax_paid as tax_paid,
        orders.ordered_date as ordered_date,
        customers.customer_name as customer_name,
        stores.store_name as store_name,
        stores.tax_rate as tax_rate,
        stores.location_opened_at as location_opened_at,
        month(orders.ordered_date) as ordered_month,
        day(orders.ordered_date) as ordered_day,
        year(orders.ordered_date) as ordered_year       

    from orders
    left join customers on orders.customer_id = customers.customer_id
    left join stores on orders.store_id = stores.store_id
)

select * from final