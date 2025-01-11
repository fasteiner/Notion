class notion_phone_number_page_property : PagePropertiesBase
# https://developers.notion.com/reference/page-property-values#phone-number
{
    [string] $phone_number

    notion_phone_number_page_property($phone_number) : base("phone_number")
    {
        if ($phone_number.Length -gt 200)
        {
            throw [System.ArgumentException]::new("The phone number must be 200 characters or less.")
        }
        $this.phone_number = $phone_number
    }

    static [notion_phone_number_page_property] ConvertFromObject($Value)
    {
        return [notion_phone_number_page_property]::new($Value.phone_number)
    }   
}
