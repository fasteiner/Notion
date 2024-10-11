class pp_people : PageProperties
# https://developers.notion.com/reference/page-property-values#people
{
    [user[]] $people

    pp_people($people)
    {
        if ($people -is [array])
        {
            foreach ($person in $people)
            {
                $this.people += [user]::ConvertFromObject($person)
            }
        }
        else
        {
            $this.people = [user]::ConvertFromObject($people)
        }
    }

    static [pp_people] ConvertFromObject($Value)
    {
        $pp_people = [pp_people]::new($Value.people)
        return $pp_people
    }
}
