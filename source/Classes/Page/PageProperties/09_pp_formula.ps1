class pp_formula : PageProperties
# https://developers.notion.com/reference/page-property-values#formula
{
    [pp_formular_type] $type

    pp_formula($field, $type)
    {
        $this.$field = $field
        $this.type = [Enum]::Parse([pp_formular_type], $type)
    }

    static [pp_formula] ConvertFromObject($Value)
    {
        $pp_formula = [pp_formula]::new($Value.field, $Value.type)
        return $pp_formula
    }
}
