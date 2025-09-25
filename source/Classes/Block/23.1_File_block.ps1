class notion_file_block : notion_block 
{
    #https://developers.notion.com/reference/block#file
    [notion_blocktype] $type = "file"
    [notion_file]$file

    notion_file_block()
    {
    }
    
    notion_file_block($name, $caption, $url, $expiry_time)
    {
        $caption = [rich_text]::ConvertFromObjects($caption)
        $this.file = [notion_hosted_file]::new($name, $caption, $url, $expiry_time)
    }


    notion_file_block($name, $caption, [string]$url)
    {
        Write-Verbose "notion_file_block::new($name, $($caption | ConvertTo-Json -Depth 5 -EnumsAsStrings), $url)"
        $caption = [rich_text]::ConvertFromObjects($caption)
        $this.file = [notion_external_file]::new($name, $caption, $url)
    }


    #direct object assignment, expected input is either notion_hosted_file or notion_external_file
    notion_file_block($file)
    {
        $this.file = [notion_file]::ConvertFromObject($file)
    }

    static [notion_file_block] ConvertFromObject($Value)
    {
        Write-Verbose "[notion_file_block]::ConvertFromObject($($Value | ConvertTo-Json))"
        if ($Value -is [notion_file_block])
        {
            return $Value
        }
        $obj = [notion_file_block]::new()
        $obj.file = [notion_file]::ConvertFromObject($Value.file)
        return $obj
    }
}
