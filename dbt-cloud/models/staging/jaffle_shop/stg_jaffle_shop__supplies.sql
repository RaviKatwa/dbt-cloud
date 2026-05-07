with 

source as (

    select * from {{ source('jaffle_shop', 'supplies') }}

),

renamed as (

    select
        id as supplier_id,
        name as supplier_name,
        cost as supplier_cost,
        perishable,
        sku

    from source

)

select * from renamed