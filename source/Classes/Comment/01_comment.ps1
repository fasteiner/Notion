class notion_comment
#https://developers.notion.com/reference/comment-object
{
    [string]$object = "comment"
    [string]$id
    [notion_parent]$parent
    [string]$discussion_id
    [string]$created_time
    [string]$last_edited_time
    [notion_user]$created_by
    [rich_text[]]$rich_text = @()

    notion_comment()
    {
        $this.id = [guid]::NewGuid().ToString()
        $this.created_time = Get-Date -Format "yyyy-MM-ddTHH:mm:ss.fffZ" -AsUTC
    }
    
    notion_comment([string] $id)
    {
        $this.id = $id
        $this.created_time = Get-Date -Format "yyyy-MM-ddTHH:mm:ss.fffZ" -AsUTC
    }

    notion_comment([object] $parent, [string] $discussion_id, [string] $created_time, [string] $last_edited_time, [notion_user] $created_by, $rich_text)
    {
        $this.parent = ($parent -is [notion_parent] ? ($parent) : ([notion_parent]::ConvertFromObject($parent)))
        $this.discussion_id = $discussion_id
        $this.created_time = Get-Date -Format "yyyy-MM-ddTHH:mm:ss.fffZ" -AsUTC
        $this.last_edited_time = $this.created_time
        $this.created_by = $created_by
        if($rich_text -is [rich_text])
        {
            $this.rich_text = $rich_text
        }
        else
        {
            if($rich_text -is [string] -or $rich_text -is [datetime] -or $rich_text -is [int] -or $rich_text -is [double] -or $rich_text -is [bool])
            {
                $this.rich_text += [rich_text_text]::new($rich_text)
            }
            elseif ($rich_text -is [array]) {
                $this.rich_text += $rich_text.ForEach({[rich_text]::ConvertFromObject($_)})
            }
            else
            {
                $this.rich_text += [rich_text]::ConvertFromObject($rich_text)
            }
        }
    }

    notion_comment([string] $id, [object] $parent, [string] $discussion_id, [string] $created_time, [string] $last_edited_time, [notion_user] $created_by, [rich_text] $rich_text)
    {
        $this.id = $id
        $this.parent = $parent
        $this.discussion_id = $discussion_id
        $this.created_time = $created_time
        $this.last_edited_time = $last_edited_time
        $this.created_by = $created_by
        $this.rich_text = $rich_text
    }

    static [notion_comment] ConvertfromObject($Value)
    {
        $comment = [notion_comment]::new()
        $comment.id = $Value.id
        $comment.parent = $Value.parent
        $comment.discussion_id = $Value.discussion_id
        # "2022-07-15T21:46:00.000Z" -Format "yyyy-MM-ddTHH:mm:ss.fffZ"
        $comment.created_time = ConvertTo-NotionFormattedDateTime -InputDate $Value.created_time -fieldName "created_time"
        $comment.last_edited_time = ConvertTo-NotionFormattedDateTime -InputDate $Value.last_edited_time -fieldName "last_edited_time"
        $comment.created_by = $Value.created_by
        #TODO: Convert rich_text to class [rich_text]::new()
        $comment.rich_text = $Value.rich_text.ForEach({[rich_text]::ConvertFromObject($_)})
        return $comment
    }
}
