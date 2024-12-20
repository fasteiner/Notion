class status_roperty_base_structure
{
    [notion_page_property_color] $color
    [string] $id
    [string] $name

    status_roperty_base_structure($name) 
    {
        $this.color = [notion_page_property_color]::default
        $this.id = $null
        $this.name = $name
    }

    status_roperty_base_structure($color, $name)
    {
        $this.color = [Enum]::Parse([notion_page_property_color], $color)
        $this.name = $name
    }

    status_roperty_base_structure($color, $id, $name)
    {
        $this.color = [Enum]::Parse([notion_page_property_color], $color)
        $this.id = $id
        $this.name = $name
    }

    static [status_roperty_base_structure] ConvertFromObject($Value)
    {
        return [status_roperty_base_structure]::new($Value.color, $Value.id, $Value.name)
    }
}
class status_property_base : PropertiesBase
{
    [notion_status] $status

    status_property_base() : base("status")
    {
        $this.status = [notion_status]::new()
    }

    status_property_base($name) : base("status")
    {
        $this.status = [notion_status]::new($name)
    }
    
    status_property_base($color, $name) : base("status")
    {
        $this.status = [notion_status]::new($color, $name)
    }

    status_property_base($color, $id, $name) : base("status")
    {
        $this.status = [notion_status]::new($color, $id, $name)
    }

    static [status_property_base] ConvertFromObject($Value)
    {
        return [status_property_base]::new($Value.status.color, $Value.status.id, $Value.status.name)
    }
}
