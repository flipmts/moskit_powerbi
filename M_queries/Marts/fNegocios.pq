let
    Fonte = Negocios,
    select_columns = Table.SelectColumns(Fonte,{"id", "responsible", "dateCreated", "name", "price", "status", "closeDate", "stage", "lostReason", "contacts"}),
    contacts_expand = Table.ExpandListColumn(select_columns, "contacts"),
    contacts_records = Table.ExpandRecordColumn(contacts_expand, "contacts", {"id"}, {"contacts.id"}),
    responsible_records = Table.ExpandRecordColumn(contacts_records, "responsible", {"id"}, {"responsible.id"}),
    stage_records = Table.ExpandRecordColumn(responsible_records, "stage", {"id"}, {"stage.id"}),
    lostReason_records = Table.ExpandRecordColumn(stage_records, "lostReason", {"id"}, {"lostReason.id"}),
    rename_columns = Table.RenameColumns(lostReason_records,{{"dateCreated", "Data de criação"}, {"closeDate", "Data de fechamento"}, {"status", "Status"}, {"price", "Preço"}, {"name", "Negocio"}}),
    change_type = Table.TransformColumnTypes(rename_columns,{{"Preço", type number}, {"id", type text}, {"responsible.id", type text}, {"Negocio", type text}, {"Status", type text}, {"stage.id", type text}, {"lostReason.id", type text}, {"contacts.id", type text}})
in
    change_type