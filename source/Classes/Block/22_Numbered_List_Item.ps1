class numbered_list_item : Block
{
    [blocktype] $type = "numbered_list_item"
    [rich_text[]] $rich_text
    [notion_color] $color = "default"


    static ConvertFromObject($Value)
    {
        $numbered_list_item = [numbered_list_item]::new()
        $numbered_list_item.rich_text = [rich_text]::ConvertFromObject($Value.rich_text)
        $numbered_list_item.color = $Value.color        
    }
}
