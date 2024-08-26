class Quote : Block
{
    [blocktype] $type = "quote"
    [rich_text[]] $rich_text
    [notion_color] $color = "default"


    static ConvertFromObject($Value)
    {
        $quote = [quote]::new()
        $quote.rich_text = [rich_text]::ConvertFromObject($Value.rich_text)
        $quote.color = $Value.color
    }
}
