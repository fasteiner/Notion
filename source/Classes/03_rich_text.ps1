class rich_text
{
    [rich_text_type] $type = "text"
    $text = @{
        "content" = ""
        "link"    = $null
    }
    [annotation] $annotations = [annotation]::new()
    [string] $plain_text = $null
    $href = $null

    # empty rich text object
    # [rich_text]::new()
    rich_text()
    {
        $this.text = @{
            "content" = ""
            "link"    = $null
        }
        $this.plain_text = $this.text.content
    }

    # rich text object with content
    # [rich_text]::new("Hallo")
    rich_text([string] $content)
    {
        $this.text = @{
            "content" = $content
            "link"    = $null
        }
        $this.plain_text = $this.text.content
    }

    # rich text object with content and annotations
    # [rich_text]::new("Hallo", [annotation]::new())
    rich_text([string] $content, [annotation] $annotations)
    {
        $this.text = @{
            "content" = $content
            "link"    = $null
        }
        $this.plain_text = $this.text.content
        $this.annotations = $annotations
    }
    [string] ToJson([bool]$compress = $false)
    {
        $out = @{
            rich_text = $this
        }
        return $out | ConvertTo-Json -Depth 10 -compress:$compress
    }

}
