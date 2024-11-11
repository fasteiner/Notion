class pp_last_edited_by : PageProperties
# https://developers.notion.com/reference/page-property-values#last-edited-by
{
    [user] $last_edited_by

    pp_last_edited_by($value)
    {
        $this.last_edited_by = [user]::ConvertFromObject($value)
    }

    static [pp_last_edited_by] ConvertFromObject($Value)
    {
        return [pp_last_edited_by]::new($Value.last_edited_by)
    }
}
