class notion_divider_block : notion_block
# https://developers.notion.com/reference/block#divider
{
    [notion_blocktype] $type = "divider"
    [object] $divider = @{}

    notion_divider_block()
    {
    }
    
    static [notion_divider_block] ConvertFromObject($Value)
    {
        return [notion_divider_block]::new()
    }
}
