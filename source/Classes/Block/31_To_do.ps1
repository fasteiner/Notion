class To_do_structure
{
    [rich_text[]] $rich_text
    [bool] $checked = $false
    [notion_color] $color = "default"
    [block[]] $children = @()
    # TODO: Implement addchildren

    To_do_structure([rich_text[]] $rich_text, [bool] $checked = $false, [notion_color] $color = "default")
    {
        $this.rich_text = $rich_text.rich_text.ForEach({ [rich_text]::ConvertFromObject($_) })
        $this.checked = $checked
        $this.color = $color
    }

    static [To_do_structure] ConvertFromObject ($Value)
    {
        return [To_do_structure]::new($Value.rich_text.ForEach({ [rich_text]::ConvertFromObject($_) }), $Value.checked, [Enum]::Parse([notion_color], $Value.color))
    }
}
class To_do : block
# https://developers.notion.com/reference/block#to-do
{
    [blocktype] $type = "to_do"
    [To_do_structure] $to_do

    To_do([rich_text[]] $rich_text, [bool] $checked = $false, [notion_color] $color = "default")
    {
        $this.to_do = [To_do_structure]::new($rich_text, $checked, $color)
    }

    static [To_do] ConvertFromObject ($Value)
    {
        $To_do_Obj = [To_do]::new()
        $To_do_Obj.to_do = [To_do_structure]::ConvertFromObject($Value.to_do)
        return $To_do_Obj
    }
}
