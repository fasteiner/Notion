class notion_multi_select_page_property : PagePropertiesBase
# https://developers.notion.com/reference/page-property-values#multi-select
{
    [notion_multi_select_item_page_property[]] $multi_select

    notion_multi_select_page_property() : base("multi_select")
    {
        $this.multi_select = @()
    }

    notion_multi_select_page_property($color, $name) : base("multi_select")
    {
        $this.multi_select = @([notion_multi_select_item_page_property]::new($color, $name))
    }

    add($color, $name)
    {
        $this.multi_select += [notion_multi_select_item_page_property]::new($color, $name)
    }

    static [notion_multi_select_page_property] ConvertFromObject($Value)
    {
        $multi_select_obj = [notion_multi_select_page_property]::new()
        # the API reference says its in $Value.multi_select.options but it's actually in $Value.multi_select
        $multi_select_obj.multi_select = $Value.multi_select.foreach{
            [notion_multi_select_item_page_property]::ConvertFromObject($_)
        }
        return $multi_select_obj
    }
}
