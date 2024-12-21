class notion_number_database_property : DatabasePropertiesBase
# https://developers.notion.com/reference/property-object#number
{
    [double] $number

    notion_number_database_property($number) : base("number")
    {
        $this.number = [double]$number
    }

    static [notion_number_database_property] ConvertFromObject($Value)
    {
        return [notion_number_database_property]::new($Value.number)
    }
}
