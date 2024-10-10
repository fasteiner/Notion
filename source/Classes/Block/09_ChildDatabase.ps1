class ChildDatabase : Block
# https://developers.notion.com/reference/block#child-database
{
    [blocktype] $type = "child_database"
    [string] $title = $null
}

static [ChildDatabase] ConvertFromObject($Value)
{
    $ChildDatabase = [ChildDatabase]::new()
    $ChildDatabase.title = $Value.title
    return $ChildDatabase
}
