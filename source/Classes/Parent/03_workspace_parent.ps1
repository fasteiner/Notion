class notion_workspace_parent : notion_parent{
    [bool] $workspace = $true

    notion_workspace_parent() : base("workspace_id")
    {
    }

    static [notion_workspace_parent] ConvertFromObject($Value)
    {
        return [notion_workspace_parent]::new()
    }

}
