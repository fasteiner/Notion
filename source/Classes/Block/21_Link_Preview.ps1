class link_preview_structure
{
    [string] $url

    link_preview_structure()
    {
    }

    link_preview_structure($url)
    {
        $this.url = $url
    }

    static [link_preview_structure] ConvertFromObject($value)
    {
        return [link_preview_structure]::new($value.url)
    }
}

class link_preview 
# https://developers.notion.com/reference/block#link-preview
{
    [blocktype] $type = "link_preview"
    [link_preview_structure] $link_preview

    link_preview() { }

    link_preview($url)
    {
        $this.link_preview = [link_preview_structure]::new($url)
    }

    static [link_preview] ConvertFromObject ($value)
    {
        return [link_preview]::new($value.link_preview.url)
    }

}
