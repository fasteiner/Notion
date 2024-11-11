class column : block
# https://developers.notion.com/reference/block#column
{
    [blocktype] $type = "column"
    [object] $column = @{}
    
    column()
    { 
    }

    static [Column] ConvertFromObject($Value)
    {
        $Column_Obj = [Column]::new()
        $Column_Obj.column = $Value.column
        return $Column_Obj
    }
}
