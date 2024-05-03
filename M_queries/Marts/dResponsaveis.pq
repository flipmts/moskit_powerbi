let
    Fonte = Usuario,
    team_records = Table.ExpandRecordColumn(Fonte, "team", {"id"}, {"team.id"}),
    join_time = Table.NestedJoin(team_records, {"team.id"}, Time, {"team.id"}, "Time", JoinKind.LeftOuter),
    time_expand = Table.ExpandTableColumn(join_time, "Time", {"name"}, {"Time"}),
    select_columns = Table.RemoveColumns(time_expand,{"team.id"}),
    rename_columns = Table.RenameColumns(select_columns,{{"name", "Responsável"}, {"active", "Ativo"}}),
    change_type = Table.TransformColumnTypes(rename_columns,{{"Ativo", type logical}, {"Time", type text}, {"Responsável", type text}, {"responsible.id", type text}})
in
    change_type