
class notion_image_block : notion_block
# https://developers.notion.com/reference/block#image
{
    [notion_blocktype] $type = "image"
    [notion_file] $image
    [rich_text[]] $caption = @()

    notion_image_block()
    {
    }

    notion_image_block([notion_file] $file)
    {
        $this.image = [notion_file]::ConvertFromObject($file)
    }

    notion_image_block($file, $caption)
    {
        $this.image = [notion_file]::ConvertFromObject($file)
        $this.caption = [rich_text]::ConvertFromObjects($caption)
    }
    
    static [notion_image_block] ConvertFromObject($Value)
    {
        $Image_Obj = [notion_image_block]::new()
        $Image_Obj.image = [notion_file]::ConvertFromObject($Value.image)
        $Image_Obj.caption = [rich_text]::ConvertFromObjects($Value.caption)
        return $Image_Obj
    }
}
