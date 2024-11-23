
class Image_structure
{
    [notion_file] $image


    Image_structure([notion_file] $file)
    {
        $this.image = $file
    }

    static [Image_structure] ConvertFromObject($Value)
    {
        return [Image_structure]::new($Value.image)
    }
}
class notion_image_block : notion_file
# https://developers.notion.com/reference/block#image
{
    [notion_blocktype] $type = "image"
    [Image_structure] $image

    notion_image_block([notion_file] $file)
    {
        $this.image = [Image_structure]::new($file)
    }
    
    static [notion_image_block] ConvertFromObject($Value)
    {
        $Image_Obj = [notion_image_block]::new()
        $Image_Obj.image = [Image_structure]::ConvertFromObject($Value.image)
        return $Image_Obj
    }
}
