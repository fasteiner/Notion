class paragraph_structure
{
    [rich_text[]] $rich_text
    [notion_color] $color = "default"
    [notion_block[]] $children = @()
    

    paragraph_structure()
    {
    }

    paragraph_structure($rich_text)
    {
        $this.rich_text = [rich_text]::ConvertFromObjects($rich_text)
    }

    [void] addRichText($rich_text)
    {
        $this.rich_text += [rich_text]::ConvertFromObjects($rich_text)
    }

    static [paragraph_structure] ConvertFromObject($Value)
    {
        $Paragraph = [paragraph_structure]::new()
        $Paragraph.rich_text = [rich_text]::ConvertFromObjects($Value.rich_text)
        $Paragraph.color = [Enum]::Parse([notion_color], ($Value.color ?? "default"))
        return $Paragraph
    }
}
class notion_paragraph_block : notion_block
# https://developers.notion.com/reference/block#paragraph
{
    [notion_blocktype] $type = "paragraph"
    [Paragraph_structure] $paragraph

    notion_paragraph_block()
    {
        $this.paragraph = [Paragraph_structure]::new(@())
    }

    notion_paragraph_block($richtext)
    {
        $this.paragraph = [Paragraph_structure]::new($richtext)
    }

    [void] addRichText($richtext)
    {
        $this.paragraph = [Paragraph_structure]::addRichText($richtext)
    }

    static [notion_paragraph_block] ConvertFromObject($Value)
    {
        $Paragraph_Obj = [notion_paragraph_block]::new()
        $Paragraph_Obj.paragraph = [Paragraph_structure]::ConvertFromObject($Value.paragraph)
        return $Paragraph_Obj
    }
}
