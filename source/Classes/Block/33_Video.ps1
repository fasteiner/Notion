class Video : Block
# https://developers.notion.com/reference/block#video
{
    [blocktype] $type = "video"
    $video = @{
        "type"     = "external"
        "external" = @{
            "url" = $null
        }
    }

    static [Video] ConvertFromObject($Value)
    {
        $Video = [Video]::new()
        $Video.video.external.url = $Value.url
        return $Video
    }
}
