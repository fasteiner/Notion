class people
{
    # https://developers.notion.com/reference/user#people
    [string]$person
    [string]$person_email

    people()
    {
        Write-Warning "This object is for display only."
    }

    #TODO person
    # static [people] ConvertFromObject($Value)
    # {
    #     $people.person = [user]::new($value)
    #     $people.person.email = $Value.??
    #     return $people
    # }
}
