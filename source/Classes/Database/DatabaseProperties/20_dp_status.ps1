class notion_status_group
{
    [string] $id
    [string] $name
    [string] $color
    [string[]] $option_ids

    notion_status_group()
    {
    }

    # No constructors are available, as the API does not support creating status groups directly.
    # https://developers.notion.com/reference/property-object#status

    static [notion_status_group] ConvertFromObject($Value)
    {
        if (-not $Value) {
            throw [System.ArgumentNullException]::new("Value cannot be null.")
        }
        if ($Value -is [notion_status_group]) {
            return $Value
        }
        $notion_status_group_obj = [notion_status_group]::new()
        $notion_status_group_obj.id = $Value.id
        $notion_status_group_obj.name = $Value.name
        $notion_status_group_obj.color = $Value.color
        $notion_status_group_obj.option_ids = $Value.option_ids
        return $notion_status_group_obj
    }
}

class notion_status_database_property_structure 
{
    [notion_status[]] $options
    [notion_status_group[]] $groups

    notion_status_database_property_structure()
    {
        $this.options = @()
        $this.groups = @()
    }

    notion_status_database_property_structure($name)
    {
        $this.options = @()
        $this.groups = @()
        $this.add($name)
    }

    notion_status_database_property_structure($color, $name)
    {
        $this.options = @()
        $this.groups = @()
        $this.add($color, $name)
    }

    add($name)
    {
        if ($this.options.Count -ge 100)
        {
            throw [System.ArgumentException]::new("The status property must have 100 items or less.")
        }
        $this.options += [notion_status]::new($name)
    }

    add($color = [notion_color]::default, $name)
    {
        if ($this.options.Count -ge 100)
        {
            throw [System.ArgumentException]::new("The status property must have 100 items or less.")
        }
        $this.options += [notion_status]::new($color, $name)
    }

    add($color = [notion_color]::default, $id, $name)
    {
        if ($this.options.Count -ge 100)
        {
            throw [System.ArgumentException]::new("The status property must have 100 items or less.")
        }
        $this.options += [notion_status]::new($color, $id, $name)
    }

    static [notion_status_database_property_structure] ConvertFromObject($Value)
    {
        if (-not $Value) {
            throw [System.ArgumentNullException]::new("Value cannot be null.")
        }
        if ($Value -is [notion_status_database_property_structure]) {
            return $Value
        }
        $notion_status_database_property_structure_obj = [notion_status_database_property_structure]::new()
        $notion_status_database_property_structure_obj.options = $Value.options.ForEach({ [notion_status]::ConvertFromObject($_) })
        $notion_status_database_property_structure_obj.groups = $Value.groups.ForEach({ [notion_status_group]::ConvertFromObject($_) })
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

    notion_status_database_property($name) : base("status")
    {
        $this.status = [notion_status_database_property_structure]::new($name)
    }

    notion_status_database_property($color, $name) : base("status")
    {
        $this.status = [notion_status_database_property_structure]::new($color, $name)
    }

    notion_status_database_property($color, $id, $name) : base("status")
    {
        $this.status = [notion_status_database_property_structure]::new($color, $id, $name)
    }

    add($name)
    {
        $this.status.add($name)
    }

    add($color = [notion_color]::default, $name)
    {
        $this.status.add($color, $name)
    }

    add($color = [notion_color]::default, $id, $name)
    {
        $this.status.add($color, $id, $name)
    }

    static [notion_status_database_property] ConvertFromObject($Value)
    {
        if (-not $Value) {
            throw [System.ArgumentNullException]::new("Value cannot be null.")
        }
        if ($Value -is [notion_status_database_property]) {
            return $Value
        }
        $notion_status_database_property_obj = [notion_status_database_property]::new()
        $notion_status_database_property_obj.status = [notion_status_database_property_structure]::ConvertFromObject($Value.status)
        return $notion_status_database_property_obj
    }
}
