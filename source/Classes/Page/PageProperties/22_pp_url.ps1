class pp_url : PageProperties
# https://developers.notion.com/reference/page-property-values#url
{
    [string] $url

    pp_url($url)
    {
        $this.url = $url
    }

    static [pp_url] ConvertFromObject($Value)
    {
        return [pp_url]::new($Value.url)
    }
}
