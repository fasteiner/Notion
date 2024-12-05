class notion_multi_select_item_page_property
# https://developers.notion.com/reference/page-property-values#multi-select
# If the type of a page property value is "multi_select", then the property value contains a "multi_select" array.
{
    [notion_page_property_color] $color
    [string] $id
    [string] $name

    notion_multi_select_item_page_property() 
    {
        $this.color = [notion_page_property_color]::default
    }

    notion_multi_select_item_page_property($color, $name)
    {
        $this.color = [Enum]::Parse([notion_page_property_color], $color)
        $this.id = [guid]::NewGuid().ToString()
        $this.name = $name
    }

    static [notion_multi_select_item_page_property] ConvertFromObject($Value)
    {
        $notion_multi_select_item_page_property = [notion_multi_select_item_page_property]::new($Value.color, $Value.name)
        $notion_multi_select_item_page_property.id = $Value.id
        return $notion_multi_select_item_page_property
    }       
}
