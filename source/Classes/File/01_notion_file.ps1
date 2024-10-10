class notion_file
# https://developers.notion.com/reference/file-object
{
    [string]$type
    [string]$file
    [string]$external

    notion_file($url, $expiry_time)
    {
        $this.type = "file"
        $this.file = [notion_hosted_file]::new($url, $expiry_time)
    }
    
    notion_file($url)
    {
        $this.type = "external"
        $this.external = [external_file]::new($url)
    }

    static [notion_file] ConvertFromObject($Value)
    {
        if ($Value.type -eq "file")
        {
            return [notion_file]::new($Value.file.url, $Value.file.expiry_time)
        }
        else
        {
            return [notion_file]::new($Value.external.url)
        }
    }
}
