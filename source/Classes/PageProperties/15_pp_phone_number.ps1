class pp_phone_number : PageProperties
# https://developers.notion.com/reference/page-property-values#phone-number
{
    $type = "phone_number"
    [string] $phone_number

    pp_phone_number($phone_number)
    {
        $this.phone_number = $phone_number
    }
}
