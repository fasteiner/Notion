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
