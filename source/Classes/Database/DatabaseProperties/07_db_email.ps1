class notion_email_database_property : DatabasePropertiesBase
# https://developers.notion.com/reference/property-object#email
{
    [hashtable] $email

    notion_email_database_property() : base("email")
    {
        $this.email = @{}
    }

    static [notion_email_database_property] ConvertFromObject($Value)
    {
        return [notion_email_database_property]::new()
    }
}
