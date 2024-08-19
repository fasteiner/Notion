class NumberedListItem : Block
{
    [blocktype] $type = "numbered_list_item"
    [rich_text[]] $rich_text
    [notion_color] $color = "default"
    #[block] $children = $null
}
