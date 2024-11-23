class notion_files_page_property : PagePropertiesBase
# https://developers.notion.com/reference/page-property-values#files
{
    [notion_page_property_type]$type = [notion_page_property_type]::files
    [notion_file[]] $files

    notion_files_page_property([array]$files) : base("files")
    {
        $this.files = $files.ForEach({
            if($_ -is [notion_file])
            {
                $_
            }
            else
            {
                [notion_file]::ConvertFromObject($_)
            }
        })
    }

    static [notion_files_page_property] ConvertFromObject($Value)
    {
        return [notion_files_page_property]::new($Value.files)
    }
}
