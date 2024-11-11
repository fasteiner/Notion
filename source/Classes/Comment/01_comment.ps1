class comment
#https://developers.notion.com/reference/comment-object
{
    [string]$object = "comment"
    [string]$id
    [object]$parent
    [string]$discussion_id
    [string]$created_time
    [string]$last_edited_time
    [user]$created_by
    [rich_text]$rich_text

    comment()
    {
        $this.id = [guid]::NewGuid().ToString()
        $this.created_time = Get-Date -Format "yyyy-MM-ddTHH:mm:ss.fffZ" -AsUTC
    }
    
    comment([string] $id)
    {
        $this.id = $id
        $this.created_time = Get-Date -Format "yyyy-MM-ddTHH:mm:ss.fffZ" -AsUTC
    }

    static [comment] ConvertfromObject($Value)
    {
        $comment = [comment]::new()
        $comment.id = $Value.id
        $comment.parent = $Value.parent
        $comment.discussion_id = $Value.discussion_id
        # "2022-07-15T21:46:00.000Z" -Format "yyyy-MM-ddTHH:mm:ss.fffZ"
        $comment.created_time = $Value.created_time
        $comment.last_edited_time = Get-Date -Format "yyyy-MM-ddTHH:mm:ss.fffZ" $Value.last_edited_time
        $comment.created_by = $Value.created_by
        #TODO: Convert rich_text to class [rich_text]::new()
        $comment.rich_text = $Value.rich_text.ForEach({[rich_text]::ConvertFromObject($_)})
        return $comment
    }
}
