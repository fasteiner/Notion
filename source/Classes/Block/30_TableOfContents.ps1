class TableOfContents : Block
# https://developers.notion.com/reference/block#table-of-contents
{
    [blocktype] $type = "table_of_contents"
    [notion_color] $color = "default"

    static [TableOfContents] ConvertFromObject($Value)
    {
        $table_of_contents = [TableOfContents]::new()
        $table_of_contents.color = [Enum]::Parse([notion_color], $Value.color)
        return $table_of_contents
    }
}
