class NumberedListItem : Block
{
    [blocktype] $type = "numbered_list_item"
    [rich_text[]] $rich_text
    [notion_color] $color = "default"
    #[block] $children = $null

    static ConvertFromObject($Value)
    {
        $numbered_list_item = [numbered_list_item]::new()
        $numbered_list_item.rich_text = [rich_text]::ConvertFromObject($Value.rich_text)
        $numbered_list_item.color = $Value.color        
    }
}
