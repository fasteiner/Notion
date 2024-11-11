class external_file_structure
# https://developers.notion.com/reference/file-object#external-files
{
    [string] $url

    # [external_file]::new("http://..")
    external_file_structure([string]$url)
    {
        $this.url = $url
    }

    static [external_file_structure] ConvertFromObject($Value)
    {        
        Write-Verbose "[external_file_structure]::ConvertFromObject($($Value | ConvertTo-Json))"
        return [external_file_structure]::new($Value.url)
    }
}

class external_file : notion_file
{
    [external_file_structure] $external

    external_file():base("external")
    {
    }
    external_file([string]$name, [string]$caption="",[string]$url):base("external", $name, $caption)
    {
        $this.external = [external_file_structure]::new($url)
    }
    external_file([string]$name, [rich_text[]]$caption, [string]$url):base("external", $name, $caption)
    {
        $this.external = [external_file_structure]::new($url)
    }


    static [external_file] ConvertFromObject($Value)
    {
        Write-Verbose "[external_file]::ConvertFromObject($($Value | ConvertTo-Json))"
        $notionFileOb = [external_file]::new()
        $notionFileOb.external = [external_file_structure]::ConvertFromObject($Value.external)
        $notionFileOb.type = $Value.type
        $notionFileOb.caption = [rich_text]::ConvertFromObject($Value.caption)
        $notionFileOb.name = $Value.name
        return $notionFileOb
    }
}
