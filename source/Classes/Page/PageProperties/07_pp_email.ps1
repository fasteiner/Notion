class pp_email : PageProperties
# https://developers.notion.com/reference/page-property-values#email
{
    [string] $email

    pp_email($email)
    {
        $this.email = $email
    }

    static [pp_email] ConvertFromObject($Value)
    {
        return [pp_email]::new($Value.email)
    }
}
