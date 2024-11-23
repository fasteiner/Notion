class notion_date_page_property : PagePropertiesBase
# https://developers.notion.com/reference/page-property-values#date
{
    [string] $end
    [string] $start

    notion_date_page_property($start, $end) : base("date")
    {
        $this.start = Get-Date $start -Format "yyyy-MM-ddTHH:mm:ss.fffZ" -AsUTC
        $this.end = Get-Date $end -Format "yyyy-MM-ddTHH:mm:ss.fffZ" -AsUTC
    }

    static [notion_date_page_property] ConvertFromObject($Value)
    {
        $date_page_obj = [notion_date_page_property]::new($Value.start, $Value.end)
        return $date_page_obj
    }
}
