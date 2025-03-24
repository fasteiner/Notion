class notion_rich_text_page_property : PagePropertiesBase
# https://developers.notion.com/reference/page-property-values#rich-text
{
    [rich_text[]] $rich_text
    
    notion_rich_text_page_property([object[]]$text) : base("rich_text")
    {
        $this.rich_text = @()
        foreach ($t in $text)
        {
            if($t -is [rich_text])
            {
                $this.rich_text += $t
            }
            else
            {
                $this.rich_text += [rich_text]::ConvertFromObject($t)
            }
        }
    }

    add($text)
    {
        $this.rich_text += [rich_text]::new($text)
    }

    static [notion_rich_text_page_property] ConvertFromObject($Value)
    {
        return [notion_rich_text_page_property]::new($Value.rich_text)
    }
}
