class pp_number : PageProperties
# https://developers.notion.com/reference/page-property-values#number
{
    $number

    pp_number($number)
    {
        $this.number = $number
    }
}
