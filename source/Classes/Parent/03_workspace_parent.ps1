class notion_workspace_parent : notion_parent
{
    # https://developers.notion.com/reference/parent-object#workspace-parent    
    [bool] $workspace = $true

    notion_workspace_parent() : base("workspace")
    {
    }

    static [notion_workspace_parent] ConvertFromObject($Value)
    {
        return [notion_workspace_parent]::new()
    }

}
