class notion_phone_number_page_property : PagePropertiesBase
# https://developers.notion.com/reference/page-property-values#phone-number
{
    [string] $phone_number

    notion_phone_number_page_property($phone_number) : base("phone_number")
    {
        $this.phone_number = $phone_number
    }

    static [notion_phone_number_page_property] ConvertFromObject($Value)
    {
        return [notion_phone_number_page_property]::new($Value.phone_number)
    }   
}
