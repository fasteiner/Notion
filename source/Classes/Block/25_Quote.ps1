class Quote_structure
{
    [rich_text[]] $rich_text
    [notion_color] $color = "default"
    [block[]] $children = @()

    #TODO: Implement addchildren
    Quote_structure([rich_text[]] $rich_text, [notion_color] $color = "default")
    {
        $this.rich_text = @($rich_text)
        $this.color = $color
    }

    static [Quote_structure] ConvertFromObject($Value)
    {
        return [Quote_structure]::new($Value.rich_text.ForEach({[rich_text]::ConvertFromObject($_)}), $Value.color)
    }
}

class Quote : block
# https://developers.notion.com/reference/block#quote
{
    [blocktype] $type = "quote"
    [Quote_structure] $quote

    Quote ()
    {}

    Quote([rich_text[]] $rich_text, [notion_color] $color)
    {
        $this.quote = [Quote_structure]::new($rich_text, $color)
    }

    static [Quote] ConvertFromObject($Value)
    {
        $Quote_Obj = [Quote]::new()
        $Quote_Obj.quote = [Quote_structure]::ConvertFromObject($Value.quote)
        return $Quote_Obj
    }
}
