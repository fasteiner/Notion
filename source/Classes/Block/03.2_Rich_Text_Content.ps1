class rich_text_content
{
    [string] $content = ""
    [string] $link = $null

    rich_text_content()
    {
        $this.content = ""
        $this.link = $null
    }

    rich_text_content($content)
    {
        $this.content = $content
        $this.link = $null
    }

    rich_text_content($content, $link)
    {
        $this.content = $content
        $this.link = $link
    }

    static [rich_text_content] ConvertFromObject($Value)
    {
        $rich_text_content = [rich_text_content]::new()
        $rich_text_content.content = $Value.content
        $rich_text_content.link = $Value.link
        return $rich_text_content
    }
}
