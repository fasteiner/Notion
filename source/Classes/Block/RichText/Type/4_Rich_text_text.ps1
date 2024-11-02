#https://developers.notion.com/reference/rich-text#text
class rich_text_text_structure
{
    [string] $content = ""
    [string] $link = $null

    rich_text_text_structure()
    {
        $this.content = ""
        $this.link = $null
    }

    rich_text_text_structure($content)
    {
        $this.content = $content
        $this.link = $null
    }

    rich_text_text_structure($content, $link)
    {
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


class rich_text_text : rich_text{
    [rich_text_text_structure] $text
    
    rich_text_text():base("text")
    {
    }
    
    rich_text_text([rich_text_text_structure] $text) :base("text")
    {
        $this.text = $text
    }
    
    rich_text_text([string] $content) :base("text")
    {
        $this.text = [rich_text_text_structure]::new($content)
        $this.plain_text = $content
    }
    rich_text_text([string] $content, $annotations) :base("text", $annotations)
    {
        $this.text = [rich_text_text_structure]::new($content)
        $this.plain_text = $content
    }
    rich_text_text([string] $content, $annotations,$plain_text) :base("text", $annotations, $plain_text)
    {
        $this.text = [rich_text_text_structure]::new($content)
    }

    [string] ToJson([bool]$compress = $false)
    {
        $json = @{
            type = $this.type
            text = $this.text.ToJson()
            annotations = $this.annotations.ToJson()
            plain_text = $this.plain_text
            href = $this.href
        }
        return $json | ConvertTo-Json -Compress:$compress
    }
    
    static [rich_text_text] ConvertFromObject($Value)
    {
        $rich_text = [rich_text_text]::new()
        $rich_text.text = [rich_text_text_structure]::ConvertFromObject($Value.text)
        return $rich_text
    }
}
