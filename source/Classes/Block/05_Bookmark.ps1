class bookmark_structure
{
    [rich_text[]] $caption = @()
    [string] $url = $null

    bookmark_structure()
    {
    }

    bookmark_structure($bookmark)
    {
        if ($bookmark -is [string])
        {
            $this.url = $bookmark
            return
        }
        elseif ($bookmark -is [PSCustomObject])
        {
            $this.caption = [rich_text]::ConvertFromObjects($bookmark.caption)
            $this.url = $bookmark.url
        }
    }

    bookmark_structure([object]$caption, [string]$url)
    {
        $this.caption = [rich_text]::ConvertFromObjects($caption)
        $this.url = $url
    }

    static [bookmark_structure] ConvertFromObject($Value)
    {
        if ( $Value -is [bookmark_structure] )
        {
            return $value
        }
        return [bookmark_structure]::new($Value)
    }
}

class notion_bookmark_block : notion_block
# https://developers.notion.com/reference/block#bookmark
{
    [notion_blocktype] $type = "bookmark"
    [bookmark_structure] $bookmark
    
    notion_bookmark_block()
    {
    }

    notion_bookmark_block($url)
    {
        $this.bookmark = [bookmark_structure]::ConvertFromObject($url)
    }

    notion_bookmark_block($caption, [string]$url)
    {
        $this.bookmark = [bookmark_structure]::new($caption, $url)
    }


    static [notion_bookmark_block] ConvertFromObject($Value)
    {
        $bookmark_Obj = [notion_bookmark_block]::new()
        $bookmark_Obj.bookmark = [bookmark_structure]::new($Value.bookmark)
        return $bookmark_Obj
    }
}
