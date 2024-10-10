class Breadcrumb : Block
# https://developers.notion.com/reference/block#breadcrumb
{
    [blocktype] $type = "breadcrumb"

    static [Breadcrumb] ConvertFromObject($Value)
    {
        $breadcrumb = [Breadcrumb]::new()
        return $breadcrumb
    }
}
