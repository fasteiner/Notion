class notion_multi_select_page_property : notion_multi_select_item_page_property
# https://developers.notion.com/reference/page-property-values#multi-select
{
    [notion_multi_select_item_page_property[]] $multi_select

    notion_multi_select_page_property($color, $name) : base($color, $name)
    {
        $this.multi_select = [notion_multi_select_item_page_property]::new($color, $name)
    }

    add($color, $name)
    {
        $this.multi_select += [notion_multi_select_item_page_property]::new($color, $name)
    }

    static [notion_multi_select_page_property] ConvertFromObject($Value)
    {
        $multi_select_obj = [notion_multi_select_page_property]::new()
        $multi_select_obj.multi_select = $Value.multi_select.options.foreach{
            [notion_multi_select_item_page_property]::ConvertFromObject($_)
        }
        return $multi_select_obj
    }
}
