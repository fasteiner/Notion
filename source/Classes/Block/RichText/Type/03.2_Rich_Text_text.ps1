class rich_text_text : rich_text
{
    [string] $content = ""
    [string] $link = $null

    rich_text_text()
    {
        $this.content = ""
        $this.link = $null
    }

    rich_text_text($content)
    {
        $this.content = $content
        $this.link = $null
    }

    rich_text_text($content, $link)
    {
        $this.content = $content
        $this.link = $link
    }

    static [rich_text_text] ConvertFromObject($Value)
    {
        $rich_text_text = [rich_text_text]::new()
        $rich_text_text.content = $Value.content
        $rich_text_text.link = $Value.link
        return $rich_text_text
    }
}
