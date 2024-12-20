class relation_property_base : PropertiesBase
{
    [bool] $has_more        # If a relation has more than 25 references, then the has_more value for the relation in the response object is true. If a relation doesn’t exceed the limit, then has_more is false.
    [notion_page_reference[]] $relation


    #TODO Stimmt das so?
    relation_property_base($relation) : base("relation")
    {
        $this.relation = @()
        $this.has_more = $false
        $counter = 0
        foreach ($relation_item in $relation)
        {
            $this.relation += [relation_property_base]::ConvertFromObject($relation_item)
            $counter++
            if ($counter -gt 25 )
            {
                $this.has_more = $true
            }
        }     
    }

    relation_property_base($relation, $has_more) : base("relation")
    {
        $this.relation = @()
        $this.has_more = $has_more
        foreach ($relation_item in $relation)
        {
            $this.relation += [relation_property_base]::ConvertFromObject($relation_item)
        }     
    }

    #TODO: Limit to max 100 releations
    # https://developers.notion.com/reference/request-limits#limits-for-property-values

    static [relation_property_base] ConvertFromObject($Value)
    {
        return [relation_property_base]::new($Value.relation, $Value.has_more)
    }
}
