class bulleted_list_item : Block
# https://developers.notion.com/reference/block#bulleted-list-item
{
    [blocktype] $type = "bulleted_list_item"
    [rich_text[]] $rich_text
    [notion_color] $color = "default"

    static [bulleted_list_item] ConvertFromObject($Value)
    {
        $bulleted_list_item = [bulleted_list_item]::new()
        $bulleted_list_item.rich_text = @()
        foreach ($rich_text in $Value.rich_text)
        {
            $bulleted_list_item.rich_text += [rich_text]::ConvertFromObject($rich_text)
        }
        $bulleted_list_item.color = [notion_color]::ConvertFromObject($Value.color)
        return $bulleted_list_item
    }
}
