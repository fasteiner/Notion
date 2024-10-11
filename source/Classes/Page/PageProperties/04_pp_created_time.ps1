class pp_created_time : PageProperties
# https://developers.notion.com/reference/page-property-values#created-time
{
    [string] $created_time

    pp_created_time()
    {
        $this.created_time = Get-Date -Format "yyyy-MM-ddTHH:mm:ss.fffZ" -AsUTC
    }

    static [pp_created_time] ConvertFromObject($Value)
    {
        $pp_created_time = [pp_created_time]::new()
        $pp_created_time.created_time = $Value.created_time
        return $pp_created_time
    }
}
