class notion_hosted_file_structure
# https://developers.notion.com/reference/file-object#notion-hosted-files
{
    [string]$url
    [string]$expiry_time

    notion_hosted_file_structure()
    {
    }

    notion_hosted_file_structure([string]$url, $expiry_time)
    {
        $this.url = $url
        $this.expiry_time = ConvertTo-NotionFormattedDateTime -InputDate $expiry_time -fieldName "expiry_time"
    }

    notion_hosted_file_structure([System.Object]$Value)
    {
        $this.url = $Value.url
        $this.expiry_time = ConvertTo-NotionFormattedDateTime -InputDate $Value.expiry_time -fieldName "expiry_time"
    }

    static [notion_hosted_file_structure] ConvertFromObject($Value)
    {
        if ($Value -is [notion_hosted_file_structure])
        {
            Write-Verbose "[notion_hosted_file_structure]::ConvertFromObject($($Value | ConvertTo-Json)) - already a notion_hosted_file_structure"
            return $Value
        }
        Write-Verbose "[notion_hosted_file_structure]::ConvertFromObject($($Value | ConvertTo-Json))"
        return [notion_hosted_file_structure]::new($Value.url, $Value.expiry_time)
    }
}

class notion_hosted_file : notion_file
{
    [notion_hosted_file_structure]$file
    [rich_text[]]$caption

    notion_hosted_file():base("file")
    {
    }

    notion_hosted_file([string]$url, $expiry_time):base("file", $name)
    {
        Write-Verbose "[notion_hosted_file]::new($url, $expiry_time)"
        $this.file = [notion_hosted_file_structure]::new($url, $expiry_time)
    }

    notion_hosted_file([string]$name, $caption, [string]$url, $expiry_time):base("file", $name, $caption)
    {
        Write-Verbose "[notion_hosted_file]::new($name, $($caption | ConvertTo-Json), $url, $expiry_time)"
        $this.caption = [rich_text]::ConvertFromObjects($caption)
        $this.file = [notion_hosted_file_structure]::new($url, $expiry_time)
    }

    static [notion_hosted_file] ConvertFromObject($Value)
    {
        Write-Verbose "[notion_hosted_file]::ConvertFromObject($($Value | ConvertTo-Json))"
        $notion_file_obj = [notion_hosted_file]::new()
        $notion_file_obj.file = [notion_hosted_file_structure]::ConvertFromObject($Value.file)
        $notion_file_obj.type = $Value.type
        $notion_file_obj.caption = [rich_text]::ConvertFromObjects($Value.caption)
        $notion_file_obj.name = $Value.name
        return $notion_file_obj
    }
}
