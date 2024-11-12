class notion_number_page_property : PagePropertiesBase
# https://developers.notion.com/reference/page-property-values#number
{
    [double] $number

    notion_number_page_property($number) : base("number")
    {
        $this.number = [double]$number
    }

    static [notion_number_page_property] ConvertFromObject($Value)
    {
        return [notion_number_page_property]::new($Value.number)
    }
}
