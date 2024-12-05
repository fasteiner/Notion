class notion_sub_type_unfurl_attribute
# https://developers.notion.com/reference/unfurl-attribute-object#inline-sub_type-objects
{
    $color
    $date
    $datetime
    $enum
    $plain_text
    $title

    sub_type($color, $date, $datetime, $enum, $plain_text, $title)
    {
        $this.color = $color
        $this.date = $date
        $this.datetime = $datetime
        $this.enum = $enum
        $this.plain_text = $plain_text
        $this.title = $title
    }
}
