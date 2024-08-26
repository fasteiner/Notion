class pp_date : PageProperties
{
    $type = "date"
    $date
    pp_date($date)
    {
        $this.date = [pp_dateProperty]::new($date)
    }
}
