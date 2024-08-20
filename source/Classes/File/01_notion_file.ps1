class notion_file
{
    # https://developers.notion.com/reference/file-object
    [string]$type
    [string]$file
    [string]$external

    file($url, $expiry_time)
    {
        $this.type = "file"
        $this.file = [notion_hosted_file]::new($url, $expiry_time)
    }
    
    file($url)
    {
        $this.type = "external"
        $this.external = [external_file]::new($url)
    }
}
