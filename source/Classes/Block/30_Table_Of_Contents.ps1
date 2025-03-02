class Table_Of_Contents_structure
{
    #https://developers.notion.com/reference/block#table-of-contents
    [notion_color] $color = "default"

    Table_Of_Contents_structure([notion_color] $color = "default")
    {
        $this.color = $color
    }
    static [Table_Of_Contents_structure] ConvertFromObject($Value)
    {
        return [Table_Of_Contents_structure]::new([Enum]::Parse([notion_color], $Value.color))
    }
}

class notion_table_of_contents_block : notion_block
{
    # https://developers.notion.com/reference/block#table-of-contents
    [notion_blocktype] $type = "table_of_contents"
    [Table_Of_Contents_structure] $table_of_contents

    notion_table_of_contents_block([notion_color] $color = "default")
    {
        $this.table_of_contents = [Table_Of_Contents_structure]::new($color)
    }

    static [notion_table_of_contents_block] ConvertFromObject($Value)
    {
        $table_of_contents_Obj = [notion_table_of_contents_block]::new()
        $table_of_contents_Obj.table_of_contents = [Table_Of_Contents_structure]::ConvertFromObject($Value.table_of_contents)
        return $table_of_contents_Obj
    }
}
