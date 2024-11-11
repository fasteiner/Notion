class rich_text
# https://developers.notion.com/reference/rich-text
{
    [rich_text_type] $type
    # object: text / mention / equation
    [annotation] $annotations
    [string] $plain_text = $null
    $href = $null

    # empty rich text object
    # [rich_text]::new()
    rich_text()
    {

    }
    rich_text([string] $type)
    {
        $this.type = [Enum]::Parse([rich_text_type], $type)
    }

    rich_text([rich_text_type] $type)
    {
        $this.type = $type
    }

    # rich text object with content and annotations
    # [rich_text]::new("Hallo", [annotation]::new())
    rich_text([rich_text_type] $type, [annotation] $annotations)
    {
        $this.type = $type
        $this.annotations = $annotations
    }
    rich_text([rich_text_type] $type, [annotation] $annotations, [string] $plain_text)
    {
        $this.type = $type
        $this.annotations = $annotations
        $this.plain_text = $plain_text
    }
    
    rich_text([rich_text_type] $type, [annotation] $annotations, [string] $plain_text, $href)
    {
        $this.type = $type
        $this.annotations = $annotations
        $this.plain_text = $plain_text
        $this.href = $href
    }

    static [rich_text] ConvertFromObject($Value)
    {
        Write-Verbose "[rich_text]::ConvertFromObject($($Value | ConvertTo-Json))"
        if(!$Value.type)
        {
            return $null
        }
        $rich_text = $null
        switch ($Value.type)
        {
            "text"
            {
                $rich_text = [rich_text_text]::ConvertFromObject($Value)
                break
            }
            "mention"
            {
                $rich_text = [rich_text_mention]::ConvertFromObject($Value)
                break
            }
            "equation"
            {
                $rich_text = [rich_text_equation]::ConvertFromObject($Value)
                break
            }
            default
            {
                Write-Error "Unknown rich text type: $($Value.type)" -Category InvalidData -TargetObject $Value -RecommendedAction "Please provide a valid rich text type (text, mention or equation)"
            }
        }
        $rich_text.annotations = [annotation]::ConvertFromObject($Value.annotations)
        $rich_text.plain_text = $Value.plain_text
        $rich_text.href = $Value.href
        return $rich_text
    }
}
