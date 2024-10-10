class numbered_list_item : Block
# https://developers.notion.com/reference/block#numbered-list-item
{
    [blocktype] $type = "numbered_list_item"
    [rich_text[]] $rich_text
    [notion_color] $color = "default"


    static [numbered_list_item] ConvertFromObject($Value)
    {
        $numbered_list_item = [numbered_list_item]::new()
        $numbered_list_item.rich_text = [rich_text]::ConvertFromObject($Value.rich_text)
        $numbered_list_item.color = $Value.color
        return $numbered_list_item
    }
}
