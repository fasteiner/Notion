class notion_title_page_property : PagePropertiesBase
# https://developers.notion.com/reference/page-property-values#title
{
    [rich_text[]] $title = @()

    # Constructor
    notion_title_page_property([object[]]$value)
    {
        foreach($item in $value)
        {
            if($item -is [rich_text])
            {
                $this.title += $item
            }
            else
            {
                $this.title += [rich_text]::ConvertFromObject($item)
            }
        }
        
    }
    #Methods
    add($value)
    {
        $this.title += [rich_text]::new("text", $null, $Value)
    }

    #TODO Array of rich_text?
    static [notion_title_page_property] ConvertFromObject($Value)
    {
        return [notion_title_page_property]::new($Value)
    }
}
