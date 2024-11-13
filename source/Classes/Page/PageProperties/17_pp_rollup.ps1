class notion_rollup_page_property : PagePropertiesBase
# https://developers.notion.com/reference/page-property-values#rollup
{
    [notion_page_rollup_function] $function
    [notion_page_property_rollup_type] $type


    notion_rollup_page_property ($type_value, $function, $type) : base("rollup")
    {
        $this.$type = $type_value
        $this.function = [Enum]::Parse([notion_page_rollup_function], $function)
        $this.type = [Enum]::Parse([notion_page_property_rollup_type], $type)
    }

    static [notion_rollup_page_property] ConvertFromObject($Value)
    {
        return [notion_rollup_page_property]::new($Value.type, $Value.function, $Value.type)
    }
}
