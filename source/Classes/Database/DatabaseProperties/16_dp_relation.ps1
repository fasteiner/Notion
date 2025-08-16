class notion_relation_database_property_structure
{
    # https://developers.notion.com/reference/property-object#relation
    # Attention: https://developers.notion.com/changelog/releasing-notion-version-2022-06-28
    [string] $synced_property_id
    [string] $synced_property_name

    notion_relation_database_property_structure()
    {
        $this.synced_property_id = $null
        $this.synced_property_name = $null
    }
    
    notion_relation_database_property_structure([string]$synced_property_id, [string]$synced_property_name)
    {
        $this.synced_property_id = $synced_property_id
        $this.synced_property_name = $synced_property_name
    }

    static [notion_relation_database_property_structure] ConvertFromObject($Value)
    {
        return [notion_relation_database_property_structure]::new($Value.synced_property_id, $Value.synced_property_name)
    }
}


class notion_database_relation_base
{
    [string] $database_id
    [notion_database_relation_type] $type

    notion_database_relation_base($type)
    {
        $this.database_id = $null
        $this.type = $type
    }

    notion_database_relation_base([string]$database_id, $type)
    {
        $this.database_id = $database_id
        $this.type = $type
    }

    static [notion_database_relation_base] ConvertFromObject($Value)
    {
        $relation_obj = $null
        if (!$value.type)
        {
            Write-Error "Relation type is missing in the provided object." -Category InvalidData
            return $null
        }
        switch ($Value.type)
        {
            "single_property"
            {
                $relation_obj = [notion_database_single_relation]::ConvertFromObject($Value)
                break
            }
            "dual_property"
            {
                $relation_obj = [notion_database_dual_relation]::ConvertFromObject($Value)
                break
            }
            default
            {
                Write-Error "Invalid relation type: $($Value.type)" -Category InvalidData
            }
        }
        $relation_obj.database_id = $Value.database_id
        $relation_obj.type = $Value.type
        return $relation_obj
    }

}

class notion_database_single_relation : notion_database_relation_base
{
    #TODO: find out if this is correct as no documentation is available for this
    [notion_relation_database_property_structure] $single_property

    notion_database_single_relation() : base("single_property")
    {
        $this.single_property = [notion_relation_database_property_structure]::new()
    }

    notion_database_single_relation([notion_relation_database_property_structure]$single_property) : base("single_property")
    {
        $this.single_property = $single_property
    }

    notion_database_single_relation([string]$database_id, [string]$synced_property_id, [string]$synced_property_name) : base($database_id, "single_property")
    {
        $this.single_property = [notion_relation_database_property_structure]::new($synced_property_id, $synced_property_name)
    }

    static [notion_database_single_relation] ConvertFromObject($Value)
    {
        $single_relation_obj = [notion_database_single_relation]::new()
        $single_relation_obj.single_property = [notion_relation_database_property_structure]::ConvertFromObject($Value.single_property)
        return $single_relation_obj
    }
    
}

class notion_database_dual_relation : notion_database_relation_base
{
    [notion_relation_database_property_structure] $dual_property

    notion_database_dual_relation() : base("dual_property")
    {
        $this.dual_property = [notion_relation_database_property_structure]::new()
    }

    notion_database_dual_relation([notion_relation_database_property_structure]$dual_property) : base("dual_property")
    {
        $this.dual_property = $dual_property
    }

    notion_database_dual_relation([string]$database_id, [string]$synced_property_id, [string]$synced_property_name) : base($database_id, "dual_property")
    {
        $this.dual_property = [notion_relation_database_property_structure]::new($synced_property_id, $synced_property_name)
    }

    static [notion_database_dual_relation] ConvertFromObject($Value)
    {
        $dual_relation_obj = [notion_database_dual_relation]::new()
        $dual_relation_obj.dual_property = [notion_relation_database_property_structure]::ConvertFromObject($Value.dual_property)
        return $dual_relation_obj
    }
}


class notion_relation_database_property : DatabasePropertiesBase
# https://developers.notion.com/reference/page-property-values#relation
{
    [notion_database_relation_base] $relation

    notion_relation_database_property($relation) : base("relation")
    {
        if ($relation -eq $null)
        {
            $this.relation = $null
            return
        }
        if ($relation -is [notion_database_relation_base])
        {
            $this.relation = $relation
        }
        else
        {
            $this.relation = [notion_database_relation_base]::ConvertFromObject($relation)
        }
    }

    notion_relation_database_property() : base("relation")
    {
        $this.relation = [notion_database_relation_base]::new()
    }

    notion_relation_database_property([string]$database_id, [notion_database_relation_type] $type, [string]$synced_property_id, [string]$synced_property_name) : base("relation")
    {
        if ($type -eq "single_property")
        {
            $this.relation = [notion_database_single_relation]::new($database_id, $synced_property_id, $synced_property_name)
        }
        elseif ($type -eq "dual_property")
        {
            $this.relation = [notion_database_dual_relation]::new($database_id, $synced_property_id, $synced_property_name)
        }
        else
        {
            Write-Error "Invalid relation type: $type" -Category InvalidData
        }
    }


    static [notion_relation_database_property] ConvertFromObject($Value)
    {
        $relation_obj = [notion_database_relation_base]::ConvertFromObject($Value.relation)
        
        return $relation_obj
    }
}
