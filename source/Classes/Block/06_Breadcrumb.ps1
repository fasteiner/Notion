class notion_breadcrumb_block : notion_block
# https://developers.notion.com/reference/block#breadcrumb
{
    [notion_blocktype] $type = "breadcrumb"
    [object] $breadcrumb = @{}

    notion_breadcrumb_block()
    {
    }


    static [notion_breadcrumb_block] ConvertFromObject($Value)
    {
        return [notion_breadcrumb_block]::new()
    }
}
