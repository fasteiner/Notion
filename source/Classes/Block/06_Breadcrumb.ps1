class Breadcrumb : Block
# https://developers.notion.com/reference/block#breadcrumb
{
    [blocktype] $type = "breadcrumb"
    [object] $breadcrumb = @{}

    breadcrumb()
    {
    }


    static [Breadcrumb] ConvertFromObject($Value)
    {
        return [Breadcrumb]::new()
    }
}
