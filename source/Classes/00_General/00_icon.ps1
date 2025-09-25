class notion_icon
{
    # https://developers.notion.com/reference/page-property-values#icon
    # https://developers.notion.com/reference/database

    static [notion_icon] Create($Value)
    {
        if ($null -eq $Value)
        {
            return $null
        }
        if ($Value -is [notion_icon])
        {
            return $Value
        }
        if ($Value -is [string])
        {
            #check if the string is a URL or an emoji
            if ($Value -match '^(https?://)')
            {
                # it's a URL, so we assume it's an external file
                return [notion_external_file]::new($Value)
            }
            else
            {
                return [notion_emoji]::new($Value)
            }
        }
        return [notion_icon]::ConvertFromObject($Value)
    }

    static [notion_icon] Create ($url, $ExpiryTime)
    {
        if ($url -and $ExpiryTime)
        {
            return [notion_hosted_file]::new($url, $ExpiryTime)
        }
        elseif ($url)
        {
            return [notion_external_file]::new($url)
        }
        else
        {
            Write-Error "You must provide either a URL or an ExpiryTime to create a notion_icon." -Category InvalidArgument -TargetObject $url -RecommendedAction "Please provide a valid URL or URL and ExpiryTime."
        }
        return $null
    }

    static [notion_icon] ConvertFromObject($Value)
    {
        if ($null -eq $Value)
        {
            return $null
        }
        $icon_obj = $null
        if ($value -is [string])
        {
            if ($value -match '^(https?://)')
            {
                # it's a URL, so we assume it's an external file
                return [notion_external_file]::new($Value)
            }
            else
            {
                return [notion_emoji]::new($Value)
            }
        }

        switch ($Value.type)
        {
            # not supported according to the documentation, but it is returned by the API
            "file"
            {
                $icon_obj = [notion_hosted_file]::ConvertFromObject($Value)
            }
            "external"
            {
                $icon_obj = [notion_external_file]::ConvertFromObject($Value)
            }
            "emoji"
            {
                $icon_obj = [notion_emoji]::new($Value.emoji) 
            }
            default
            {
                Write-Error "Unknown icon type $($Value.type)" -Category InvalidData -TargetObject $Value -RecommendedAction "Please provide a valid icon type (file, external or emoji)"
            }
        }
        return $icon_obj
    }

}
