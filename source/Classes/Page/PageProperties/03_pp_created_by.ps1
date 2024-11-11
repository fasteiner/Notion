class pp_created_by : PageProperties
# https://developers.notion.com/reference/page-property-values#created-by
{
    [user] $created_by
    
    pp_created_by($created_by)
    {
        $this.created_by = [user]::ConvertFromObject($created_by)
    }

    static [pp_created_by] ConvertFromObject($Value)
    {
        $pp_created_by = [pp_created_by]::new($Value.created_by)
        return $pp_created_by
    }
}
