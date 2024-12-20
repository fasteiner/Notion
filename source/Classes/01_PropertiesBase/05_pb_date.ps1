class date_property_base_structure  : PropertiesBase
{
    [string] $end
    [string] $start

    date_property_base_structure() : base("date")
    {
    }

    date_property_base_structure($start, $end) : base("date")
    {
        $this.start = ConvertTo-TSNotionFormattedDateTime -InputDate $start -fieldName "start"
        #end is optional
        if ($end)
        {
            $this.end = ConvertTo-TSNotionFormattedDateTime -InputDate $end -fieldName "end"
        }
    }

    static [date_property_base_structure] ConvertFromObject($Value)
    {
        $date_page_obj = [date_property_base_structure]::new($Value.start, $Value.end)
        return $date_page_obj
    }
}
class date_property_base : date_property_base_structure
{
    [date_property_base_structure] $date

    date_property_base() : base("date")
    {
        $this.date = [date_property_base_structure]::new()
    }

    date_property_base($start, $end) : base("date")
    {
        $this.date = [date_property_base_structure]::new($start, $end)
    }

    static [date_property_base] ConvertFromObject($Value)
    {
        return [date_property_base]::new($Value.date.start, $Value.date.end)
    }
    
}
