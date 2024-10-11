class pp_phone_number : PageProperties
# https://developers.notion.com/reference/page-property-values#phone-number
{
    [string] $phone_number

    pp_phone_number($phone_number)
    {
        $this.phone_number = $phone_number
    }

    static [pp_phone_number] ConvertFromObject($Value)
    {
        return [pp_phone_number]::new($Value.phone_number)
    }   
}
