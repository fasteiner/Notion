class notion_email_page_property : PagePropertiesBase
# https://developers.notion.com/reference/page-property-values#email
{
    [string] $email

    notion_email_page_property($email) : base("email")
    {
        $this.email = $email
    }

    static [notion_email_page_property] ConvertFromObject($Value)
    {
        return [notion_email_page_property]::new($Value.email)
    }
}
