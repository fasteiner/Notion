class phone_number_property_base : PropertiesBase
{
    [string] $phone_number

    phone_number_property_base($phone_number) : base("phone_number")
    {
        if ($phone_number.Length -gt 200)
        {
            throw [System.ArgumentException]::new("The phone number must be 200 characters or less.")
        }
        $this.phone_number = $phone_number
    }

    static [phone_number_property_base] ConvertFromObject($Value)
    {
        return [phone_number_property_base]::new($Value.phone_number)
    }   
}
