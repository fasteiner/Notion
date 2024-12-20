class unique_id_properies_base
# https://developers.notion.com/reference/page-property-values#unique-id
{
    [int] $number
    [string] $prefix = $null

    unique_id_properies_base()
    {
        $this.number = 0
    }

    unique_id_properies_base($number)
    {
        $this.number = $number
    }
    
    unique_id_properies_base($number, $prefix)
    {
        $this.number = $number
        $this.prefix = $prefix
    }

    static [unique_id_properies_base] ConvertFromObject($Value)
    {
        return [unique_id_properies_base]::new($Value.number, $Value.prefix)
    }
}

class unique_id_property_base : PagePropertiesBase
{
    [notion_unique_id] $unique_id

    unique_id_property_base() : base("unique_id")
    {
        $this.unique_id = [notion_unique_id]::new()
    }

    unique_id_property_base($number) : base("unique_id")
    {
        $this.unique_id = [notion_unique_id]::new($number)
    }

    unique_id_property_base($number, $prefix) : base("unique_id")
    {
        $this.unique_id = [notion_unique_id]::new($number, $prefix)
    }

    static [unique_id_property_base] ConvertFromObject($Value)
    {
        return [unique_id_property_base]::new($Value.unique_id.number, $Value.unique_id.prefix)
    }
}
