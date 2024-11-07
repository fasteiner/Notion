class Image : notion_file
# https://developers.notion.com/reference/block#image
{
    [blocktype] $type = "image"
    [notion_file] $image

    Image([notion_file] $file) {
        $this.image = $file
    }
    
    static [Image] ConvertFromObject($Value)
    {
        return [Image]::new($Value.image)
    }
}
