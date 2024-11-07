class To_do : block
# https://developers.notion.com/reference/block#to-do
{
    [blocktype] $type = "to_do"
    [rich_text[]] $rich_text
    [bool] $checked = $false
    [notion_color] $color = "default"
    #[block[]] $children = $null

    static [To_do] ConvertFromObject ($Value)
    {
        $todo = [To_do]::new()
        $todo.rich_text = $Value.rich_text.ForEach({[rich_text]::ConvertFromObject($_)})
        $todo.checked = $Value.checked
        $todo.color = [Enum]::Parse([notion_color], $Value.color)
        return $todo
    }
}
