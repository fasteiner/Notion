class title_property_base : PropertiesBase
{
    [rich_text[]] $title

    title_property_base() : base("title")
    {
        $this.title = @()
    }

    # Constructor
    title_property_base([object]$value) : base("title")
    {
        $this.title = @()
        if ($value -is [array])
        {
            foreach ($item in $value)
            {
                if ($item -is [rich_text])
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
    static [title_property_base] ConvertFromObject($Value)
    {
        Write-Verbose "[title_property_base]::ConvertFromObject($($Value | ConvertTo-Json -Depth 10))"
        return [title_property_base]::new($Value.title)
    }
}
