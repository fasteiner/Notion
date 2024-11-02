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
