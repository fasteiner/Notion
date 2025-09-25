#https://developers.notion.com/reference/rich-text#text
class rich_text_text_structure
{
    [string] $content = ""
    $link

    rich_text_text_structure()
    {
        $this.content = ""
        $this.link = $null
    }
    
    rich_text_text_structure([string]$content )
    {
        $this.content = $content
        $this.link = $null
    }

    
    rich_text_text_structure([string]$content, [string]$link)
    {
        $this.content = $content
        $this.link = $link
    }

    static [rich_text_text_structure] ConvertFromObject($Value)
    {
        Write-Verbose "[rich_text_text_structure]::ConvertFromObject($($Value | ConvertTo-Json -Depth 5))"
        if ($Value -is [rich_text_text])
        {
            return $Value
        }
        $rich_text_text_structure = [rich_text_text_structure]::new()
        if ($Value -is [string])
        {
            $rich_text_text_structure.content = $Value
            return $rich_text_text_structure
        }
        $rich_text_text_structure.content = $Value.content
        $rich_text_text_structure.link = $Value.link
        return $rich_text_text_structure
    }
}


class rich_text_text : rich_text
{
    [rich_text_text_structure] $text

    # Default constructor
    rich_text_text() : base("text")
    {
    }
    

    # Constructor with rich_text_text_structure parameter
    rich_text_text($content) : base("text")
    {
        if ($null -eq $content)
        {
            $this.text = [rich_text_text_structure]::new()
            $this.plain_text = ""
        }
        elseif ($content -is [string])
        {
            $this.text = [rich_text_text_structure]::new($content)
            $this.plain_text = $content
        }
        elseif ($content -is [datetime] -or $content -is [int] -or $content -is [double] -or $content -is [bool])
        {
            $this.text = [rich_text_text_structure]::new($content.ToString())
            $this.plain_text = $content.ToString()
        }
        elseif ($content -is [rich_text_text_structure])
        {
            $this.text = $content
            $this.plain_text = $content.content
        }
        else
        {
            $this.text = [rich_text_text_structure]::ConvertFromObject($content)
            $this.plain_text = $content.content
        }
    }

    # Constructor with content string and annotations
    rich_text_text([string] $content, $annotations) : base("text", $annotations)
    {
        $this.text = [rich_text_text_structure]::new($content)
        $this.plain_text = $content
    }

    # Constructor with content string, annotations, and link
    rich_text_text([string] $content, $annotations, $href) : base("text", $annotations)
    {
        $this.text = [rich_text_text_structure]::new($content)
        $this.plain_text = $content
        $this.href = $href
    }

    # [string] ToJson([bool]$compress = $false) {
    #     $json = @{
    #         type = $this.type
    #         text = $this.text.ToJson()
    #         annotations = $this.annotations.ToJson()
    #         plain_text = $this.plain_text
    #         href = $this.href
    #     }
    #     return $json | ConvertTo-Json -Compress:$compress
    # }

    static [rich_text_text] ConvertFromObject($Value)
    {
        Write-Verbose "[rich_text_text]::ConvertFromObject($($Value | ConvertTo-Json -Depth 5))"
        if ($Value -is [rich_text_text])
        {
            return $Value
        }
        
        $rich_text = [rich_text_text]::new()
        if ($Value -is [string])
        {
            $rich_text.text = [rich_text_text_structure]::new($Value)
            $rich_text.plain_text = $Value
            return $rich_text
        }
        $rich_text.text = [rich_text_text_structure]::ConvertFromObject($Value.text)
        $rich_text.plain_text = $rich_text.text.content
        return $rich_text
    }
}
