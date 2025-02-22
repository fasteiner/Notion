
class notion_date_database_property : DatabasePropertiesBase
{
    # https://developers.notion.com/reference/property-object#date
    [hashtable] $date

    notion_date_database_property() : base("date")
    {
        $this.date = @{}
    }

    static [notion_date_database_property] ConvertFromObject($Value)
    {
        return [notion_date_database_property]::new()
    }
    
}
