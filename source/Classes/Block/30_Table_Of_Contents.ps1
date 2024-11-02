class table_of_contents : Block
# https://developers.notion.com/reference/block#table-of-contents
{
    [blocktype] $type = "table_of_contents"
    [notion_color] $color = "default"

    static [table_of_contents] ConvertFromObject($Value)
    {
        $table_of_contents = [table_of_contents]::new()
        $table_of_contents.color = [Enum]::Parse([notion_color], $Value.color)
        return $table_of_contents
    }
}
