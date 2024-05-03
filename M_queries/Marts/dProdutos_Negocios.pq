let
    Fonte = Negocios,
    select_columns = Table.SelectColumns(Fonte,{"id", "dealProducts"}),
    dealProducts_expand = Table.ExpandListColumn(select_columns, "dealProducts"),
    dealProducts_records = Table.ExpandRecordColumn(dealProducts_expand, "dealProducts", {"quantity", "price", "finalPrice", "initialPrice", "product"}, {"quantity", "price", "finalPrice", "initialPrice", "product"}),
    product_records = Table.ExpandRecordColumn(dealProducts_records, "product", {"id"}, {"product.id"}),
    remove_null_rows = Table.SelectRows(product_records, each ([product.id] <> null)),
    change_type = Table.TransformColumnTypes(remove_null_rows,{{"id", type text}, {"product.id", type text}, {"quantity", Int64.Type}, {"initialPrice", type number}, {"finalPrice", type number}, {"price", type number}})
in
    change_type