class notion_file_block : block {
    #https://developers.notion.com/reference/block#file
    [blocktype] $type = "file"
    [notion_file]$file

    notion_file_block()
    {
    }
    
    notion_file_block([string]$name, [string]$caption="",[string]$url, [string]$expiry_time)
    {
        $this.file = [notion_hosted_file]::new($name, $caption, $url, $expiry_time)
    }

    notion_file_block([string]$name, [rich_text[]]$caption, [string]$url, [string]$expiry_time)
    {
        $this.file = [notion_hosted_file]::new($name, $caption, $url, $expiry_time)
    }

    notion_file_block([string]$name, [string]$caption="",[string]$url)
    {
        $this.file = [notion_external_file]::new($name, $caption, $url)
    }

    notion_file_block([string]$name, [rich_text[]]$caption, [string]$url)
    {
        $this.file = [notion_external_file]::new($name, $caption, $url)
    }

    #direct object assignment, expected input is either notion_hosted_file or notion_external_file
    notion_file_block([notion_file]$file)
    {
        $this.file = $file
    }

    static [notion_file_block] ConvertFromObject($Value)
    {
        Write-Verbose "[notion_file_block]::ConvertFromObject($($Value | ConvertTo-Json))"
        return [notion_file]::ConvertFromObject($Value.file)
    }
}
