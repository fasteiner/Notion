class ColumnList : Block
# https://developers.notion.com/reference/block#column-list-and-column
{
    [blocktype] $type = "column_list"
    [block] $column_list = $null
    
    static [ColumnList] ConvertFromObject($Value)
    {
        $ColumnList = [ColumnList]::new()
        $ColumnList.column_list = [block]::ConvertFromObject($Value.column_list)
        return $ColumnList
    }
}
