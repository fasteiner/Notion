class ChildPage : Block
# https://developers.notion.com/reference/block#child-page
{
    [blocktype] $type = "child_page"
    [string] $title = $null
}

static [ChildPage] ConvertFromObject($Value)
{
    $ChildPage = [ChildPage]::new()
    $ChildPage.title = $Value.title
    return $ChildPage
}
