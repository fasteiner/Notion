#https://developers.notion.com/reference/rich-text#text
class rich_text_text_structure
{
    [string] $content = ""
    [string] $link = $null

    rich_text_text_structure()
    {
    }
    
    rich_text_text_structure([string]$content )
    {
        $this.content = $content
        $this.link = $null
    }

    
    rich_text_text_structure([string]$content = "", [string]$link = $null) {
        $this.content = $content
        $this.link = $link
    }

    [string] ToJson([bool]$compress = $false)
    {
        $json = @{
            content = $this.content
            link = $this.link
        }
        return $json | ConvertTo-Json -Compress:$compress
    }

    static [rich_text_text_structure] ConvertFromObject($Value)
    {
        $rich_text_text_structure = [rich_text_text_structure]::new()
        $rich_text_text_structure.content = $Value.content
        $rich_text_text_structure.link = $Value.link
        return $rich_text_text_structure
    }
}


class rich_text_text : rich_text {
    [rich_text_text_structure] $text

    # Default constructor
    rich_text_text() : base("text") {
    }
    
    # Constructor with content string only
    rich_text_text([string] $text) : base("text") {
        $this.text = [rich_text_text_structure]::new($text)
        $this.plain_text = $text
    }

    # Constructor with rich_text_text_structure parameter
    rich_text_text([rich_text_text_structure] $content) : base("text") {
        $this.text = $content
        $this.plain_text = $content.content
    }

    # Constructor with content string and annotations
    rich_text_text([string] $content, $annotations) : base("text", $annotations) {
        $this.text = [rich_text_text_structure]::new($content)
        $this.plain_text = $content
    }

    # Constructor with content string, annotations, and plain_text
    rich_text_text([string] $content, $annotations, $plain_text) : base("text", $annotations, $plain_text) {
        $this.text = [rich_text_text_structure]::new($content)
    }

    [string] ToJson([bool]$compress = $false) {
        $json = @{
            type = $this.type
            text = $this.text.ToJson()
            annotations = $this.annotations.ToJson()
            plain_text = $this.plain_text
            href = $this.href
        }
        return $json | ConvertTo-Json -Compress:$compress
    }

    static [rich_text_text] ConvertFromObject($Value) {
        $rich_text = [rich_text_text]::new()
        $rich_text.text = [rich_text_text_structure]::ConvertFromObject($Value.text)
        $rich_text.plain_text = $Value.plain_text ?? $Value.text.content
        return $rich_text
    }
}
