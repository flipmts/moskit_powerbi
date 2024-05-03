let
    Fonte = Fase,
    pipeline_expand = Table.ExpandRecordColumn(Fonte, "pipeline", {"id"}, {"pipeline.id"}),
    join_pipeline = Table.NestedJoin(pipeline_expand, {"pipeline.id"}, Pipeline, {"pipeline.id"}, "Pipeline", JoinKind.LeftOuter),
    Pipeline_expand = Table.ExpandTableColumn(join_pipeline, "Pipeline", {"name"}, {"Pipeline"}),
    select_columns = Table.RemoveColumns(Pipeline_expand,{"pipeline.id"}),
    rename_columns = Table.RenameColumns(select_columns,{{"name", "Fase"}, {"priority", "Prioridade"}}),
    change_type = Table.TransformColumnTypes(rename_columns,{{"Pipeline", type text}, {"Prioridade", type text}, {"Fase", type text}, {"stage.id", type text}})
in
    change_type