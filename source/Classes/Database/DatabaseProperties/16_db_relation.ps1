class notion_database_relation{
    # https://developers.notion.com/reference/property-object#relation
    [string] $database_id
    [string] $synced_property_id
    [string] $synced_property_name

    notion_database_relation()
    {
        $this.database_id = $null
        $this.synced_property_id = $null
        $this.synced_property_name = $null
    }

    notion_database_relation([string]$database_id)
    {
        $this.database_id = $database_id
    }
    
    notion_database_relation([string]$database_id, [string]$synced_property_id, [string]$synced_property_name)
    {
        $this.database_id = $database_id
        $this.synced_property_id = $synced_property_id
        $this.synced_property_name = $synced_property_name
    }

    static [notion_database_relation] ConvertFromObject($Value)
    {
        return [notion_database_relation]::new($Value.id, $Value.synced_property_id, $Value.synced_property_name)
    }
}


class notion_relation_database_property : DatabasePropertiesBase
# https://developers.notion.com/reference/page-property-values#relation
{
    [notion_database_relation] $relation

    notion_relation_database_property($relation) : base("relation")
    {
        if($relation -eq $null)
        {
            $this.relation = $null
            return
        }
        if($relation -is [notion_database_relation])
        {
            $this.relation = $relation
        }
        else{
            $this.relation = [notion_database_relation]::ConvertFromObject($relation)
        }
    }

    notion_relation_database_property() : base("relation")
    {
        $this.relation = [notion_database_relation]::new()
    }

    notion_relation_database_property([string]$database_id, [string]$synced_property_id, [string]$synced_property_name) : base("relation")
    {
        $this.relation = [notion_database_relation]::new($database_id, $synced_property_id, $synced_property_name)
    }


    static [notion_relation_database_property] ConvertFromObject($Value)
    {
        $relation_obj = [notion_relation_database_property]::new($Value.relation)
        return $relation_obj
    }
}
