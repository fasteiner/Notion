
class notion_image_block : notion_block
# https://developers.notion.com/reference/block#image
{
    [notion_blocktype] $type = "image"
    [notion_file] $image

    notion_image_block([notion_file] $file)
    {
        $this.image = $file
    }
    
    static [notion_image_block] ConvertFromObject($Value)
    {
        $Image_Obj = [notion_image_block]::new()
        $Image_Obj.image = [notion_file]::ConvertFromObject($Value.image)
        return $Image_Obj
    }
}
