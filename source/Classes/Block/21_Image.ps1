class Image : Block
# https://developers.notion.com/reference/block#image
{
    [blocktype] $type = "image"
    $image = @{
        "type"     = "external"
        "external" = @{
            "url" = $null
        }
    }
    
    # static [Image] ConvertFromObject($Value)
    # {
    #     $Image = [Image]::new()
    #     $Image.image.external.url = $Value.url
    #     return $Image
    # }
}
