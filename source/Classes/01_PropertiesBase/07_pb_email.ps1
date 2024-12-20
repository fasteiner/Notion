class email_property_base : PropertiesBase
# https://developers.notion.com/reference/page-property-values#email
{
    [string] $email

    email_property_base($email) : base("email")
    {
        if ($email.Length -gt 200)
        {
            throw [System.ArgumentException]::new("The email must be 200 characters or less.")
        }
        $this.email = $email
    }

    static [email_property_base] ConvertFromObject($Value)
    {
        return [email_property_base]::new($Value.email)
    }
}
