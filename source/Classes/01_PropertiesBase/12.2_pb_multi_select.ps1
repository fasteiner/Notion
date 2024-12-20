class multi_select_property_base : PropertiesBase
{
    [notion_multi_select_item_page_property[]] $multi_select

    multi_select_property_base() : base("multi_select")
    {
        $this.multi_select = @()
    }

    multi_select_property_base($color, $name) : base("multi_select")
    {
        $this.multi_select = @([notion_multi_select_item_page_property]::new($color, $name))
    }

    add($color, $name)
    {
        if ($multi_select.Count -ge 100)
        {
            throw [System.ArgumentException]::new("The multi_select property must have 100 items or less.")
        }
        $this.multi_select += [notion_multi_select_item_page_property]::new($color, $name)
    }

    static [multi_select_property_base] ConvertFromObject($Value)
    {
        $multi_select_obj = [multi_select_property_base]::new()
        # the API reference says its in $Value.multi_select.options but it's actually in $Value.multi_select
        $multi_select_obj.multi_select = $Value.multi_select.foreach{
            [notion_multi_select_item_page_property]::ConvertFromObject($_)
        }
        return $multi_select_obj
    }
}
