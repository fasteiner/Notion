class notion_last_edited_by_page_property : PagePropertiesBase
# https://developers.notion.com/reference/page-property-values#last-edited-by
{
    [notion_user] $last_edited_by

    notion_last_edited_by_page_property($value) : base("last_edited_by")
    {
        if($value -eq $null)
        {
            $this.last_edited_by = $null
            return
        }
        if($value -is [notion_user])
        {
            $this.last_edited_by = $value
        }
        else{
            $this.last_edited_by = [notion_user]::ConvertFromObject($value)
        }
    }

    static [notion_last_edited_by_page_property] ConvertFromObject($Value)
    {
        return [notion_last_edited_by_page_property]::new($Value.last_edited_by)
    }
}
