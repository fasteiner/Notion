class BulletedListItem : Block
{
    [blocktype] $type = "bulleted_list_item"
    [rich_text[]] $rich_text
    [color] $color = "default"
    #[block] $children = $null
}
