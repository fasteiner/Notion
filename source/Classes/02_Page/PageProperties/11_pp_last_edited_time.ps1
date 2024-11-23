class notion_last_edited_time_page_property : PagePropertiesBase
# https://developers.notion.com/reference/page-property-values#last-edited-time
{
    [string] $last_edited_time

    notion_last_edited_time_page_property($value) : base("last_edited_time")
    {
        $this.last_edited_time = ConvertTo-TSNotionFormattedDateTime -InputDate $value -fieldName "last_edited_time"
    }

    static [notion_last_edited_time_page_property] ConvertFromObject($Value)
    {
        return [notion_last_edited_time_page_property]::new($Value.last_edited_time)
    }
}
