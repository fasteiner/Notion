class Paragraph
{
    #[blocktype] $type = "paragraph"
    [rich_text[]] $rich_text
    [notion_color] $color = "default"
    #[block] $children = $null

    [void] addRichText([rich_text] $richtext)
    {
        $this.rich_text += $richtext
    }
}
