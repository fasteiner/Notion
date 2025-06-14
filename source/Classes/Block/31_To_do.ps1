class to_do_structure
{
    [rich_text[]] $rich_text
    [bool] $checked = $false
    [notion_color] $color = "default"
    [notion_block[]] $children = @()
    # TODO: Implement addchildren

    to_do_structure()
    {
    }


    to_do_structure($rich_text, [bool] $checked = $false, $color = "default")
    {
        $this.rich_text = [rich_text]::ConvertFromObjects($rich_text)
        $this.checked = $checked
        $this.color = [Enum]::Parse([notion_color], $color)
    }

    static [to_do_structure] ConvertFromObject ($Value)
    {
        $notion_to_do_obj = [to_do_structure]::new()
        $notion_to_do_obj.rich_text = [rich_text]::ConvertFromObjects($Value.rich_text)
        $notion_to_do_obj.checked = $Value.checked
        $notion_to_do_obj.color = [Enum]::Parse([notion_color], $Value.color ?? "default")
        return $notion_to_do_obj
    }
}
class notion_to_do_block : notion_block
# https://developers.notion.com/reference/block#to-do
{
    [notion_blocktype] $type = "to_do"
    [to_do_structure] $to_do

    notion_to_do_block()
    {
    }

    notion_to_do_block($rich_text)
    {
        $this.to_do = [to_do_structure]::new($rich_text, $false, "default")
    }

    notion_to_do_block($rich_text, [bool] $checked = $false, $color = "default")
    {
        $this.to_do = [to_do_structure]::new($rich_text, $checked, $color)
    }

    static [notion_to_do_block] ConvertFromObject ($Value)
    {
        $To_do_Obj = [notion_to_do_block]::new()
        $To_do_Obj.to_do = [to_do_structure]::ConvertFromObject($Value.to_do)
        return $To_do_Obj
    }
}
