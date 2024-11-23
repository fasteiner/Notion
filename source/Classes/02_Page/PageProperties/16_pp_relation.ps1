class notion_relation_page_property : PagePropertiesBase
# https://developers.notion.com/reference/page-property-values#relation
{
    [bool] $has_more        # If a relation has more than 25 references, then the has_more value for the relation in the response object is true. If a relation doesn’t exceed the limit, then has_more is false.
    [notion_page_reference[]] $relation


    #TODO Stimmt das so?
    notion_relation_page_property($relation) : base("relation")
    {
        $this.relation = @()
        $this.has_more = $false
        $counter = 0
        foreach ($relation_item in $relation)
        {
            $this.relation += [notion_relation_page_property]::ConvertFromObject($relation_item)
            $counter++
            if ($counter -gt 25 )
            {
                $this.has_more = $true
            }
        }     
    }

    notion_relation_page_property($relation, $has_more) : base("relation")
    {
        $this.relation = @()
        $this.has_more = $has_more
        foreach ($relation_item in $relation)
        {
            $this.relation += [notion_relation_page_property]::ConvertFromObject($relation_item)
        }     
    }

    static [notion_relation_page_property] ConvertFromObject($Value)
    {
        return [notion_relation_page_property]::new($Value.relation, $Value.has_more)
    }
}
