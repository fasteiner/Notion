class notion_status
# https://developers.notion.com/reference/page-property-values#status
{
    [notion_property_color] $color
    [string] $id
    [string] $name

    notion_status() 
    {
        $this.color = [notion_property_color]::default
        $this.id = $null
        $this.name = $null
    }

    notion_status($name) 
    {
        $this.color = [notion_property_color]::default
        $this.id = $null
        $this.name = $name
    }

    notion_status($color = [notion_property_color]::default, $name)
    {
        $this.color = [Enum]::Parse([notion_property_color], $color)
        $this.name = $name
    }

    notion_status($color = [notion_property_color]::default, $id, $name)
    {
        $this.color = [Enum]::Parse([notion_property_color], $color)
        $this.id = $id
        $this.name = $name
    }

    static [notion_status] ConvertFromObject($Value)
    {
        return [notion_status]::new($Value.color, $Value.id, $Value.name)
    }
}
