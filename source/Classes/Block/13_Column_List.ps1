class notion_column_list_block : notion_block
# https://developers.notion.com/reference/block#column-list-and-column
{
    [notion_blocktype] $type = "column_list"
    [notion_column_block[]] $column_list = [notion_column_block[]]@()

    notion_column_list_block()
    {
    }

    column_list([notion_column_list_block] $column_list)
    {
        $this.column_list = $column_list
    }

    add($column)
    {
        $this.column_list += $column
    }
    
    static [notion_column_list_block] ConvertFromObject($Value)
    {
        $column_list_obj = [notion_column_list_block]::new()
        #$column_list_obj.add([notion_column_block]::ConvertFromObject($Value.column_list))
        # actual data is in the children (GET /block/{block_id}/children)
        return $column_list_obj
    }
}
