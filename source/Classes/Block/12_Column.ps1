class notion_column_block : notion_block
# https://developers.notion.com/reference/block#column
{
    [notion_blocktype] $type = "column"
    [object] $column = @{}
    
    notion_column_block()
    { 
    }

    static [notion_column_block] ConvertFromObject($Value)
    {
        $Column_Obj = [notion_column_block]::new()
        $Column_Obj.column = $Value.column
        return $Column_Obj
    }
}
