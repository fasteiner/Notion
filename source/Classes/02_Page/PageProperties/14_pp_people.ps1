class notion_people_page_property : PagePropertiesBase
# https://developers.notion.com/reference/page-property-values#people
{
    [notion_people_user[]] $people

    notion_people_page_property([object[]]$people) : base("people")
    {
        foreach($person in $people)
        {
            if($person -is [notion_people_user])
            {
                $this.people += $person
            }
            else{
                $this.people += [notion_people_user]::ConvertFromObject($person)
            }
        }
    }

    static [notion_people_page_property] ConvertFromObject($Value)
    {
        return [notion_people_page_property]::new($Value.people)
    }
}
