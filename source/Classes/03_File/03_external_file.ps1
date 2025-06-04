class notion_external_file_structure
# https://developers.notion.com/reference/file-object#external-files
{
    [string] $url

    # [notion_external_file]::new("http://..")
    notion_external_file_structure([string]$url)
    {
        $this.url = $url
    }

    static [notion_external_file_structure] ConvertFromObject($Value)
    {        
        Write-Verbose "[notion_external_file_structure]::ConvertFromObject($($Value | ConvertTo-Json))"
        return [notion_external_file_structure]::new($Value.url)
    }
}

class notion_external_file : notion_file
{
    [notion_external_file_structure] $external

    notion_external_file():base("external")
    {
    }
    notion_external_file([string]$name, $url):base("external", $name)
    {
        $this.external = [notion_external_file_structure]::new($url)
    }

    notion_external_file([string]$name, $caption, [string]$url):base("external", $name, $caption)
    {
        $this.external = [notion_external_file_structure]::new($url)
    }


    static [notion_external_file] ConvertFromObject($Value)
    {
        Write-Verbose "[notion_external_file]::ConvertFromObject($($Value | ConvertTo-Json))"
        $notionFileOb = [notion_external_file]::new()
        $notionFileOb.external = [notion_external_file_structure]::ConvertFromObject($Value.external)
        $notionFileOb.type = $Value.type
        $notionFileOb.caption = $Value.caption.ForEach({ [rich_text]::ConvertFromObject($_) })
        $notionFileOb.name = $Value.name
        return $notionFileOb
    }
}
