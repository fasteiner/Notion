class notion_people_database_property : DatabasePropertiesBase
# https://developers.notion.com/reference/property-object#people
{
    [hashtable] $people

    notion_people_database_property() : base("people")
    {
        $this.people = @{}
        
    }

    static [notion_people_database_property] ConvertFromObject($Value)
    {
        return [notion_people_database_property]::new()
    }
}
