class notion_to_do
{
    [rich_text[]] $rich_text
    [bool] $checked = $false
    [notion_color] $color = "default"
    [notion_block[]] $children = @()
    # TODO: Implement addchildren

    notion_to_do([rich_text[]] $rich_text, [bool] $checked = $false, [notion_color] $color = "default")
    {
        $this.rich_text = $rich_text.rich_text.ForEach({ [rich_text]::ConvertFromObject($_) })
        $this.checked = $checked
        $this.color = $color
    }

    static [notion_to_do] ConvertFromObject ($Value)
    {
        return [notion_to_do]::new($Value.rich_text.ForEach({ [rich_text]::ConvertFromObject($_) }), $Value.checked, [Enum]::Parse([notion_color], $Value.color))
    }
}
class notion_to_do_block : notion_block
# https://developers.notion.com/reference/block#to-do
{
    [notion_blocktype] $type = "to_do"
    [notion_to_do] $to_do

    notion_to_do_block([rich_text[]] $rich_text, [bool] $checked = $false, [notion_color] $color = "default")
    {
        $this.to_do = [notion_to_do]::new($rich_text, $checked, $color)
    }

    static [notion_to_do_block] ConvertFromObject ($Value)
    {
        $To_do_Obj = [notion_to_do_block]::new()
        $To_do_Obj.to_do = [notion_to_do]::ConvertFromObject($Value.to_do)
        return $To_do_Obj
    }
}
