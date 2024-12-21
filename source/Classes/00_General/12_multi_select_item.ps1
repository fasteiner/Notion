class notion_multi_select_item
# https://developers.notion.com/reference/property-object#multi-select
# If the type of a page property value is "multi_select", then the property value contains a "multi_select" array.
{
    [notion_property_color] $color
    [string] $id
    [string] $name

    notion_multi_select_item() 
    {
        $this.color = [notion_property_color]::default
    }

    notion_multi_select_item([notion_property_color]$color, $name)
    {
        $this.color = [Enum]::Parse([notion_property_color], $color)
        $this.id = [guid]::NewGuid().ToString()
        $this.name = $name
    }

    static [notion_multi_select_item] ConvertFromObject($Value)
    {
        $notion_multi_select_item_obj= [notion_multi_select_item]::new($Value.color, $Value.name)
        $notion_multi_select_item_obj.id = $Value.id
        return $notion_multi_select_item_obj
    }       
}
