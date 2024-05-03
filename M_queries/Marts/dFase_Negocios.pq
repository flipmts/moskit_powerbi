let
    Fonte = fNegocios,
    select_id_column = Table.SelectColumns(Fonte,{"id"}),
    deals_api_call = Table.AddColumn(select_id_column,"call", each Json.Document(Web.Contents("https://api.moskitcrm.com/v2/deals/" & [id] & "/movements",[Headers=[Accept="application/json", apikey=#"apikey"]]))),
    call_list_expand = Table.ExpandListColumn(deals_api_call, "call"),
    deals_records = Table.ExpandRecordColumn(call_list_expand, "call", {"id", "dateCreated", "currentStage", "firstNavigation", "oldStage"}, {"Stage.id", "Data de criação", "currentStage", "Primeira fase", "Fase anterior"}),
    currentStage_records = Table.ExpandRecordColumn(deals_records, "currentStage", {"id"}, {"currentStage.id"}),
    oldStage_records = Table.ExpandRecordColumn(currentStage_records, "Fase anterior", {"id"}, {"oldStage.id"}),
    add_index = Table.AddIndexColumn(oldStage_records, "Índice", 0, 1, Int64.Type),
    dateEnd_lookup = Table.AddColumn(add_index, "dateEnd_lookup", each 
        let
            IndiceAtual = [Índice],
            TabelaFiltrada = Table.SelectRows(add_index, each [Índice] = IndiceAtual + 1),
            Valor = if Table.IsEmpty(TabelaFiltrada) then null else TabelaFiltrada{0}[oldStage.id]
        in
            Text.From(Valor), type text
    ),
    dateEnd = Table.AddColumn(dateEnd_lookup, "Data Final", each 
        let
            IndiceAtual = [Índice],
            TabelaFiltrada = Table.SelectRows(dateEnd_lookup, each [Índice] = IndiceAtual + 1),
            Valor = if Table.IsEmpty(TabelaFiltrada) then null else if [dateEnd_lookup] = null then null else TabelaFiltrada{0}[Data de criação]
        in
            Text.From(Valor), type text
    ),
    remove_columns = Table.RemoveColumns(dateEnd,{"Índice", "dateEnd_lookup"}),
    date_types = Table.TransformColumns(remove_columns, {{"Data de criação", each Text.BeforeDelimiter(_, "T"), type text}, {"Data Final", each Text.BeforeDelimiter(_, "T"), type text}}),
    date_type_region = Table.TransformColumnTypes(date_types, {{"Data de criação", type date}, {"Data Final", type date}}, "en-US"),
    change_type = Table.TransformColumnTypes(date_type_region,{{"Primeira fase", type logical}, {"oldStage.id", type text}, {"currentStage.id", type text}, {"Stage.id", type text}, {"id", type text}})
in
    change_type