class notion_files_database_property : DatabasePropertiesBase
# https://developers.notion.com/reference/property-object#files
{
    [hashtable] $files

    notion_files_database_property([array]$files) : base("files")
    {
        $this.files = @{}
    }

    static [notion_files_database_property] ConvertFromObject($Value)
    {
        return [notion_files_database_property]::new()
    }
}
