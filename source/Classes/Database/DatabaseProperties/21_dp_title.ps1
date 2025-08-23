class notion_title_database_property : DatabasePropertiesBase
# https://developers.notion.com/reference/property-object#title
{
    [hashtable] $title

    notion_title_database_property() : base("title")
    {
        $this.title = @{}
    }

    static [notion_title_database_property] ConvertFromObject($Value)
    {
        Write-Verbose "[notion_title_database_property]::ConvertFromObject($($Value | ConvertTo-Json -Depth 10))"
        return [notion_title_database_property]::new()
    }
}
