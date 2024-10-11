class pp_status : PageProperties
# https://developers.notion.com/reference/page-property-values#status
{
    [notion_color] $color
    [string] $id
    [string] $name

    pp_status($color, $id, $name)
    {
        $this.color = [Enum]::Parse([notion_color], $color)
        $this.id = $id
        $this.name = $name
    }

    static [pp_status] ConvertFromObject($Value)
    {
        return [pp_status]::new($Value.color, $Value.id, $Value.name)
    }
}
