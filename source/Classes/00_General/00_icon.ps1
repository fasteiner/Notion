class notion_icon
{
    # https://developers.notion.com/reference/page

    static [notion_icon] ConvertFromObject($Value)
    {
        if ($null -eq $Value)
        {
            return $null
        }
        $icon_obj = $null
        switch ($Value.type)
        {
            # not supported according to the documentation, but it is returned by the API
            "file"
            {
                $icon_obj = [notion_hosted_file]::ConvertFromObject($Value.file)
            }
            "external"
            {
                $icon_obj = [notion_external_file]::ConvertFromObject($Value.external)
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
