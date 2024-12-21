class notion_status_database_property : DatabasePropertiesBase
#https://developers.notion.com/reference/property-object#status
{
    [notion_status[]] $status

    notion_status_database_property() : base("status")
    {
        $this.status = @()
    }

    static [notion_status_database_property] ConvertFromObject($Value)
    {
        $notion_status_database_property_obj = [notion_status_database_property]::new()
        $notion_status_database_property_obj.status = $value.status.ForEach({[notion_status]::ConvertFromObject($_)})
        return $notion_status_database_property_obj
    }
}
