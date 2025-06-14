class notion_video_block : notion_block
# https://developers.notion.com/reference/block#video
{
    [notion_blocktype] $type = "video"
    [notion_file]$video


    notion_video_block()
    {
    }

    notion_video_block($url)
    {
        $this.video = [notion_external_file]::new($url)
    }

    notion_video_block($url, $expiry_time)
    {
        $this.video = [notion_file]::new([notion_filetype]::file, $url, $expiry_time)
    }

    notion_video_block([notion_filetype] $filetype, $url, $expiry_time)
    {
        $this.video = [notion_file]::Create($filetype, "", @(), $url, $expiry_time)
    }
    notion_video_block([notion_filetype] $filetype, $name, $caption, $url, $expiry_time)
    {
        $this.video = [notion_file]::Create($filetype, $name, $caption, $url, $expiry_time)
    }



    static [notion_video_block] ConvertFromObject($Value)
    {
        $Video_Obj = [notion_video_block]::new()
        $Video_Obj.video = [notion_file]::ConvertFromObject($Value.video)
        return $Video_Obj
    }
}
