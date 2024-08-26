class To_do : Block
{
    [blocktype] $type = "to_do"
    [rich_text[]] $rich_text
    [bool] $checked = $false
    [notion_color] $color = "default"
    #[block[]] $children = $null

    #TODO: geht nicht
    static ConvertFromObject ($Value)
    {
        $todo = [To_do]::new()
        $todo.rich_text = [rich_text]::ConvertFromObject($Value.rich_text)
        $todo.checked = $Value.checked
        $todo.color = $Value.color
    }
}
