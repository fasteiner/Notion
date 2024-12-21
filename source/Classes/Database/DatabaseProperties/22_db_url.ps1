class notion_url_database_property : DatabasePropertiesBase
# https://developers.notion.com/reference/property-object#url
{
    [hashtable] $url

    notion_url_database_property() : base("url")
    {
        $this.url = @{}
    }

    static [notion_url_database_property] ConvertFromObject($Value)
    {
        return [notion_url_database_property]::new()
    }
}
