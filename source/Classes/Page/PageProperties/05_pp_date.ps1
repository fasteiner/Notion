class pp_date : PageProperties
# https://developers.notion.com/reference/page-property-values#date
{
    [string] $end
    [string] $start

    pp_date($start, $end)
    {
        $this.start = Get-Date $start -Format "yyyy-MM-ddTHH:mm:ss.fffZ" -AsUTC
        $this.end = Get-Date $end -Format "yyyy-MM-ddTHH:mm:ss.fffZ" -AsUTC
    }

    static [pp_date] ConvertFromObject($Value)
    {
        $pp_date = [pp_date]::new($Value.start, $Value.end)
        return $pp_date
    }
}
