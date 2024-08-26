class pp_email : PageProperties
{
    $type = "email"
    [string] $email

    pp_email($email)
    {
        $this.email = $email
    }
}
