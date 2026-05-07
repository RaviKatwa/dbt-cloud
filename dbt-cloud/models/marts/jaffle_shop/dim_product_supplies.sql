with products as (

select * from {{ ref('stg_jaffle_shop__products') }}

),

supplies as (

   select * from {{ ref('stg_jaffle_shop__supplies') }}

),


final as (

    select
        products.product_name,
        products.product_type,
        products.product_description,
        coalesce(products.product_price, 0) as product_price,
        IFF(products.product_type='jaffle',TRUE, FALSE) AS is_food_item,
        IFF(products.product_type='beverage',TRUE, FALSE) AS is_drink_item,
        coalesce(supplies.supplier_cost,0) as supply_cost,
        products.sku as product_id

    from products

    left join supplies using (sku)

)

select * from final