class notion_formula_page_property : PagePropertiesBase
# https://developers.notion.com/reference/page-property-values#formula
{
    [notion_formula] $formula

    notion_formula_page_property() : base("formula")
    {
    }

    notion_formula_page_property([notion_formula]$formula) : base("formula")
    {
        $this.formula = $formula
    }

    static [notion_formula_page_property] ConvertFromObject($Value)
    {
        $formula_obj = [notion_formula_page_property]::new()
        $formula_obj.formula = [notion_formula]::ConvertFromObject($Value.formula)
        return $formula_obj
    }
}
