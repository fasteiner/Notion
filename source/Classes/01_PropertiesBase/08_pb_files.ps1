class files_property_base : PropertiesBase
# https://developers.notion.com/reference/page-property-values#files
{
    [notion_property_base_type]$type = [notion_page_property_type]::files
    [notion_file[]] $files

    files_property_base([array]$files) : base("files")
    {
        $this.files = $files.ForEach({
                if ($_ -is [notion_file])
                {
                    $_
                }
                else
                {
                    [notion_file]::ConvertFromObject($_)
                }
            })
    }

    static [files_property_base] ConvertFromObject($Value)
    {
        return [files_property_base]::new($Value.files)
    }
}
