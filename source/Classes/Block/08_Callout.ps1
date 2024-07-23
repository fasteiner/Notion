class Callout : Block
{
    [blocktype] $type = "callout"
    [rich_text[]] $rich_text
    # icon: emoji or file
    $icon = @{
        "type"  = "emoji"
        "emoji" = $null
    }
    [color] $color = "default"
    #[block] $children = $null
}
