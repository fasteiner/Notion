class paragraph_structure
{
    [rich_text[]] $rich_text
    [notion_color] $color = "default"
    [notion_block[]] $children = @()
    #TODO: Implement addchildren
    

    paragraph_structure()
    {
    }

    paragraph_structure([rich_text[]] $rich_text)
    {
        $this.rich_text = $rich_text
    }

    [void] addRichText([rich_text] $richtext)
    {
        $this.rich_text += $richtext
    }

    static [paragraph_structure] ConvertFromObject($Value)
    {
        $Paragraph = [paragraph_structure]::new()
        $Paragraph.rich_text = $Value.rich_text.ForEach({ [rich_text]::ConvertFromObject($_) })
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

    notion_paragraph_block([rich_text] $richtext)
    {
        $this.paragraph = [Paragraph_structure]::new(@($richtext))
    }

    [void] addRichText([rich_text] $richtext)
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
