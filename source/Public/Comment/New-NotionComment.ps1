function New-NotionComment {
    <#
    .SYNOPSIS
        Instantiates a new Notion comment object.
    
    .DESCRIPTION
        This function creates a new local Notion comment object without sending it to the API.
    
    .PARAMETER ParentId
        The ID of the parent (page or discussion) where the comment should be associated.
    
    .PARAMETER RichText
        The content of the comment in plain text format.
    
    .EXAMPLE
        $comment = New-NotionComment -ParentId "12345678-abcd-efgh-ijkl-123456789012" -RichText "This is a test comment."
    
    .OUTPUTS
        Returns a new Notion comment object.
    #>
    [CmdletBinding()]
    [OutputType([notion_comment])]
    param (
        [object]$parent,
        [string]$discussion_id,
        [string]$created_time,
        [string]$last_edited_time,
        [notion_user]$created_by,
        [object[]]$rich_text
    )
    #TODO: Test
    return [notion_comment]::new($parent, $discussion_id, $created_time, $last_edited_time, $created_by, $rich_text)
}
