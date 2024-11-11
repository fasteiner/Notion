class parent
# https://developers.notion.com/reference/parent-object
{
    $type

    parent()
    {
    }

    parent($type, $id)
    {
        switch ([Enum]::Parse([parent_type], $type))
        {
            "block_id"
            {  
                $this.type = "block_id"
                $this | Add-Member -MemberType NoteProperty -Name "block_id" -Value $id
                break
            }
            "database_id"
            {  
                $this.type = "database_id"
                $this | Add-Member -MemberType NoteProperty -Name "database_id" -Value $id
                break
            }
            "page_id"
            {  
                $this.type = "page_id"
                $this | Add-Member -MemberType NoteProperty -Name "page_id" -Value $id
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
        $parent = [parent]::new()
        $parent.type = $Value.type

        switch ($Value.type)
        {
            "block_id"
            {
                $parent | Add-Member -MemberType NoteProperty -Name "block_id" -Value $Value.block_id
            }
            "database_id"
            {
                $parent | Add-Member -MemberType NoteProperty -Name "database_id" -Value $Value.database_id 
            }
            "page_id"
            {
                $parent | Add-Member -MemberType NoteProperty -Name "page_id" -Value $Value.page_id 
            }
            Default
            {
                Write-Warning "No valid parent type [block_id | database_id | page_id] found" 
            }
        }

        return $parent
    }
}
