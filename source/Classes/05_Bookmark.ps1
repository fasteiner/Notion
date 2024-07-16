class Bookmark : Block
{
    [blocktype] $type = "bookmark"
    [annotation[]] $caption
    [string] $url = $null
}
