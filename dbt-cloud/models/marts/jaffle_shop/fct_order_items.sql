with orders as  (
    select * from {{ ref ('stg_jaffle_shop__orders' )}}
    where order_id is not null
),

items as (
    select * from {{ ref ('stg_jaffle_shop__items') }}
    where item_id is not null
),

stores as (
    select * from {{ ref ('stg_jaffle_shop__stores') }}
),

customers as (
    select * from {{ ref ('stg_jaffle_shop__customers') }}
),

 final as (

    select
        items.item_id as order_item_id,
        items.order_id as order_id,
        items.sku as product_id,
        orders.store_id as location_id,
        orders.customer_id as customer_id,
        coalesce (orders.order_total, 0) as order_total,
        orders.tax_paid as tax_paid,
        orders.ordered_date as ordered_date,
        customers.customer_name as customer_name,
        stores.store_name as location_name,
        stores.tax_rate as tax_rate,
        stores.location_opened_at as location_opened_at,
        month(orders.ordered_date) as ordered_month,
        day(orders.ordered_date) as ordered_day,
        year(orders.ordered_date) as ordered_year       

    from orders
    left join items on items.order_id=orders.order_id
    left join stores on orders.store_id=stores.store_id
    left join customers on orders.customer_id=customers.customer_id
)

select * from final