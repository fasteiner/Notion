class notion_multi_select_database_property : DatabasePropertiesBase
# https://developers.notion.com/reference/property-object#multi-select
{
    [notion_multi_select_item[]] $multi_select

    notion_multi_select_database_property() : base("multi_select")
    {
        $this.multi_select = @()
    }

    notion_multi_select_database_property([notion_property_color]$color, $name) : base("multi_select")
    {
        $this.multi_select = @([notion_multi_select_item]::new($color, $name))
    }

    add([notion_property_color]$color, $name)
    {
        if ($this.multi_select.Count -ge 100)
        {
            throw [System.ArgumentException]::new("The multi_select property must have 100 items or less.")
        }
        $this.multi_select += [notion_multi_select_item]::new($color, $name)
    }

    static [notion_multi_select_database_property] ConvertFromObject($Value)
    {
        $multi_select_obj = [notion_multi_select_database_property]::new()
        # the API reference says its in $Value.multi_select.options but it's actually in $Value.multi_select
        $multi_select_obj.multi_select = $Value.multi_select.foreach{
            [notion_multi_select_item]::ConvertFromObject($_)
        }
        return $multi_select_obj
    }
}
