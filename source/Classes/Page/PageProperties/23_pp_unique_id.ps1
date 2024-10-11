class pp_unique_id : PageProperties
# https://developers.notion.com/reference/page-property-values#unique-id
{
    [int] $number
    [string] $type = "unique_id"
    [string] $prefix = $null

    pp_unique_id($number)
    {
        $this.number = $number
    }
    
    pp_unique_id($number, $prefix)
    {
        $this.number = $number
        $this.prefix = $prefix
    }

    static [pp_unique_id] ConvertFromObject($Value)
    {
        return [pp_unique_id]::new($Value)
    }
}
