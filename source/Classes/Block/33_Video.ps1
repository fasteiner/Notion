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
class notion_video_block : notion_file
# https://developers.notion.com/reference/block#video
{
    [notion_blocktype] $type = "video"

    notion_video_block()
    {
    }

    Video($url)
    {
        $this.video = [Video_structure]::new($url)
    }

    notion_video_block($url, $expiry_time)
    {
        $this.video = [Video_structure]::new($url, $expiry_time)
    }

    notion_video_block([notion_filetype] $filetype, $url, $expiry_time) :base($filetype, $url, $expiry_time)
    {
        $this.video = [Video_structure]::new($filetype, $url, $expiry_time)
    }

    static [notion_video_block] ConvertFromObject($Value)
    {
        $Video_Obj = [notion_video_block]::new()
        $Video_Obj.video = [Video_structure]::ConvertFromObject($Value.video)
        return $Video_Obj
    }
}
