


class notion_formula_database_property : DatabasePropertiesBase
# https://developers.notion.com/reference/property-object#formula
{
    [notion_formula] $formula

    notion_formula_database_property() : base("formula")
    {
    }

    notion_formula_database_property([notion_formula]$formula) : base("formula")
    {
        $this.formula = $formula
    }

    static [notion_formula_database_property] ConvertFromObject($Value)
    {
        $formula_obj = [notion_formula_database_property]::new()
        $formula_obj.formula = [notion_formula]::ConvertFromObject($Value.formula)
        return $formula_obj
    }
}
