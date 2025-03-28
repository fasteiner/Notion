class notion_multi_select_database_property_structure{
    [notion_multi_select_item[]] $options

    notion_multi_select_database_property_structure()
    {
        $this.options = @()
    }

    add([notion_property_color]$color, $name)
    {
        if ($this.options.Count -ge 100)
        {
            throw [System.ArgumentException]::new("The multi_select property must have 100 items or less.")
        }
        $this.options += [notion_multi_select_item]::new($color, $name)
    }

    static [notion_multi_select_database_property_structure] ConvertFromObject($Value)
    {
        Write-Verbose "[notion_multi_select_database_property_structure]::ConvertFromObject($($Value | Convertto-json -depth 20))"
        $notion_multi_select_database_property_structure_obj = [notion_multi_select_database_property_structure]::new()
        $notion_multi_select_database_property_structure_obj.options = $Value.options.ForEach({[notion_multi_select_item]::ConvertFromObject($_)})
        return $notion_multi_select_database_property_structure_obj
    }

}


class notion_multi_select_database_property : DatabasePropertiesBase
# https://developers.notion.com/reference/property-object#multi-select
{
    [notion_multi_select_database_property_structure] $multi_select

    notion_multi_select_database_property() : base("multi_select")
    {
        $this.multi_select = [notion_multi_select_database_property_structure]::new()
    }

    notion_multi_select_database_property([notion_property_color]$color, $name) : base("multi_select")
    {
        $this.multi_select = @([notion_multi_select_database_property_structure]::new($color, $name))
    }

    add([notion_property_color]$color, $name)
    {
        $this.multi_select.add($color, $name)
    }

    static [notion_multi_select_database_property] ConvertFromObject($Value)
    {
        Write-Verbose "[notion_multi_select_database_property]::ConvertFromObject($($Value | Convertto-json -depth 20))"
        $notion_multi_select_database_property_obj = [notion_multi_select_database_property]::new()
        $notion_multi_select_database_property_obj.multi_select = [notion_multi_select_database_property_structure]::ConvertFromObject($Value.multi_select)
        return $notion_multi_select_database_property_obj
    }
}
