class rich_text_property_base : PropertiesBase
{
    # $type = "rich_text"
    [rich_text[]] $rich_text
    
    rich_text_property_base([object[]]$text) : base("rich_text")
    {
        $this.rich_text = @()
        foreach ($t in $text)
        {
            if ($t -is [rich_text])
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

    static [rich_text_property_base] ConvertFromObject($Value)
    {
        return [rich_text_property_base]::new($Value.rich_text)
    }
}
