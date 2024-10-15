class Video : Block
# https://developers.notion.com/reference/block#video
{
    # [blocktype] $type = "video"
    # $video = @{
    #     "type"     = "external"
    #     "external" = @{
    #         "url" = $null
    #     }
    # }
    [string] $type = "external"

    Video($url)
    {
        $this.external.url = $url
    }

    static [Video] ConvertFromObject($Value)
    {
        return [Video]::new($Value.external.url)
    }
}
