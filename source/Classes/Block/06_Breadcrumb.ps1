class Breadcrumb : Block
{
    [blocktype] $type = "breadcrumb"

    static ConvertFromObject($Value)
    {
        $breadcrumb = [Breadcrumb]::new()
    }
}
