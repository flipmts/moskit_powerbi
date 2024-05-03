let
    Fonte = Produto,
    select_columns = Table.RemoveColumns(Fonte,{"createdBy"}),
    rename_columns = Table.RenameColumns(select_columns,{{"price", "Preço"}, {"active", "Ativo"}, {"name", "Produto"}}),
    change_type = Table.TransformColumnTypes(rename_columns,{{"Ativo", type logical}, {"sku", type text}, {"Produto", type text}, {"product.id", type text}, {"Preço", type number}})
in
    change_type