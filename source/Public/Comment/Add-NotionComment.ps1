function Add-NotionComment {
    <#
    .SYNOPSIS
        Adds a comment to a Notion page or discussion.

    .DESCRIPTION
        The Add-NotionComment function adds a comment to a specified Notion page or discussion. 
        It can accept either a notion_comment object or individual parameters to create the comment.

    .PARAMETER Comment
        The notion_comment object to be added. This parameter is mandatory if using the "commentObj" parameter set.

    .PARAMETER parent
        The parent object of the comment. This parameter is optional and used in the "commentParams" parameter set.
        More info here: https://developers.notion.com/reference/database#page-parent

    .PARAMETER discussion_id
        The ID of the discussion to which the comment belongs. This parameter is optional and used in the "commentParams" parameter set.

    .PARAMETER rich_text
        The rich text content of the comment. This parameter is optional and used in the "commentParams" parameter set.

    .EXAMPLE
        $comment = Add-NotionComment -Comment $commentObject

    .EXAMPLE
        $comment = Add-NotionComment -parent $parentObject -rich_text "This is a comment."

    .OUTPUTS
        [notion_comment]
        Returns a notion_comment object representing the added comment.

    .NOTES
        This function requires the Invoke-NotionApiCall function to be defined.
    
    .LINK
        https://developers.notion.com/reference/create-a-comment
    #>
    [CmdletBinding()]
    [OutputType([notion_comment])]
    param (
        [Parameter(Mandatory=$true, ParameterSetName="commentObj", HelpMessage="The notion_comment object to be added. Can be generated using New-NotionComment.")]
        [notion_comment]$Comment,
        [Parameter(Mandatory=$false, ParameterSetName="commentParams", HelpMessage="The parent object of the comment.")]
        [notion_parent]$parent,
        [Parameter(Mandatory=$false, ParameterSetName="commentParams")]
        [string]$discussion_id,
        [Parameter(Mandatory=$true, ParameterSetName="commentParams")]
        [object]$rich_text
    )
    #TODO: Test
    if($PSCmdlet.ParameterSetName -eq "commentParams")
    {
        # Either the parent.page_id or discussion_id parameter must be provided — not both.
        if($parent -and $discussion_id)
        {
            Write-Error "Only one of the parent or discussion_id parameters can be provided." -Category InvalidArgument -TargetObject $PSBoundParameters
            return $null
        }
        # if non of the parent or discussion_id parameter is provided
        if(-not $parent -and -not $discussion_id)
        {
            Write-Error "Either the parent or discussion_id parameter must be provided." -Category InvalidArgument -TargetObject $PSBoundParameters
            return $null
        }
        $rt = @()
        if($rich_text -is [string] -or $rich_text -is [datetime] -or $rich_text -is [int] -or $rich_text -is [double] -or $rich_text -is [bool])
        {
            $rt += [rich_text_text]::new($rich_text)
        }
        elseif ($rich_text -is [array]) {
            $rt += $rich_text.ForEach({[rich_text]::ConvertFromObject($_)})
        }
        else
        {
            $rt += [rich_text]::ConvertFromObject($rich_text)
        }
        $Comment = [notion_comment]::new($parent, $discussion_id, $null, $null, $null, $rt)
    }
    $uri = "/comments"
    $response = Invoke-NotionApiCall -uri $uri -method "POST" -body $Comment
    return [notion_comment]::ConvertFromObject($response)
}
