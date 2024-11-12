class notion_checkbox_page_property : PagePropertiesBase
# https://developers.notion.com/reference/page-property-values#checkbox
{
    [bool] $checkbox = $false

    notion_checkbox_page_property([bool]$checkbox) : base("checkbox")
    {
        $this.checkbox = $checkbox
    }


    static [notion_checkbox_page_property] ConvertFromObject($Value)
    {
        $notion_checkbox_page_property = [notion_checkbox_page_property]::new($Value.checkbox)
        return $notion_checkbox_page_property
    }
}
