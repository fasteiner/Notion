class pp_multi_select_item : PageProperties
# https://developers.notion.com/reference/page-property-values#multi-select
# If the type of a page property value is "multi_select", then the property value contains a "multi_select" array.
{
    [multi_select_color] $color
    [string] $id
    [string] $name

    pp_multi_select_item($color, $name)
    {
        $this.color = [Enum]::Parse([multi_select_color], $color)
        $this.id = [guid]::NewGuid().ToString()
        $this.name = $name
    }

    static [pp_multi_select_item] ConvertFromObject($Value)
    {
        $pp_multi_select_item = [multi_select_color]::new($Value.color, $Value.name)
        $pp_multi_select_item.id = $Value.id
        return $pp_multi_select_item
    }       
}
