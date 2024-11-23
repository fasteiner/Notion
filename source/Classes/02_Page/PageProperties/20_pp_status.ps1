class notion_status
# https://developers.notion.com/reference/page-property-values#status
{
    [notion_page_property_color] $color
    [string] $id
    [string] $name

    notion_status($name) 
    {
        $this.color = [notion_page_property_color]::default
        $this.id = $null
        $this.name = $name
    }

    notion_status($color, $name)
    {
        $this.color = [Enum]::Parse([notion_page_property_color], $color)
        $this.name = $name
    }

    notion_status($color, $id, $name)
    {
        $this.color = [Enum]::Parse([notion_page_property_color], $color)
        $this.id = $id
        $this.name = $name
    }

    static [notion_status] ConvertFromObject($Value)
    {
        return [notion_status]::new($Value.color, $Value.id, $Value.name)
    }
}
class notion_status_page_property : PagePropertiesBase{
    [notion_status] $status

    notion_status_page_property() : base("status")
    {
        $this.status = [notion_status]::new()
    }

    notion_status_page_property($name) : base("status")
    {
        $this.status = [notion_status]::new($name)
    }
    
    notion_status_page_property($color, $name) : base("status")
    {
        $this.status = [notion_status]::new($color, $name)
    }

    notion_status_page_property($color, $id, $name) : base("status")
    {
        $this.status = [notion_status]::new($color, $id, $name)
    }

    static [notion_status_page_property] ConvertFromObject($Value)
    {
        return [notion_status_page_property]::new($Value.status.color, $Value.status.id, $Value.status.name)
    }
}
