class notion_select_database_property_structure{
    [notion_select[]] $options

    notion_select_database_property_structure()
    {
        $this.options = @()
    }

    add($name)
    {
        if ($this.options.Count -ge 100)
        {
            throw [System.ArgumentException]::new("The select property must have 100 items or less.")
        }
        $this.options += [notion_select]::new($name)
    }

    static [notion_select_database_property_structure] ConvertFromObject($Value)
    {
        $notion_select_database_property_structure_obj = [notion_select_database_property_structure]::new()
        $notion_select_database_property_structure_obj.options = $Value.options.ForEach({[notion_select]::ConvertFromObject($_)})
        return $notion_select_database_property_structure_obj
    }
}


class notion_select_database_property : DatabasePropertiesBase 
#https://developers.notion.com/reference/property-object#select
{
    [notion_select_database_property_structure] $select

    notion_select_database_property() : base("select")
    {
        $this.select = [notion_select_database_property_structure]::new()
    }

    notion_select_database_property($name) : base("select")
    {
        $this.select = [notion_select_database_property_structure]::new()
        $this.select.add($name)
    }


    static [notion_select_database_property] ConvertFromObject($Value)
    {
        $notion_select_database_property_obj = [notion_select_database_property]::new()
        $notion_select_database_property_obj.select =[notion_select_database_property_structure]::ConvertFromObject($value.select)
        return $notion_select_database_property_obj
    }
}
