class rich_text
{
    [rich_text_type] $type = "text"
    $text = [rich_text_content]::new()
    [annotation] $annotations = [annotation]::new()
    [string] $plain_text = $null
    $href = $null

    # empty rich text object
    # [rich_text]::new()
    rich_text()
    {
        $this.text = [rich_text_content]::new()
        $this.plain_text = $this.text.content
    }

    # rich text object with content
    # [rich_text]::new("Hallo")
    rich_text([string] $content)
    {
        $this.text = [rich_text_content]::new($content)
        $this.plain_text = $this.text.content
    }

    # rich text object with content and annotations
    # [rich_text]::new("Hallo", [annotation]::new())
    rich_text([string] $content, [annotation] $annotations)
    {
        $this.text = [rich_text_content]::new($content)
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

    static ConvertFromObject($Value)
    {
        $rich_text = [rich_text]::new()
        $rich_text.text = [rich_text_content]::new($Value.text.content, $Value.text.link)
        $rich_text.annotations = [annotation]::ConvertFromObject($Value.annotations)
        $rich_text.plain_text = $Value.plain_text
        $rich_text.href = $Value.href
    }
}
