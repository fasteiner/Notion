class Quote : block
# https://developers.notion.com/reference/block#quote
{
    [blocktype] $type = "quote"
    [rich_text[]] $rich_text
    [notion_color] $color = "default"


    static [Quote] ConvertFromObject($Value)
    {
        $quote = [quote]::new()
        $quote.rich_text = $Value.rich_text.ForEach({[rich_text]::ConvertFromObject($_)})
        $quote.color = $Value.color
        return $quote
    }
}
