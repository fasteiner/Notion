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
}
