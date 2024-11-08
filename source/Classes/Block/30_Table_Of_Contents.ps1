class Table_Of_Contents_structure
{
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

class table_of_contents : block
# https://developers.notion.com/reference/block#table-of-contents
{
    [blocktype] $type = "table_of_contents"
    [Table_Of_Contents_structure] $table_of_contents

    table_of_contents([notion_color] $color = "default")
    {
        $this.table_of_contents = [Table_Of_Contents_structure]::new($color)
    }

    static [table_of_contents] ConvertFromObject($Value)
    {
        return [Table_Of_Contents_structure]::ConvertFromObject($Value.table_of_contents)
    }
}
