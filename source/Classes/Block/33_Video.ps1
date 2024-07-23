class Video : Block
{
    [blocktype] $type = "video"
    $video = @{
        "type"     = "external"
        "external" = @{
            "url" = $null
        }
    }
}
