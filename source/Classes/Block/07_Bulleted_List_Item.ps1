class bulleted_list_item : Block
# https://developers.notion.com/reference/block#bulleted-list-item
{
    [blocktype] $type = "bulleted_list_item"
    [rich_text[]] $rich_text
    [notion_color] $color = "default"

    static [bulleted_list_item] ConvertFromObject($Value)
    {
        $bulleted_list_item = [bulleted_list_item]::new()
        $bulleted_list_item.rich_text = $Value.rich_text.ForEach({[rich_text]::ConvertFromObject($_)})
        $bulleted_list_item.color = [Enum]::Parse([notion_color], $Value.color)
        return $bulleted_list_item
    }
}
