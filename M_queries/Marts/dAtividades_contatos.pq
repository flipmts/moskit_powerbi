let
    Fonte = Contatos,
    select_columns = Table.SelectColumns(Fonte,{"contacts.id", "activities"}),
    activities_expand = Table.ExpandListColumn(select_columns, "activities"),
    activities_records = Table.ExpandRecordColumn(activities_expand, "activities", {"id"}, {"activities.id"}),
    change_type = Table.TransformColumnTypes(activities_records,{{"contacts.id", type text}, {"activities.id", type text}})
in
    change_type