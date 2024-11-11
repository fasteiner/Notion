class pp_rollup : PageProperties
# https://developers.notion.com/reference/page-property-values#rollup
{
    [rollup_function] $function
    [rollup_type] $type


    pp_rollup ($type_value, $function, $type)
    {
        $this.$type = $type_value
        $this.function = [Enum]::Parse([rollup_function], $function)
        $this.type = [Enum]::Parse([rollup_type], $type)
    }

    static [pp_rollup] ConvertFromObject($Value)
    {
        $pp_rollup = [pp_rollup]::new($Value.type, $Value.function, $Value.type)
        return $pp_rollup
    }
}
