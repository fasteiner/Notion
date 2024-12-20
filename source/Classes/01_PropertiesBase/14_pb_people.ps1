class people_property_base : PropertiesBase
{
    [notion_people_user[]] $people

    people_property_base([object[]]$people) : base("people")
    {
        foreach ($person in $people)
        {
            if ($person -is [notion_people_user])
            {
                $this.people += $person
            }
            else
            {
                $this.people += [notion_people_user]::ConvertFromObject($person)
            }
        }
    }

    static [people_property_base] ConvertFromObject($Value)
    {
        return [people_property_base]::new($Value.people)
    }
}
