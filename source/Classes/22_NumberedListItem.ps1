class NumberedListItem : Block
{
    [blocktype] $type = "numbered_list_item"
    [rich_text[]] $rich_text
    [color] $color = "default"
    #[block] $children = $null
}
