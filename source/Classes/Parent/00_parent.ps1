class notion_parent
{
    #https://developers.notion.com/reference/parent-object
    [notion_parent_type]$type

    notion_parent()
    {
    }

    notion_parent([notion_parent_type]$type)
    {
        $this.type = $type
    }

    static [notion_parent] ConvertFromObject($Value)
    {
        $parent_obj = $null
        switch ($Value.type) {
            "database_id" {
                $parent_obj = [notion_database_parent]::ConvertFromObject($Value)
            }
            "page_id" {
                $parent_obj = [notion_page_parent]::ConvertFromObject($Value)
            }
            "workspace" {
                $parent_obj = [notion_workspace_parent]::ConvertFromObject($Value)
            }
            "block_id" {
                $parent_obj = [notion_block_parent]::ConvertFromObject($Value)
            }
            default {
                Write-Error "Unknown parent type: $($Value.type)" -Category InvalidData -RecommendedAction "Check the parent type and try again. Supported types are: database, page, workspace, block"
            }
        }
        return $parent_obj
    }
}
