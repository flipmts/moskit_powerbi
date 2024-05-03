let
    Fonte = Contatos,
    select_columns = Table.RemoveColumns(Fonte,{"activities"}),
    responsible_records = Table.ExpandRecordColumn(select_columns, "responsible", {"id"}, {"responsible.id"}),
    date_types = Table.TransformColumns(responsible_records, {{"dateCreated", each Text.BeforeDelimiter(_, "T"), type text}}),
    date_region = Table.TransformColumnTypes(date_types, {{"dateCreated", type date}}, "en-US"),
    rename_columns = Table.RenameColumns(date_region,{{"name", "Contato"}}),
    change_type = Table.TransformColumnTypes(rename_columns,{{"Contato", type text}, {"responsible.id", type text}, {"contacts.id", type text}})
in
    change_type