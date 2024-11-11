class Video_structure : notion_file
# https://developers.notion.com/reference/block#video
{
    Video_structure()
    {
    }

    Video_structure($url) :base($url)
    {
        
    }
    Video_structure($url, $expiry_time) :base($url, $expiry_time)
    {
        
    }
    Video_structure([notion_filetype] $filetype, $url, $expiry_time) :base($filetype, $url, $expiry_time)
    {
        
    }

    static [Video_structure] ConvertFromObject($Value)
    {
        return [notion_file]::ConvertFromObject($Value)
    }
}
class Video : notion_file
# https://developers.notion.com/reference/block#video
{
    [blocktype] $type = "video"

    Video()
    {
    }

    Video($url)
    {
        $this.video = [Video_structure]::new($url)
    }

    Video($url, $expiry_time)
    {
        $this.video = [Video_structure]::new($url, $expiry_time)
    }

    Video([notion_filetype] $filetype, $url, $expiry_time) :base($filetype, $url, $expiry_time)
    {
        $this.video = [Video_structure]::new($filetype, $url, $expiry_time)
    }

    static [Video] ConvertFromObject($Value)
    {
        $Video_Obj = [Video]::new()
        $Video_Obj.video = [Video_structure]::ConvertFromObject($Value.video)
        return $Video_Obj
    }
}
