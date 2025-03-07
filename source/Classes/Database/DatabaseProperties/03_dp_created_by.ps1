class notion_created_by_database_property : DatabasePropertiesBase
# https://developers.notion.com/reference/property-object#created-by
{
    [hashtable] $created_by
    
    notion_created_by_database_property() : base("created_by")
    {
        $this.created_by = @{}
    }

    static [notion_created_by_database_property] ConvertFromObject($Value)
    {
        $created_by_obj = [notion_created_by_database_property]::new()
        return $created_by_obj
    }
}
