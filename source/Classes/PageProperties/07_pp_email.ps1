class pp_email : PageProperties
# https://developers.notion.com/reference/page-property-values#email
{
    $type = "email"
    [string] $email

    pp_email($email)
    {
        $this.email = $email
    }
}
