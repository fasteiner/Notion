class checkbox_property_base : PropertiesBase
{
    [bool] $checkbox = $false

    checkbox_property_base([bool]$checkbox) : base("checkbox")
    {
        $this.checkbox = $checkbox
    }

    static [checkbox_property_base] ConvertFromObject($Value)
    {
        $checkbox_property_base = [checkbox_property_base]::new($Value.checkbox)
        return $checkbox_property_base
    }
}
