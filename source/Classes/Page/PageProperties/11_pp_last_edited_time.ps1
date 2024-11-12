class notion_last_edited_time_page_property : PagePropertiesBase
# https://developers.notion.com/reference/page-property-values#last-edited-time
{
    [string] $last_edited_time

    notion_last_edited_time_page_property($value) : base("last_edited_time")
    {
        $this.last_edited_time = $value
    }

    static [notion_last_edited_time_page_property] ConvertFromObject($Value)
    {
        return [notion_last_edited_time_page_property]::new($Value.last_edited_time)
    }
}
