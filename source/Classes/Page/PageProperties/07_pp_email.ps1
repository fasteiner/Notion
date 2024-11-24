class notion_email_page_property : PagePropertiesBase
# https://developers.notion.com/reference/page-property-values#email
{
    [string] $email

    notion_email_page_property($email) : base("email")
    {
        if ($email.Length -gt 200)
        {
            throw [System.ArgumentException]::new("The email must be 200 characters or less.")
        }
        $this.email = $email
    }

    static [notion_email_page_property] ConvertFromObject($Value)
    {
        return [notion_email_page_property]::new($Value.email)
    }
}
