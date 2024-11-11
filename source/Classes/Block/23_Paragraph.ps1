class Paragraph_structure
{
    [rich_text[]] $rich_text
    [notion_color] $color = "default"
    [block[]] $children = @()
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

    static [Paragraph] ConvertFromObject($Value)
    {
        $Paragraph = [Paragraph]::new()
        $Paragraph.rich_text = $Value.rich_text.ForEach({ [rich_text]::ConvertFromObject($_) })
        return $Paragraph
    }
}
class Paragraph : block
# https://developers.notion.com/reference/block#paragraph
{
    [blocktype] $type = "paragraph"
    [Paragraph_structure] $paragraph

    paragraph()
    {
        $this.paragraph = [Paragraph_structure]::new(@())
    }

    paragraph([rich_text] $richtext)
    {
        $this.paragraph = [Paragraph_structure]::new(@($richtext))
    }

    [void] addRichText([rich_text] $richtext)
    {
        $this.paragraph = [Paragraph_structure]::addRichText($richtext)
    }

    static [Paragraph] ConvertFromObject($Value)
    {
        $Paragraph_Obj = [Paragraph]::new()
        $Paragraph_Obj.paragraph = [Paragraph_structure]::ConvertFromObject($Value.paragraph)
        return $Paragraph_Obj
    }
}
