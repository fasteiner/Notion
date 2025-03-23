class notion_created_time_database_property : DatabasePropertiesBase
# https://developers.notion.com/reference/property-object#created-time
{
    [hashtable] $created_time

    notion_created_time_database_property() : base("created_time")
    {
        $this.created_time = @{}
    }


    static [notion_created_time_database_property] ConvertFromObject($Value)
    {
        return [notion_created_time_database_property]::new()
    }
}
