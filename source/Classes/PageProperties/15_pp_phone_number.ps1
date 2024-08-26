class pp_phone_number : PageProperties
{
    $type = "phone_number"
    [string] $phone_number

    pp_phone_number($phone_number)
    {
        $this.phone_number = $phone_number
    }
}
