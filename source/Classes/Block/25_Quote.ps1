class Quote_structure
{
    [rich_text[]] $rich_text
    [notion_color] $color = "default"
    [notion_block[]] $children = @()

    #TODO: Implement addchildren
    Quote_structure()
    {
    }

    Quote_structure($rich_text, $color = "default")
    {
        $this.rich_text = [rich_text]::ConvertFromObjects($rich_text)
        $this.color = [Enum]::Parse([notion_color], $color)
    }

    static [Quote_structure] ConvertFromObject($Value)
    {
        return [Quote_structure]::new( $Value.rich_text, $Value.color ?? "default" )
    }
}

class notion_quote_block : notion_block
# https://developers.notion.com/reference/block#quote
{
    [notion_blocktype] $type = "quote"
    [Quote_structure] $quote

    notion_quote_block()
    {
    }

    notion_quote_block( $rich_text, $color)
    {
        $this.quote = [Quote_structure]::new($rich_text, $color)
    }

    static [notion_quote_block] ConvertFromObject($Value)
    {
        $Quote_Obj = [notion_quote_block]::new()
        $Quote_Obj.quote = [Quote_structure]::ConvertFromObject($Value.quote)
        return $Quote_Obj
    }
}
