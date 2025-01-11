
class notion_select_page_property : PagePropertiesBase {
    # https://developers.notion.com/reference/page-property-values#select
    [notion_select] $select

    notion_select_page_property() : base("select")
    {
        $this.select = [notion_select]::new()
    }

    notion_select_page_property($color, $id, $name) : base("select")
    {
        $this.select = [notion_select]::new($color, $id, $name)
    }

    static [notion_select_page_property] ConvertFromObject($Value)
    {
        return [notion_select_page_property]::new($Value.select.color, $Value.select.id, $Value.select.name)
    }
}
