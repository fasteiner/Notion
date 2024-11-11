class pp_title : PageProperties
# https://developers.notion.com/reference/page-property-values#title
{
    [rich_text[]] $title = @()

    # Constructor
    pp_title($value)
    {
        $this.title = [rich_text]::new("text", $null, $Value)
        
    }
    #Methods
    add($value)
    {
        $this.title += [rich_text]::new("text", $null, $Value)
    }

    #TODO Array of rich_text?
    static [pp_title] ConvertFromObject($Value)
    {
        return [pp_title]::new($Value)
    }
}
