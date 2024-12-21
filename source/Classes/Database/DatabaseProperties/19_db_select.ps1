class notion_select_database_property : DatabasePropertiesBase 
#https://developers.notion.com/reference/property-object#select
{
    [notion_select[]] $select

    notion_select_database_property() : base("select")
    {
        $this.select = [notion_select]::new()
    }


    static [notion_select_database_property] ConvertFromObject($Value)
    {
        $notion_select_database_property_obj = [notion_select_database_property]::new()
        $notion_select_database_property_obj.select = $value.select.options.ForEach({[notion_select]::ConvertFromObject($_)})
        return $notion_select_database_property_obj
    }
}
