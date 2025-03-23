class notion_rollup_database_property : DatabasePropertiesBase
# https://developers.notion.com/reference/property-object#rollup
{
    [notion_rollup] $rollup

    notion_rollup_database_property() : base("rollup")
    {
        $this.rollup = [notion_rollup]::new()
    }

    notion_rollup_database_property($type_value, $function, $type) : base("rollup")
    {
        $this.rollup = [notion_rollup]::new($type_value, $function, $type)
    }

    static [notion_rollup_database_property] ConvertFromObject($Value)
    {
        $rollup_obj = [notion_rollup_database_property]::new()
        $rollup_obj.rollup = [notion_rollup]::ConvertFromObject($Value.rollup)
        return $rollup_obj
    }
}
