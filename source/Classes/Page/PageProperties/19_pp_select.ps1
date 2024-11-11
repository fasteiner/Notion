class pp_select : PageProperties
# https://developers.notion.com/reference/page-property-values#select
{
    [notion_color] $color
    [string] $id
    [string] $name


    pp_select ($color, $id, $name)
    {
        $this.color = [Enum]::Parse([notion_color], $color)
        $this.id = $id
        $this.name = $name
    }

    static [pp_select] ConvertFromObject($Value)
    {
        return [pp_select]::new($Value.color, $Value.id, $Value.name)
    }
}
