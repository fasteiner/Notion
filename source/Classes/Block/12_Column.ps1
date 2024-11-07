class column : Block
# https://developers.notion.com/reference/block#column
{
    [blocktype] $type = "column"
    [object] $column = @{}
    
    column() { }

    static [Column] ConvertFromObject($Value)
    {
        $ColumnObj = [Column]::new()
        $ColumnObj.column = $Value.column
        return $ColumnObj
    }
}
