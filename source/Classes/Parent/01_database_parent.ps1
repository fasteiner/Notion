class notion_database_parent : notion_parent {
    # https://developers.notion.com/reference/parent-object#database-parent
    [string] $database_id

    notion_database_parent() : base("database_id")
    {
    }

    notion_database_parent([string]$database_id) : base("database_id")
    {
        $this.database_id = $database_id
    }

    static [notion_database_parent] ConvertFromObject($Value)
    {
        return [notion_database_parent]::new($Value.database_id)
    }
}
