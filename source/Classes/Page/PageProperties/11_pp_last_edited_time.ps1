class pp_last_edited_time : PageProperties
# https://developers.notion.com/reference/page-property-values#last-edited-time
{
    [string] $last_edited_time

    pp_last_edited_time($value)
    {
        $this.last_edited_time = $value
    }

    static [pp_last_edited_time] ConvertFromObject($Value)
    {
        return [pp_last_edited_time]::new($Value.last_edited_time)
    }
}
