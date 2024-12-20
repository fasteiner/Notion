class multi_select_item_property_base : PropertiesBase
# If the type of a property value is "multi_select", then the property value contains a "multi_select" array.
{
    [notion_page_property_color] $color
    [string] $id
    [string] $name

    multi_select_item_property_base()
    {
        $this.color = [notion_page_property_color]::default
    }

    multi_select_item_property_base($color, $name)
    {
        $this.color = [Enum]::Parse([notion_page_property_color], $color)
        $this.id = [guid]::NewGuid().ToString()
        $this.name = $name
    }

    static [multi_select_item_property_base] ConvertFromObject($Value)
    {
        $multi_select_item_property_base = [multi_select_item_property_base]::new($Value.color, $Value.name)
        $multi_select_item_property_base.id = $Value.id
        return $multi_select_item_property_base
    }       
}
