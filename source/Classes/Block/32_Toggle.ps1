class Toggle_structure
{
    [rich_text[]] $rich_text
    [notion_color] $color = "default"
    [notion_block[]] $children = @()
    #TODO: Implement addchildren

    Toggle_structure() {}

    Toggle_structure($rich_text, $color = "default")
    {
        $this.rich_text = [rich_text]::ConvertFromObjects($rich_text)
        $this.color = [Enum]::Parse([notion_color], $color)
    }

    static [Toggle_structure] ConvertFromObject($Value)
    {
        return [Toggle_structure]::new($Value.rich_text, $Value.color ?? "default")
    }
}
class notion_toggle_block : notion_block
# https://developers.notion.com/reference/block#toggle-blocks
{
    [notion_blocktype] $type = "toggle"
    [Toggle_structure] $toggle

    notion_toggle_block() : base("toggle")
    {

    }

    notion_toggle_block($rich_text)
    {
        $this.toggle = [Toggle_structure]::new($rich_text, "default")
    }

    notion_toggle_block($rich_text, $color = "default")
    {
        $this.toggle = [Toggle_structure]::new($rich_text, $color)
    }

    static [notion_toggle_block] ConvertFromObject($Value)
    {
        $Toggle_Obj = [notion_toggle_block]::new()
        $Toggle_Obj.toggle = [Toggle_structure]::ConvertFromObject($Value.toggle)
        return $Toggle_Obj
    }
}  
