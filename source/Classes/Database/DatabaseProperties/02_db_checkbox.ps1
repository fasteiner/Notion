class notion_checkbox_database_property : DatabasePropertiesBase
# https://developers.notion.com/reference/property-object#checkbox
{
    [hashtable] $checkbox

    notion_checkbox_database_property() : base("checkbox")
    {
        $this.checkbox = @{}
    }


    static [notion_checkbox_database_property] ConvertFromObject($Value)
    {
        return [notion_checkbox_database_property]::new()
    }
}
