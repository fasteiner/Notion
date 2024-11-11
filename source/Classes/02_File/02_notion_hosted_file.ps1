class notion_hosted_file_structure
# https://developers.notion.com/reference/file-object#notion-hosted-files
{
    [string]$url
    [string]$expiry_time

    notion_hosted_file_structure()
    {
    }

    notion_hosted_file_structure([string]$url, [string]$expiry_time)
    {
        $this.url = $url
        $this.expiry_time = Get-Date $expiry_time -Format "yyyy-MM-ddTHH:mm:ss.fffZ"
    }

    notion_hosted_file_structure([System.Object]$Value)
    {
        $this.url = $Value.url
        $this.expiry_time = Get-Date $Value.expiry_time -Format "yyyy-MM-ddTHH:mm:ss.fffZ"
    }

    static [notion_hosted_file_structure] ConvertFromObject($Value)
    {
        Write-Verbose "[notion_hosted_file_structure]::ConvertFromObject($($Value | ConvertTo-Json))"
        return [notion_hosted_file_structure]::new($Value.url, $Value.expiry_time)
    }
}

class notion_hosted_file : notion_file
{
    [notion_hosted_file_structure]$file

    notion_hosted_file():base("file")
    {
    }

    notion_hosted_file([string]$name, [string]$caption="",[string]$url, [string]$expiry_time):base("file", $name, $caption)
    {
        $this.file = [notion_hosted_file_structure]::new($url, $expiry_time)
    }

    notion_hosted_file([string]$name, [rich_text[]]$caption, [string]$url, [string]$expiry_time):base("file", $name, $caption)
    {
        $this.file = [notion_hosted_file_structure]::new($url, $expiry_time)
    }

    static [notion_hosted_file] ConvertFromObject($Value)
    {
        Write-Verbose "[notion_hosted_file]::ConvertFromObject($($Value | ConvertTo-Json))"
        $notionFileOb = [notion_hosted_file]::new()
        $notionFileOb.file = [notion_hosted_file_structure]::ConvertFromObject($Value.file)
        $notionFileOb.type = $Value.type
        $notionFileOb.caption = [rich_text]::ConvertFromObject($Value.caption)
        $notionFileOb.name = $Value.name
        return $notionFileOb
    }
}
