class bulleted_list_item_structure
{
    [rich_text[]] $rich_text = @()
    [notion_color] $color = "default"
    [notion_block[]] $children = @()

    bulleted_list_item_structure()
    {
    }
    
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
        $bulleted_list_item_structure_obj.rich_text = $Value.rich_text.ForEach({ [rich_text]::ConvertFromObject($_) })
        $bulleted_list_item_structure_obj.color = [Enum]::Parse([notion_color], $Value.color)
        return $bulleted_list_item_structure_obj
    }
}


class notion_bulleted_list_item_block : notion_block
# https://developers.notion.com/reference/block#bulleted-list-item
{
    [notion_blocktype] $type = "bulleted_list_item"
    [bulleted_list_item_structure] $bulleted_list_item

    notion_bulleted_list_item_block()
    { 
        $this.bulleted_list_item = [bulleted_list_item_structure]::new()
    }

    notion_bulleted_list_item_block([string] $text, [notion_color] $color = "default")
    {
        $this.bulleted_list_item = [bulleted_list_item_structure]::new($text, $color)
    }

    notion_bulleted_list_item_block([rich_text[]] $rich_text, [notion_color] $color = "default")
    {
        $this.bulleted_list_item = [bulleted_list_item_structure]::new($rich_text, $color)
    }

    static [notion_bulleted_list_item_block] ConvertFromObject($Value)
    {
        $bulleted_list_item_obj = [notion_bulleted_list_item_block]::new()
        $bulleted_list_item_obj.bulleted_list_item = [bulleted_list_item_structure]::ConvertFromObject($Value.bulleted_list_item)
        return $bulleted_list_item_obj
    }
}
