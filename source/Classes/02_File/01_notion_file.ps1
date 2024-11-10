class notion_file
# https://developers.notion.com/reference/file-object
{
    [notion_filetype]$type
    [string]$file

    notion_file()
    {
    }

    notion_file($url, $expiry_time)
    {
        $this.type = "file"
        $this.file = [notion_hosted_file]::new($url, $expiry_time)
    }
    
    notion_file($url)
    {
        $this.type = "external"
        $this | Add-Member -MemberType NoteProperty -Name "external" -Value ([external_file]::new($url))
    }

    ## generic constructor
    notion_file([notion_filetype]$filetype, $url, $expiry_time)
    {
        $this.type = $filetype
        if ($filetype -eq "file")
        {
            $this.file = [notion_hosted_file]::new($url, $expiry_time)
        }
        else
        {
            $this | Add-Member -MemberType NoteProperty -Name "external" -Value ([external_file]::new($url))
        }
    }

    static [notion_file] ConvertFromObject($Value)
    {
        $notionFile = [notion_file]::new()
        $notionFile.type = $Value.type

        if ($Value.type -eq "file")
        {
            $notionFile.file = [notion_hosted_file]::new($Value.url, $Value.expiry_time)
        }
        else
        {
            $notionFile | Add-Member -MemberType NoteProperty -Name "external" -Value ([external_file]::new($Value.url))
        }

        return $notionFile
    }
}
