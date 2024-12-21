class notion_date_page_property_structure 
# https://developers.notion.com/reference/page-property-values#date
{
    [string] $end
    [string] $start

    notion_date_page_property_structure() 
    {
        
    }

    notion_date_page_property_structure($start, $end)
    {
        $this.start = ConvertTo-NotionFormattedDateTime -InputDate $start -fieldName "start"
        #end is optional
        if($end)
        {
            $this.end = ConvertTo-NotionFormattedDateTime -InputDate $end -fieldName "end"
        }
    }

    static [notion_date_page_property_structure] ConvertFromObject($Value)
    {
        $date_page_obj = [notion_date_page_property_structure]::new($Value.start, $Value.end)
        return $date_page_obj
    }
}
class notion_date_page_property : PagePropertiesBase
{
    # https://developers.notion.com/reference/page-property-values#date
    [notion_date_page_property_structure] $date

    notion_date_page_property() : base("date")
    {
        $this.date = [notion_date_page_property_structure]::new()
    }

    notion_date_page_property($start, $end) : base("date")
    {
        $this.date = [notion_date_page_property_structure]::new($start, $end)
    }

    static [notion_date_page_property] ConvertFromObject($Value)
    {
        return [notion_date_page_property]::new($Value.date.start, $Value.date.end)
    }
    
}
