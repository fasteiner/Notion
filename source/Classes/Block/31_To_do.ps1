class To_do : Block
{
    [blocktype] $type = "to_do"
    [rich_text[]] $rich_text
    [bool] $checked = $false
    [color] $color = "default"
    #[block] $children = $null
}
