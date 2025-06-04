class numbered_list_item_structure
{
    [rich_text[]] $rich_text
    [notion_color] $color = "default"
    # TODO: Add children property

    
    numbered_list_item_structure()
    {
    }

    numbered_list_item_structure($rich_text)
    {
        $this.rich_text = [rich_text]::ConvertFromObjects($rich_text)
    }
    numbered_list_item_structure($rich_text, [notion_color] $color)
    {
        $this.rich_text = [rich_text]::ConvertFromObjects($rich_text)
        $this.color = [Enum]::Parse([notion_color], $color)
    }


    static [numbered_list_item_structure] ConvertFromObject($Value)
    {
        $numbered_list_item_structure = [numbered_list_item_structure]::new()
        $numbered_list_item_structure.rich_text = [rich_text]::ConvertFromObjects($Value.rich_text)
        $numbered_list_item_structure.color = [Enum]::Parse([notion_color], ($Value.color ?? "default"))
        return $numbered_list_item_structure
    }
}
class notion_numbered_list_item_block : notion_block
# https://developers.notion.com/reference/block#numbered-list-item
{
    [notion_blocktype] $type = "numbered_list_item"
    [numbered_list_item_structure] $numbered_list_item

    notion_numbered_list_item_block()
    {
    }

    notion_numbered_list_item_block($rich_text)
    {
        $this.numbered_list_item = [numbered_list_item_structure]::new($rich_text)
    }

    static [notion_numbered_list_item_block] ConvertFromObject($Value)
    {
        $numbered_list_item_Obj = [notion_numbered_list_item_block]::new()
        $numbered_list_item_Obj.numbered_list_item = [numbered_list_item_structure]::ConvertFromObject($Value.numbered_list_item)
        return $numbered_list_item_Obj
    }
}
