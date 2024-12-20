class select_property_base_structure 
{
    [notion_color] $color
    [string] $id
    [string] $name

    select_property_base_structure () 
    {

    }


    select_property_base_structure ($color, $id, $name)
    {
        $this.color = [Enum]::Parse([notion_color], $color)
        $this.id = $id
        $this.name = $name
    }

    static [select_property_base_structure] ConvertFromObject($Value)
    {
        return [select_property_base_structure]::new($Value.color, $Value.id, $Value.name)
    }
}

class select_property_base : PropertiesBase
{
    [select_property_base_structure] $select

    select_property_base() : base("select")
    {
        $this.select = [select_property_base_structure]::new()
    }

    select_property_base($color, $id, $name) : base("select")
    {
        $this.select = [select_property_base_structure]::new($color, $id, $name)
    }

    static [select_property_base] ConvertFromObject($Value)
    {
        return [select_property_base]::new($Value.select.color, $Value.select.id, $Value.select.name)
    }
}
