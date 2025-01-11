class notion_unique_id_database_property_structure{
    [string] $prefix

    notion_unique_id_database_property_structure()
    {
        $this.prefix = $null
    }

    notion_unique_id_database_property_structure([string] $prefix)
    {
        $this.prefix = $prefix
    }

    static [notion_unique_id_database_property_structure] ConvertFromObject($Value)
    {
        $notion_unique_id_database_property_structure_obj = [notion_unique_id_database_property_structure]::new()
        $notion_unique_id_database_property_structure_obj.prefix = $Value.prefix
        return $notion_unique_id_database_property_structure_obj
    }
}



class notion_unique_id_database_property : DatabasePropertiesBase
{
    [notion_unique_id_database_property_structure] $unique_id
    
    notion_unique_id_database_property() : base("unique_id")
    {
        $this.unique_id = [notion_unique_id_database_property_structure]::new()
    }
    
    notion_unique_id_database_property([string]$prefix) : base("unique_id")
    {
        $this.unique_id = [notion_unique_id_database_property_structure]::new($prefix)
    }

    static [notion_unique_id_database_property] ConvertFromObject($Value)
    {
        $unique_id_obj = [notion_unique_id_database_property]::new()
        $unique_id_obj.unique_id = [notion_unique_id_database_property_structure]::ConvertFromObject($Value.unique_id)
        return $unique_id_obj
    }
}   
