class Image : Block
{
    [blocktype] $type = "image"
    $image = @{
        "type"     = "external"
        "external" = @{
            "url" = $null
        }
    }
}
