let
    /* this apikey paramter is used like a global variable into the Power Query */
    #"apikey" = "YOUR_API",

    Fonte = #table(1, {{List.Numbers(0, 2,50)}}),
    pages_range = Table.TransformColumns(Table.ExpandListColumn(Fonte, "Column1"), {"Column1", each Text.From(_)}),
    api_call = Table.AddColumn(pages_range, "call", each Json.Document(Web.Contents("https://api.moskitcrm.com/v2/stages?start=" & [Column1] & "&quantity=50",[Headers=[Accept="application/json", apikey=#"apikey"]]))),
    call_list_expand = Table.ExpandListColumn(api_call, "call"),
    remove_pages = Table.RemoveColumns(call_list_expand,{"Column1"}),
    remove_null_rows = Table.SelectRows(remove_pages, each not List.IsEmpty(List.RemoveMatchingItems(Record.FieldValues(_), {"", null}))),
    call_expand = Table.ExpandRecordColumn(remove_null_rows, "call", {"id", "name", "priority", "pipeline"}, {"stage.id", "name", "priority", "pipeline"})
in
    call_expand