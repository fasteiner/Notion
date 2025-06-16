class rich_text
# https://developers.notion.com/reference/rich-text
{
    [notion_rich_text_type] $type
    # object: text / mention / equation
    [notion_annotation] $annotations
    [string] $plain_text = $null
    $href = $null

    # empty rich text object
    # [rich_text]::new()
    rich_text()
    {

    }
    rich_text([string] $type)
    {
        $this.type = [Enum]::Parse([notion_rich_text_type], $type)
    }

    rich_text([notion_rich_text_type] $type)
    {
        $this.type = $type
    }

    # rich text object with content and annotations
    # [rich_text]::new("Hallo", [notion_annotation]::new())
    #BUG ?? sollte das nicht mit test moeglich sein ??
    rich_text([notion_rich_text_type] $type, [notion_annotation] $annotations)
    {
        $this.type = $type
        $this.annotations = $annotations
    }
    rich_text([notion_rich_text_type] $type, [notion_annotation] $annotations, [string] $plain_text)
    {
        if ($plain_text.Length -gt 2000)
        {
            throw [System.ArgumentException]::new("The plain text must be 2000 characters or less.")
        }
        $this.type = $type
        $this.annotations = $annotations
        $this.plain_text = $plain_text
    }
    
    rich_text([notion_rich_text_type] $type, [notion_annotation] $annotations, [string] $plain_text, $href)
    {
        if ($plain_text.Length -gt 2000)
        {
            throw [System.ArgumentException]::new("The plain text must be 2000 characters or less.")
        }
        if ($href.Length -gt 2000)
        {
            throw [System.ArgumentException]::new("The href must be 2000 characters or less.")
        }
        $this.type = $type
        $this.annotations = $annotations
        $this.plain_text = $plain_text
        $this.href = $href
    }

    static [rich_text[]] ConvertFromObjects([object] $Value)
    {
        if ($Value -isnot [array])
        {
            $Value = @($Value)
        }
        $output = @()
        foreach ($item in $Value)
        {
            if ($item -isnot [rich_text])
            {
                if ($item -is [string])
                {
                    $item = [rich_text_text]::new($item)
                }
                else
                {
                    $item = [rich_text]::ConvertFromObject($item)
                }
            }
            $output += $item
        }
        return $output
    }


    static [rich_text] ConvertFromObject($Value)
    {
        Write-Verbose "[rich_text]::ConvertFromObject($($Value | ConvertTo-Json))"
        if (!$Value.type)
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
        $local:annotations = [notion_annotation]::ConvertFromObject($Value.annotations)
        if ($local:annotations)
        {
            $rich_text.annotations = $local:annotations
        }
        $rich_text.plain_text ??= $Value.plain_text
        $rich_text.href = $Value.href
        return $rich_text
    }
}
