class Image : notion_file
# https://developers.notion.com/reference/block#image
{
    [blocktype] $type = "image"
    
    
    # static [Image] ConvertFromObject($Value)
    # {
    #     $Image = [Image]::new()
    #     $Image.image.external.url = $Value.url
    #     return $Image
    # }
}
