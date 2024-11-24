class PropertiesBase
{
    [string] $id
    [notion_page_property_type] $type

    PropertiesBase([notion_page_property_type]$type)
    {
        $this.type = $type
    }

    PropertiesBase([string]$id, [notion_page_property_type]$type)
    {
        $this.id = $id
        $this.type = $type
    }
}
