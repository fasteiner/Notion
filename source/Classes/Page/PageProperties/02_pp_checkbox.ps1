class pp_checkbox : PageProperties
# https://developers.notion.com/reference/page-property-values#checkbox
{
    [bool] $checkbox = $false

    pp_checkbox($checkbox)
    {
        $this.checkbox = $checkbox
    }


    static [pp_checkbox] ConvertFromObject($Value)
    {
        $pp_checkbox = [pp_checkbox]::new($Value.checkbox)
        return $pp_checkbox
    }
}
