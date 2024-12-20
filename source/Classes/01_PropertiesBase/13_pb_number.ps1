class number_property_base : PropertiesBase
{
    [double] $number

    number_property_base($number) : base("number")
    {
        $this.number = [double]$number
    }

    static [number_property_base] ConvertFromObject($Value)
    {
        return [number_property_base]::new($Value.number)
    }
}
