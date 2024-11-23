class notion_unique_id
# https://developers.notion.com/reference/page-property-values#unique-id
{
    [int] $number
    [string] $prefix = $null

    notion_unique_id_page_property($number)
    {
        $this.number = $number
    }
    
    notion_unique_id_page_property($number, $prefix)
    {
        $this.number = $number
        $this.prefix = $prefix
    }

    static [notion_unique_id_page_property] ConvertFromObject($Value)
    {
        return [notion_unique_id_page_property]::new($Value.number, $Value.prefix)
    }
}

class notion_unique_id_page_property : PagePropertiesBase{
    [notion_unique_id] $unique_id

    notion_unique_id_page_property() : base("unique_id")
    {
        $this.unique_id = [notion_unique_id]::new()
    }

    notion_unique_id_page_property($number) : base("unique_id")
    {
        $this.unique_id = [notion_unique_id]::new($number)
    }

    notion_unique_id_page_property($number, $prefix) : base("unique_id")
    {
        $this.unique_id = [notion_unique_id]::new($number, $prefix)
    }

    static [notion_unique_id_page_property] ConvertFromObject($Value)
    {
        return [notion_unique_id_page_property]::new($Value.unique_id.number, $Value.unique_id.prefix)
    }
}
