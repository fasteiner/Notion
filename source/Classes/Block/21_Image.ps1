
class notion_image_block : notion_block
# https://developers.notion.com/reference/block#image
{
    [notion_blocktype] $type = "image"
    [notion_file] $image

    notion_image_block()
    {
    }

    notion_image_block($file)
    {
        $this.image = [notion_file]::ConvertFromObject($file)
    }
    
    static [notion_image_block] ConvertFromObject($Value)
    {
        if ( -not $Value)
        {
            return $null
        }
        if ($Value -is [notion_image_block])
        {
            return $Value
        }
        $Image_Obj = [notion_image_block]::new()
        if($value -is [notion_file])
        {
            $Image_Obj.image = $Value
        }
        else{
            $Image_Obj.image = [notion_file]::ConvertFromObject($Value.image)
        }
        return $Image_Obj
    }
}
