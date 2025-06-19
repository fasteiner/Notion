


class notion_file : notion_icon
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

    notion_file([notion_filetype]$type, [string]$name)
    {
        $this.type = $type
        $this.name = $name
    }


    notion_file([notion_filetype]$type, [string]$name, $caption)
    {
        Write-Verbose "[notion_file]::new($type, $name, $($caption | ConvertTo-Json))"
        $this.type = $type
        $this.name = $name
        $this.caption = [rich_text]::ConvertFromObjects($caption)
    }

    static [notion_file] Create([notion_filetype] $type, [string] $name, $caption, [string] $url, $expiry_time = $null  )
    {
        $processedCaption = [rich_text]::ConvertFromObjects($caption)

        switch ($type)
        {
            "file"
            {
                return [notion_hosted_file]::new($name, $processedCaption, $url, $expiry_time)
            }
            "external"
            {
                return [notion_external_file]::new($name, $processedCaption, $url)
            }
            "file_upload "
            {
                # not implemented yet
                Write-Error "File upload type is not implemented yet." -Category NotImplemented -TargetObject $type
            }
            default
            {
                Write-Error "Invalid file type: $type. Supported types are 'file' or 'external'." -Category InvalidData -TargetObject $type
            }
        }
        return $null
    }


    static [notion_file] ConvertFromObject($Value)
    {
        Write-Verbose "[notion_file]::ConvertFromObject($($Value | ConvertTo-Json))"
        if ($null -eq $Value)
        {
            return $null
        }
        if ( $Value -is [notion_file] )
        {
            Write-Verbose "Value is already a notion_file object."
            return $Value
        }
        $fileObject = $null
        switch ($Value.type)
        {
            "file"
            {
                $fileObject = [notion_hosted_file]::ConvertFromObject($Value)
            }
            "external"
            {
                $fileObject = [notion_external_file]::ConvertFromObject($Value)
            }
            "file_upload"
            {
                # not implemented yet
                Write-Error "File upload type is not implemented yet." -Category NotImplemented -TargetObject $Value.type
            }
            default
            {
                Write-Error "Invalid file type: $($Value.type). Supported types are 'file' or 'external'." -Category InvalidData -TargetObject $Value.type
            }
        }      
        $fileObject.type = $Value.type
        if ($Value.caption)
        {
            $fileObject.caption = [rich_text]::ConvertFromObjects($Value.caption)
        }
        $fileObject.name = $Value.name
        return $fileObject
    }
}
