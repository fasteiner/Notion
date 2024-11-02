class Video : notion_file
# https://developers.notion.com/reference/block#video
{
    [blocktype] $type = "video"

    Video()
    {
    }

    Video($url) :base($url)
    {
        
    }
    Video($url, $expiry_time) :base($url, $expiry_time)
    {
        
    }
    Video([notion_filetype] $filetype, $url, $expiry_time) :base($filetype, $url, $expiry_time)
    {
        
    }

    static [Video] ConvertFromObject($Value)
    {
        return [notion_file]::ConvertFromObject($Value)
    }
}
