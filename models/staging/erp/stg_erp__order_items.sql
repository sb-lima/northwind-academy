with
    source_order_details as (
        select *
        from {{ source('erp', 'order_details') }}
    )

    , renamed as (
        select
            {{ dbt_utils.generate_surrogate_key(['orderid', 'productid']) }} as order_item_sk
            --, (cast(orderid as varchar) || '-' || cast(productid as varchar)) as order_item_sk_2
            , cast(orderid as int) as order_fk
            , cast(productid as int) as product_fk
            , cast(discount as numeric(18,2)) as discount_pct
            , cast(unitprice as numeric(18,2)) as unit_price
            , cast(quantity as int) as quantity
        from source_order_details
    )

select *
from renamed