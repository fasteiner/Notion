class notion_rich_text_database_property : DatabasePropertiesBase
#https://developers.notion.com/reference/property-object#rich-text
{
    # $type = "rich_text"
    [hashtable] $rich_text 
    
    notion_rich_text_database_property() : base("rich_text")
    {
        $this.rich_text = @{}
    }


    static [notion_rich_text_database_property] ConvertFromObject($Value)
    {
        return [notion_rich_text_database_property]::new()
    }
}
