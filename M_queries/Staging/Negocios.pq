let
    /* this apikey paramter is used like a global variable into the Power Query */
    #"apikey" = "YOUR_API",
    start_date = "DATE",

    Fonte = #table(1, {{List.Numbers(0, 100,50)}}),
    pages_range = Table.TransformColumns(Table.ExpandListColumn(Fonte, "Column1"), {"Column1", each Text.From(_)}),
    api_call = Table.AddColumn(pages_range, "call", each Json.Document(Web.Contents("https://api.moskitcrm.com/v2/deals?start=" & [Column1] & "&quantity=50",[Headers=[Accept="application/json", apikey=#"apikey"]]))),
    call_list_expand = Table.ExpandListColumn(api_call, "call"),
    remove_pages = Table.RemoveColumns(call_list_expand,{"Column1"}),
    remove_null_rows = Table.SelectRows(remove_pages, each not List.IsEmpty(List.RemoveMatchingItems(Record.FieldValues(_), {"", null}))),
    call_expand = Table.ExpandRecordColumn(remove_null_rows, "call", {"id", "createdBy", "responsible", "dateCreated", "name", "price", "source", "origin", "status", "closeDate", "stage", "lostReason", "dealProducts", "contacts", "activities", "companies", "projects", "entityCustomFields"}, {"id", "createdBy", "responsible", "dateCreated", "name", "price", "source", "origin", "status", "closeDate", "stage", "lostReason", "dealProducts", "contacts", "activities", "companies", "projects", "entityCustomFields"}),
    date_types = Table.TransformColumns(call_expand, {{"dateCreated", each Text.BeforeDelimiter(_, "T"), type date}, {"closeDate", each Text.BeforeDelimiter(_, "T"), type date}}),
    date_type_region = Table.TransformColumnTypes(date_types, {{"dateCreated", type date}, {"closeDate", type date}}, "en-US"),
    date_filter = Table.SelectRows(date_type_region, each [dateCreated] >= start_date)
in
    date_filter