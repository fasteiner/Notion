class pp_select : PageProperties
{
    [string]$type = "select"
    [PSCustomObject]$select
    pp_select ($name)
    {
        $this.select = [pp_nameProperty]::new($name)
    }
}
