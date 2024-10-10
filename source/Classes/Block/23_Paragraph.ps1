class Paragraph : Block
# https://developers.notion.com/reference/block#paragraph
{
    #[blocktype] $type = "paragraph"
    [rich_text[]] $rich_text
    [notion_color] $color = "default"


    [void] addRichText([rich_text] $richtext)
    {
        $this.rich_text += $richtext
    }

    static [Paragraph] ConvertFromObject($Value)
    {
        $Paragraph = [Paragraph]::new()
        $Paragraph.rich_text = [rich_text]::ConvertFromObject($Value.rich_text)
        return $Paragraph
    }
}
