class notion_created_by_page_property : PagePropertiesBase
# https://developers.notion.com/reference/page-property-values#created-by
{
    [user] $created_by
    
    notion_created_by_page_property($created_by) : base("created_by")
    {
        if($created_by -eq $null)
        {
            $this.created_by = $null
            return
        }
        if($created_by -is [user])
        {
            $this.created_by = $created_by
        }
        else{
            $this.created_by = [user]::ConvertFromObject($created_by)
        }
    }

    static [notion_created_by_page_property] ConvertFromObject($Value)
    {
        $created_by_obj = [notion_created_by_page_property]::new($Value.created_by)
        return $created_by_obj
    }
}
