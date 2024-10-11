class pp_files : PageProperties
# https://developers.notion.com/reference/page-property-values#files
{
    [notion_file[]] $files

    pp_files([array]$files)
    {
        $this.files = [notion_file]::ConvertFromObject($files)
    }

    static [pp_files] ConvertFromObject($Value)
    {
        return [pp_files]::new($Value.files)
    }
}
