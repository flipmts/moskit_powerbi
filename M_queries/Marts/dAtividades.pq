let
    Fonte = Atividades,
    type_records = Table.ExpandRecordColumn(Fonte, "type", {"id"}, {"type.id"}),
    join_TipoAtividades = Table.NestedJoin(type_records, {"type.id"}, TipoAtividades, {"type.id"}, "TipoAtividades", JoinKind.LeftOuter),
    TipoAtividades_expand = Table.ExpandTableColumn(join_TipoAtividades, "TipoAtividades", {"name"}, {"Tipo de Atividade"}),
    select_columns = Table.RemoveColumns(TipoAtividades_expand,{"type.id"}),
    date_types = Table.TransformColumns(select_columns, {{"dateCreated", each Text.BeforeDelimiter(_, "T"), type text}, {"dueDate", each Text.BeforeDelimiter(_, "T"), type text}}),
    date_region = Table.TransformColumnTypes(date_types, {{"dateCreated", type date}, {"dueDate", type date}}, "en-US"),
    rename_columns = Table.RenameColumns(date_region,{{"totalTries", "Tentativas"}, {"title", "Atividade"}, {"dateCreated", "Data de criação"}, {"dueDate", "Data de vencimento"}}),
    responsible_records = Table.ExpandRecordColumn(rename_columns, "responsible", {"id"}, {"responsible.id"}),
    change_type = Table.TransformColumnTypes(responsible_records,{{"activities.id", type text}, {"Atividade", type text}, {"responsible.id", type text}, {"Tipo de Atividade", type text}, {"Tentativas", Int64.Type}})
in
    change_type