class child_database_structure
{
    [string] $title = $null
    
    child_database_structure()
    {
    }

    child_database_structure([string] $title)
    {
        $this.title = $title
    }

    static [child_database_structure] ConvertFromObject($Value)
    {
        $child_database_structure = [child_database]::new()
        $child_database_structure.title = $Value.title
        return $child_database_structure
    }
}
class child_database : block
# https://developers.notion.com/reference/block#child-database
{
    [blocktype] $type = "child_database"
    [child_database_structure] $child_database


    #TODO: Creating and updating child_database blocks
    #TODO: To create or update child_database type blocks, use the Create a database and the Update a database endpoints, specifying the ID of the parent page in the parent body param.
    child_database()
    {
        $this.child_database = [child_database_structure]::new()
    }

    child_database([string] $title)
    {
        $this.child_database = [child_database_structure]::new($title)
    }

    static [child_database] ConvertFromObject($Value)
    {
        $child_database_obj = [child_database_structure]::new($Value.child_database)
        return $child_database_obj
    }
}
