


class notion_file
# https://developers.notion.com/reference/file-object
# https://developers.notion.com/reference/block#file
{
    [notion_filetype]$type
    #caption and name are only used in block/file
    [rich_text[]] $caption = @()
    [string] $name


    notion_file([notion_filetype]$type)
    {
        $this.type = $type
    }

    #string caption (optional)
    notion_file([notion_filetype]$type, [string]$name, [string]$caption = "")
    {
        $this.type = $type
        $this.name = $name
        if([string]::IsNullOrEmpty($caption) -eq $false)
        {
            $this.caption = @([rich_text_text]::new($caption))
        }
    }

    notion_file([notion_filetype]$type, [string]$name, [rich_text[]] $caption)
    {
        $this.type = $type
        $this.name = $name
        $this.caption = $caption
    }


    static [notion_file] ConvertFromObject($Value)
    {
        Write-Verbose "[notion_file]::ConvertFromObject($($Value | ConvertTo-Json))"
        $fileObject = $null
        if ($Value.type -eq "file")
        {
            $fileObject = [notion_hosted_file]::ConvertFromObject($Value)
        }
        else
        {
            $fileObject = [external_file]::ConvertFromObject($Value)
        }
        $fileObject.type = $Value.type
        $fileObject.caption = [rich_text]::ConvertFromObject($Value.caption)
        $fileObject.name = $Value.name
        return $fileObject
    }
}
