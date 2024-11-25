class notion_title_page_property : PagePropertiesBase
# https://developers.notion.com/reference/page-property-values#title
{
    [rich_text[]] $title

    notion_title_page_property() : base("title")
    {
        $this.title = @()
    }

    # Constructor
    notion_title_page_property([object]$value) : base("title")
    {
        $this.title = @()
        if($value -is [array])
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
        else
        {
            $this.title += [rich_text]::ConvertFromObject($value)
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
        Write-Verbose "[notion_title_page_property]::ConvertFromObject($($Value | ConvertTo-Json -Depth 10))"
        return [notion_title_page_property]::new($Value.title)
    }
}
