class Toggle : Block
# https://developers.notion.com/reference/block#toggle-blocks
{
    [blocktype] $type = "toggle"
    [rich_text[]] $rich_text
    [notion_color] $color = "default"


    static [Toggle] ConvertFromObject($Value)
    {
        $toggle = [Toggle]::new()
        $toggle.rich_text = [rich_text]::ConvertFromObject($Value.rich_text)
        $toggle.color = [Enum]::Parse([notion_color], $Value.color)
        return $toggle
    }
}  
