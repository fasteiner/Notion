function Move-NotionPageToArchive {
    <#
    .SYNOPSIS
    Moves a Notion page to the archive.
    
    .DESCRIPTION
    The Move-NotionPageToArchive function moves a specified Notion page to the archive by setting the 'archived' property to true. 
    
    .PARAMETER PageId
    The ID of the page to remove. This parameter is mandatory.
    
    .EXAMPLE
    Move-NotionPageToArchive -PageId "12345678-90ab-cdef-1234-567890abcdef"
    This example moves the Notion page https://www.notion.so/12345678-90ab-cdef-1234-567890abcdef with the specified ID to the trash.
    
    .NOTES
    This function supports ShouldProcess for safety, allowing you to confirm the action before it is performed.
    The ConfirmImpact is set to 'High' due to the potential impact of removing a page.
    
    #>
        [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'High')]
        [OutputType([notion_page])]
        param(
            [Parameter(Mandatory = $true, HelpMessage = "The ID of the page to archive")]
            [string]$PageId
        )
    
        $body = @{
            archived = $true
        }
        $body = $body | Remove-NullValuesFromObject
        if ($PSCmdlet.ShouldProcess($PageId)) {
            $response = Invoke-NotionApiCall -method PATCH -uri "/pages/$PageId" -body $body
            return [notion_page]::ConvertFromObject($response)
        } else {
            return $null
        }
    }
    