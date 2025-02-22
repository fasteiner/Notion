class notion_last_edited_time_database_property : DatabasePropertiesBase
# https://developers.notion.com/reference/property-object#last-edited-time
{
    [hashtable] $last_edited_time

    notion_last_edited_time_database_property() : base("last_edited_time")
    {
        $this.last_edited_time = @{}
    }

    static [notion_last_edited_time_database_property] ConvertFromObject($Value)
    {
        return [notion_last_edited_time_database_property]::new()
    }
}
