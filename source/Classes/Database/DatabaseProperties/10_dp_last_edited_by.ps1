class notion_last_edited_by_database_property : DatabasePropertiesBase
# https://developers.notion.com/reference/property-object#last-edited-by
{
    [hashtable] $last_edited_by

    notion_last_edited_by_database_property() : base("last_edited_by")
    {
        $this.last_edited_by = @{}
    }

    static [notion_last_edited_by_database_property] ConvertFromObject($Value)
    {
        return [notion_last_edited_by_database_property]::new()
    }
}
