class notion_formula_database_property_structure
{
    [string] $expression

    notion_formula_database_property_structure()
    {
    }

    notion_formula_database_property_structure([string] $expression)
    {
        $this.expression = $expression
    }

    static [notion_formula_database_property_structure] ConvertFromObject($Value)
    {
        $notion_formula_database_property_structure_obj = [notion_formula_database_property_structure]::new()
        $notion_formula_database_property_structure_obj.expression = $Value.expression
        return $notion_formula_database_property_structure_obj
    }
}


class notion_formula_database_property : DatabasePropertiesBase
# https://developers.notion.com/reference/page-property-values#formula
{
    [notion_formula_database_property_structure] $formula

    notion_formula_database_property() : base("formula")
    {
        $this.formula = [notion_formula_database_property_structure]::new()
    }

    notion_formula_database_property([string]$expression) : base("formula")
    {
        $this.formula = [notion_formula_database_property_structure]::new($expression)
    }

    static [notion_formula_database_property] ConvertFromObject($Value)
    {
        $formula_obj = [notion_formula_database_property]::new()
        $formula_obj.formula = [notion_formula_database_property_structure]::ConvertFromObject($Value.formula)
        return $formula_obj
    }
}
