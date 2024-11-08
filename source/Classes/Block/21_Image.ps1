
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
class Image : notion_file
# https://developers.notion.com/reference/block#image
{
    [blocktype] $type = "image"
    [Image_structure] $image

    Image([notion_file] $file)
    {
        $this.image = [Image_structure]::new($file)
    }
    
    static [Image] ConvertFromObject($Value)
    {
        return [Image_structure]::new($Value.image)
    }
}
