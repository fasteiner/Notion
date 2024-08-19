class Quote : Block
{
    [blocktype] $type = "quote"
    [rich_text[]] $rich_text
    [notion_color] $color = "default"
    #[block] $children = $null
}
