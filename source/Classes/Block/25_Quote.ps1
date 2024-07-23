class Quote : Block
{
    [blocktype] $type = "quote"
    [rich_text[]] $rich_text
    [color] $color = "default"
    #[block] $children = $null
}
