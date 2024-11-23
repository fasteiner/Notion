class notion_people_user : notion_user
{
    # https://developers.notion.com/reference/user#people
    [string]$person
    [string]$person_email

    notion_people_user()
    {
    }

    
    static [notion_people_user] ConvertFromObject($Value)
    {
        # $people.person = [notion_people_user]::new($value)
        # $people.person.email = $Value.email
        # return $people
        return $null
    }
}
