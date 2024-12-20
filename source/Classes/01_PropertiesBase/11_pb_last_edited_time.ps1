class last_edited_time_property_base : PropertiesBase
{
    [string] $last_edited_time

    last_edited_time_property_base($value) : base("last_edited_time")
    {
        $this.last_edited_time = ConvertTo-TSNotionFormattedDateTime -InputDate $value -fieldName "last_edited_time"
    }

    static [last_edited_time_property_base] ConvertFromObject($Value)
    {
        return [last_edited_time_property_base]::new($Value.last_edited_time)
    }
}
