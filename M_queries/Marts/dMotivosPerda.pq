let
    Fonte = MotivosPerda,
    rename_columns = Table.RenameColumns(Fonte,{{"name", "Motivo de perda"}}),
    change_type = Table.TransformColumnTypes(rename_columns,{{"lostReasons.id", type text}, {"Motivo de perda", type text}})
in
    change_type