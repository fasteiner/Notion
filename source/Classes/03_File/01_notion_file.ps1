


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

    #string caption (optional)
    notion_file([notion_filetype]$type, [string]$name, [string]$caption = "")
    {
        $this.type = $type
        $this.name = $name
        if ([string]::IsNullOrEmpty($caption) -eq $false)
        {
            $this.caption = @([rich_text_text]::new($caption))
        }
    }

    notion_file([notion_filetype]$type, [string]$name, [object[]] $caption)
    {
        Write-Verbose "[notion_file]::new($type, $name, $($caption | ConvertTo-Json))"
        $this.type = $type
        $this.name = $name
        $this.caption = @()
        foreach ($item in $caption)
        {
            if ($item -is [string])
            {
                $this.caption += [rich_text_text]::new($item)
            }
            elseif ($item -is [rich_text])
            {
                $this.caption += $item
            }
            else
            {
                $this.caption += [rich_text]::ConvertFromObject($item)
            }
        }
    }

    static [notion_file] Create([notion_filetype] $type, [string] $name, [object[]] $caption, [string] $url, $expiry_time = $null  )
    {
        $processedCaption = @()
        foreach ($item in $caption)
        {
            if ($item -is [string])
            {
                $processedCaption += [rich_text_text]::new($item)
            }
            elseif ($item -is [rich_text])
            {
                $processedCaption += $item
            }
            else
            {
                $processedCaption += [rich_text]::ConvertFromObject($item)
            }
        }

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
        if ($Value.type -eq "file")
        {
            $fileObject = [notion_hosted_file]::ConvertFromObject($Value)
        }
        else
        {
            $fileObject = [notion_external_file]::ConvertFromObject($Value)
        }
        $fileObject.type = $Value.type
        $fileObject.caption = $Value.caption.ForEach({ [rich_text]::ConvertFromObject($_) })
        $fileObject.name = $Value.name
        return $fileObject
    }
}
