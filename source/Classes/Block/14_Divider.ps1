class divider : block
# https://developers.notion.com/reference/block#divider
{
    [blocktype] $type = "divider"
    [object] $divider = @{}

    divider()
    {
    }
    
    static [divider] ConvertFromObject($Value)
    {
        return [divider]::new()
    }
}
