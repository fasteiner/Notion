class pp_relation : PageProperties
# https://developers.notion.com/reference/page-property-values#relation
{
    [bool] $has_more        # If a relation has more than 25 references, then the has_more value for the relation in the response object is true. If a relation doesn’t exceed the limit, then has_more is false.
    [array] $relation


    #TODO Stimmt das so?
    pp_relation($relation)
    {
        $this.relation = @()
        foreach ($relation_item in $relation)
        {
            $this.relation += [pp_relation]::ConvertFromObject($relation_item)
        }
        if ($this.relation.count -gt 25 )
        {
            $this.has_more = 1
        }
        else
        {
            $this.has_more = 0
        }        
    }

    static [pp_relation] ConvertFromObject($Value)
    {
        $pp_relation = [pp_relation]::new($Value.relation)
        return $pp_relation
    }
}
