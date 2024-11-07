class column_list : block
# https://developers.notion.com/reference/block#column-list-and-column
{
    [blocktype] $type = "column_list"
    [column[]] $column_list = [column[]]@()

    column_list()
    {
    }

    column_list([column] $column_list)
    {
        $this.column_list = $column_list
    }

    add($column)
    {
        $this.column_list += $column
    }
    
    static [column_list] ConvertFromObject($Value)
    {
        $column_list_obj = [column_list]::new()
        $column_list_obj.column_list = add([column]::ConvertFromObject($Value.column_list))
        return $column_list_obj
    }
}
