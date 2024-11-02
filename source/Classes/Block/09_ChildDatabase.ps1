class child_database : Block
# https://developers.notion.com/reference/block#child-database
{
    [blocktype] $type = "child_database"
    [string] $title = $null


    child_database()
    {
    }

    child_database([string] $title)
    {
        $this.title = $title
    }

    static [child_database] ConvertFromObject($Value)
    {
        $child_database = [child_database]::new()
        $child_database.title = $Value.title
        return $child_database
    }
}
