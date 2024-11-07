class bulleted_list_item_structure
{
    [rich_text[]] $rich_text = @()
    [notion_color] $color = "default"
    [block[]] $children = @()

    bulleted_list_item_structure([object] $bulleted_list_item)
    {
        $this.rich_text = $bulleted_list_item.rich_text
        $this.color = $bulleted_list_item.color
    }

    bulleted_list_item_structure([string] $text, [notion_color] $color = "default")
    {
        $this.rich_text = @([rich_text_text]::new($text))
        $this.color = $color
    }

    bulleted_list_item_structure([rich_text[]] $rich_text, [notion_color] $color = "default")
    {
        $this.rich_text = $rich_text
        $this.color = $color
    }
    static [bulleted_list_item_structure] ConvertFromObject($Value)
    {
        $bulleted_list_item_structure_obj = [bulleted_list_item_structure]::new()
        $bulleted_list_item_structure_obj.rich_text = $Value.rich_text.ForEach({[rich_text]::ConvertFromObject($_)})
        $bulleted_list_item_structure_obj.color = [Enum]::Parse([notion_color], $Value.color)
        return $bulleted_list_item_structure_obj
    }
}


class bulleted_list_item : Block
# https://developers.notion.com/reference/block#bulleted-list-item
{
    [blocktype] $type = "bulleted_list_item"
    [bulleted_list_item_structure] $bulleted_list_item

    bulleted_list_item() { 
        $this.bulleted_list_item = [bulleted_list_item_structure]::new()
    }

    bulleted_list_item([string] $text, [notion_color] $color = "default") {
        $this.bulleted_list_item = [bulleted_list_item_structure]::new($text, $color)
    }

    bulleted_list_item([rich_text[]] $rich_text, [notion_color] $color = "default") {
        $this.bulleted_list_item = [bulleted_list_item_structure]::new($rich_text, $color)
    }

    static [bulleted_list_item] ConvertFromObject($Value)
    {
        $bulleted_list_item_obj = [bulleted_list_item]::new()
        $bulleted_list_item_obj.bulleted_list_item = [bulleted_list_item_structure]::ConvertFromObject($Value.bulleted_list_item)
        return $bulleted_list_item_obj
    }
}
