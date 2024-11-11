class pp_number : PageProperties
# https://developers.notion.com/reference/page-property-values#number
{
    [double] $number

    pp_number($number)
    {
        $this.number = [double]$number
    }

    static [pp_number] ConvertFromObject($Value)
    {
        return [pp_number]::new($Value.number)
    }
}
