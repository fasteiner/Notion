class created_time_property_base : PropertiesBase
{
    [datetime] $created_time
    
    created_time_property_base() : base("created_time")
    {
        $this.created_time = Get-Date -Format "yyyy-MM-ddTHH:mm:ss.fffZ" -AsUTC
    }

    created_time_property_base([datetime]$created_time) : base("created_time")
    {
        $this.created_time = ConvertTo-TSNotionFormattedDateTime -InputDate $created_time -fieldName "created_time"
    }

    static [created_time_property_base] ConvertFromObject($Value)
    {
        $created_time_obj = [created_time_property_base]::new()
        $created_time_obj.created_time = $Value.created_time
        return $created_time_obj
    }
}
