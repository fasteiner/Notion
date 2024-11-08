class numbered_list_item_structure
{
    [rich_text[]] $rich_text
    [notion_color] $color = "default"
    # TODO: Add children property

    
    numbered_list_item_structure()
    {
    }

    numbered_list_item_structure([rich_text[]] $rich_text)
    {
        $this.rich_text = $rich_text
    }
    numbered_list_item_structure([rich_text[]] $rich_text, [notion_color] $color)
    {
        $this.rich_text = $rich_text
        $this.color = $color
    }


    static [numbered_list_item_structure] ConvertFromObject($Value)
    {
        $numbered_list_item_structure = [numbered_list_item]::new()
        $numbered_list_item_structure.rich_text = $Value.rich_text.ForEach({ [rich_text]::ConvertFromObject($_) })
        $numbered_list_item_structure.color = $Value.color
        return $numbered_list_item_structure
    }
}
class numbered_list_item : block
# https://developers.notion.com/reference/block#numbered-list-item
{
    [blocktype] $type = "numbered_list_item"
    [numbered_list_item_structure] $numbered_list_item_structure

    numbered_list_item()
    {
    }

    numbered_list_item([rich_text[]] $rich_text)
    {
        $this.numbered_list_item_structure = [numbered_list_item_structure]::new($rich_text)
    }

    static [numbered_list_item] ConvertFromObject($Value)
    {
        return [numbered_list_item]::ConvertFromObject($Value.numbered_list_item_structure)
    }
}
