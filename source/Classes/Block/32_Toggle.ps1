class Toggle_structure
{
    [rich_text[]] $rich_text
    [notion_color] $color = "default"
    [block[]] $children = @()
    #TODO: Implement addchildren

    Toggle_structure([rich_text[]] $rich_text, [notion_color] $color = "default")
    {
        $this.rich_text = @($rich_text)
        $this.color = $color
    }

    static [Toggle_structure] ConvertFromObject($Value)
    {
        return [Toggle_structure]::new($Value.rich_text.ForEach({ [rich_text]::ConvertFromObject($_) }), $Value.color)
    }
}
class Toggle : block
# https://developers.notion.com/reference/block#toggle-blocks
{
    [blocktype] $type = "toggle"
    [Toggle_structure] $toggle

    Toggle([rich_text[]] $rich_text, [notion_color] $color = "default")
    {
        $this.toggle = [Toggle_structure]::new($rich_text, $color)
    }

    static [Toggle] ConvertFromObject($Value)
    {
        $Toggle_Obj = [Toggle]::new()
        $Toggle_Obj.toggle = [Toggle_structure]::ConvertFromObject($Value.toggle)
        return $Toggle_Obj
    }
}  
