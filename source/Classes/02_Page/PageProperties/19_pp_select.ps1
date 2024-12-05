class notion_select
# https://developers.notion.com/reference/page-property-values#select
{
    [notion_color] $color
    [string] $id
    [string] $name

    notion_select() 
    {

    }


    notion_select ($color, $id, $name)
    {
        $this.color = [Enum]::Parse([notion_color], $color)
        $this.id = $id
        $this.name = $name
    }

    static [notion_select] ConvertFromObject($Value)
    {
        return [notion_select]::new($Value.color, $Value.id, $Value.name)
    }
}

class notion_select_page_property : PagePropertiesBase {
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
