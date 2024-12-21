class notion_status_group
{
    [string] $id
    [string] $name
    [string] $color
    [string[]] $option_ids

    notion_status_group()
    {
    }

    static [notion_status_group] ConvertFromObject($Value)
    {
        $notion_status_group_obj = [notion_status_group]::new()
        $notion_status_group_obj.id = $Value.id
        $notion_status_group_obj.name = $Value.name
        $notion_status_group_obj.color = $Value.color
        $notion_status_group_obj.option_ids = $Value.option_ids
        return $notion_status_group_obj
    }
}

class notion_status_database_property_structure {
    [notion_status[]] $options
    [notion_status_group[]] $groups

    notion_status_database_property_structure()
    {
        $this.options = @()
        $this.groups = @()
    }

    static [notion_status_database_property_structure] ConvertFromObject($Value)
    {
        $notion_status_database_property_structure_obj = [notion_status_database_property_structure]::new()
        $notion_status_database_property_structure_obj.options = $Value.options.ForEach({[notion_status]::ConvertFromObject($_)})
        $notion_status_database_property_structure_obj.groups = $Value.groups.ForEach({[notion_status_group]::ConvertFromObject($_)})
        return $notion_status_database_property_structure_obj
    }
}


class notion_status_database_property : DatabasePropertiesBase
#https://developers.notion.com/reference/property-object#status
{
    [notion_status_database_property_structure] $status

    notion_status_database_property() : base("status")
    {
        $this.status = [notion_status_database_property_structure]::new()
    }

    static [notion_status_database_property] ConvertFromObject($Value)
    {
        $notion_status_database_property_obj = [notion_status_database_property]::new()
        $notion_status_database_property_obj.status = [notion_status_database_property_structure]::ConvertFromObject($Value.status)
        return $notion_status_database_property_obj
    }
}
