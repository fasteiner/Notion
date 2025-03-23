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
