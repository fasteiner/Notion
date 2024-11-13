class notion_url_page_property : PagePropertiesBase
# https://developers.notion.com/reference/page-property-values#url
{
    [string] $url

    notion_url_page_property($url)
    {
        $this.url = $url
    }

    static [notion_url_page_property] ConvertFromObject($Value)
    {
        return [notion_url_page_property]::new($Value.url)
    }
}
