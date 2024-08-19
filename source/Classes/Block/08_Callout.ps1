class Callout : Block
{
    [blocktype] $type = "callout"
    [rich_text[]] $rich_text
    # icon: emoji or file
    $icon = @{
        "type"  = "emoji"
        "emoji" = $null
    }
    [notion_color] $color = "default"
    #[block] $children = $null
}
