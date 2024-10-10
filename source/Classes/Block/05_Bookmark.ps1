class Bookmark : Block
# https://developers.notion.com/reference/block#bookmark
{
    [blocktype] $type = "bookmark"
    [annotation[]] $caption
    [string] $url = $null


    static [Bookmark] ConvertFromObject($Value)
    {
        $bookmark = [Bookmark]::new()
        $bookmark.caption = [annotation]::ConvertFromObject($Value.caption)
        $bookmark.url = $Value.url
        return $bookmark
    }
}
