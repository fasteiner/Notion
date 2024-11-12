class notion_url_page_proerty : PagePropertiesBase
# https://developers.notion.com/reference/page-property-values#url
{
    [string] $url

    notion_url_page_proerty($url)
    {
        $this.url = $url
    }

    static [notion_url_page_proerty] ConvertFromObject($Value)
    {
        return [notion_url_page_proerty]::new($Value.url)
    }
}
