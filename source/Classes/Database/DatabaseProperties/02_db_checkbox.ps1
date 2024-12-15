class notion_checkbox_database_property : checkbox_property_base
# https://developers.notion.com/reference/property-object#checkbox
{
    #[bool] $checkbox = $false
    [string] $Name
    [string] $description

    notion_checkbox_page_property([bool]$checkbox) : base($checkbox)
    {
        $this.checkbox = $checkbox
    }


    static [notion_checkbox_page_property] ConvertFromObject($Value)
    {
        $notion_checkbox_page_property = [notion_checkbox_page_property]::new($Value.checkbox)
        return $notion_checkbox_page_property
    }
}
