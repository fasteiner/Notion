function Get-NotionComment {
    <#
    .SYNOPSIS
        Retrieves comments from a Notion discussion.
    
    .DESCRIPTION
        This function fetches comments linked to a specific discussion ID in Notion.
    
    .PARAMETER DiscussionId
        The ID of the discussion whose comments should be retrieved.
    
    .EXAMPLE
        Get-NotionComment -DiscussionId "abcd1234-efgh-5678-ijkl-9012mnop3456"
    
    .OUTPUTS
        Returns a list of comment objects.
    
    .LINK
        https://developers.notion.com/reference/retrieve-a-comment
    #>
    [CmdletBinding()]
    [OutputType([notion_comment[]])]
    param (
        [Parameter(Mandatory=$false, ParameterSetName="blockID")]
        [Alias("Id")]
        [string]$blockID,
        [Parameter(Mandatory=$false, ParameterSetName="blockObject")]
        [notion_block]$block
    )

    $uri = "/comments"
    if($PSCmdlet.ParameterSetName -eq "blockObject")
    {
        $blockID = $block.id
    }
    $queryParameters = @{
    }
    if( $blockID)
    {
        $queryParameters.Add("block_id", $blockID)
    }
    if ($queryParameters.Count -gt 0)
    {
        $uri += "?" + ($queryParameters.GetEnumerator() | ForEach-Object { "{0}={1}" -f $_.Key, $_.Value }) -join "&"
    }
    $response = Invoke-NotionApiCall -uri $uri -method "GET"
    #TODO: test
    return $response.foreach{
        [notion_comment]::ConvertFromObject($_)
    }
}
