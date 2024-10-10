class Column : Block
# https://developers.notion.com/reference/block#column
{
    [blocktype] $type = "column"
    [block] $column = $null
    
    # static [Column] ConvertFromObject($Value)
    # {
    #     $Column = [Column]::new()
    #     $Column.column = [block]::ConvertFromObject($Value.column)
    #     return $Column
    # }
        
}
