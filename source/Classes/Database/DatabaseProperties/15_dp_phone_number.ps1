class notion_phone_number_database_property : DatabasePropertiesBase
# https://developers.notion.com/reference/property-object#phone-number
{
    [hashtable] $phone_number

    notion_phone_number_database_property() : base("phone_number")
    {
        $this.phone_number = @{}
    }

    static [notion_phone_number_database_property] ConvertFromObject($Value)
    {
        return [notion_phone_number_database_property]::new()
    }   
}
