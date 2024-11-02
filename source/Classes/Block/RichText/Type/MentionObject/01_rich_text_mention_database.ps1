class rich_text_mention_database_structure
{
    [string] $id = ""

    rich_text_mention_database_structure() 
    {
    }
    rich_text_mention_database_structure($id)
    {
        $this.id = $id
    }

    static [rich_text_mention_database_structure] ConvertFromObject($value)
    {
        [rich_text_mention_database_structure] $struct = [rich_text_mention_database_structure]::new()
        $struct.id = $value.id
        return $struct
    }
}


class rich_text_mention_database : rich_text_mention_base
# https://developers.notion.com/reference/rich-text#mention
{
    [rich_text_mention_database_structure] $database
    

    rich_text_mention_database():base("database")
    {
    }

    rich_text_mention_database([rich_text_mention_database_structure] $database) :base("database")
    {
        $this.database = $database
    }

    rich_text_mention_database([string] $id) :base("database")
    {
        $this.database = [rich_text_mention_database_structure]::new($id)
    }

    [string] ToJson([bool]$compress = $false)
    {
        $json = @{
            type = $this.type
            database = @{
                id = $this.database.id
            }
            annotations = $this.annotations.ToJson()
            plain_text = $this.plain_text
            href = $this.href
        }
        return $json | ConvertTo-Json -Compress:$compress
    }

    static [rich_text_mention_database] ConvertFromObject($value)
    {
        return [rich_text_mention_database]::new($value.database)
    }
}
