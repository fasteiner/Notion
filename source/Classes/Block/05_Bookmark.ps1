class Bookmark : Block
{
    [blocktype] $type = "bookmark"
    [annotation[]] $caption
    [string] $url = $null


    static ConvertFromObject($Value)
    {
        $bookmark = [Bookmark]::new()
        $bookmark.caption = [annotation]::ConvertFromObject($Value.caption)
        $bookmark.url = $Value.url
    }
}
