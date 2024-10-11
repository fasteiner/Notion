class parent
# https://developers.notion.com/reference/parent-object
{

    parent($type, $id)
    {
        switch ([Enum]::Parse([parent_type], $type))
        {
            "block_id"
            {  
                $this.type = "block_id"
                $this.block_id = $id
                break
            }
            "database_id"
            {  
                $this.type = "database_id"
                $this.database_id = $id
                break
            }
            "page_id"
            {  
                $this.type = "page_id"
                $this.page_id = $id
                break
            }
            Default
            {
                Write-Warning "No valid parent type [block_id | database_id | page_id] found"
            }
        }        
    }

    static [parent] ConvertFromObject($Value)
    {
        return [parent]::new($Value.type, $Value.id)
    }
}
