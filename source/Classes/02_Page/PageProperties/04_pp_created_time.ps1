class notion_created_time_page_property : PagePropertiesBase
# https://developers.notion.com/reference/page-property-values#created-time
{
    [string] $created_time

    notion_created_time_page_property() : base("created_time")
    {
        $this.created_time = Get-Date -Format "yyyy-MM-ddTHH:mm:ss.fffZ" -AsUTC
    }

    notion_created_time_page_property([string]$created_time) : base("created_time")
    {
        $this.created_time = ConvertTo-NotionFormattedDateTime -InputDate $created_time -fieldName "created_time"
    }

    static [notion_created_time_page_property] ConvertFromObject($Value)
    {
        $created_time_obj = [notion_created_time_page_property]::new()
        $created_time_obj.created_time = $Value.created_time
        return $created_time_obj
    }
}
