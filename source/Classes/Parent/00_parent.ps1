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

    notion_parent([notion_parent_type]$type, [string]$id)
    {
        #$this = $this::ConvertFromObject(@{type = $type; id = $id })
        $temp = [notion_parent]::ConvertFromObject(@{type = $type; id = $id })
        $this.type = $temp.type
        $this | Add-Member -MemberType NoteProperty -Name $type -Value $temp.$type
    }

    static [notion_parent] ConvertFromObject($Value)
    {
        $parent_obj = $null
        switch ($Value.type)
        {
            "database_id"
            {
                $Value | Add-Member -MemberType NoteProperty -Name "database_id" -Value $Value.id
                $parent_obj = [notion_database_parent]::ConvertFromObject($Value)
            }
            "page_id"
            {
                # $Value | Add-Member -MemberType AliasProperty -Name id  -Value "page_id"
                $Value | Add-Member -MemberType NoteProperty -Name "page_id" -Value $Value.id
                $parent_obj = [notion_page_parent]::ConvertFromObject($Value)
            }
            "workspace"
            {
                $Value | Add-Member -MemberType NoteProperty -Name "workspace" -Value $Value.id
                $parent_obj = [notion_workspace_parent]::ConvertFromObject($Value)
            }
            "block_id"
            {
                $Value | Add-Member -MemberType NoteProperty -Name "block_id" -Value $Value.id
                $parent_obj = [notion_block_parent]::ConvertFromObject($Value)
            }
            default
            {
                Write-Error "Unknown parent type: $($Value.type)" -Category InvalidData -RecommendedAction "Check the parent type and try again. Supported types are: database, page, workspace, block"
            }
        }
        return $parent_obj
    }
}
