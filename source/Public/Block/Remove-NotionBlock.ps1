function Remove-NotionBlock
{
    <#
    .SYNOPSIS
        Deletes a Notion block from a page.
    
    .DESCRIPTION
        This function removes a block from a Notion page by using the Notion API.
        It supports deletion via block ID or a Notion_Block object.
    
    .PARAMETER BlockId
        The ID of the Notion block to delete.
    
    .PARAMETER Block
        A Notion_Block object representing the block to delete.
    
    .PARAMETER ApiKey
        The Notion API key for authentication.
    
    .EXAMPLE
        Remove-NotionBlock -BlockId "abc123"
        Deletes the specified Notion block.
    
    .EXAMPLE
        $Block = Get-NotionBlock -BlockId "abc123"
        Remove-NotionBlock -Block $Block
        Deletes the specified Notion block using a Notion_Block object.

    .OUTPUTS
        Returns a [notion_block] object representing the deleted block.

    .LINK
        https://developers.notion.com/reference/delete-a-block
    
    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    [OutputType([notion_block])]
    param (
        [Parameter(Mandatory=$true, ParameterSetName = "ById", ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [Alias("id")]
        [string]$BlockId,

        [Parameter(Mandatory=$true, ParameterSetName = "ByObject", ValueFromPipeline)]
        [Notion_Block]$Block
    )

    process {
        if ($PSCmdlet.ParameterSetName -eq "ByObject") 
        {
            $BlockId = $Block.Id
        }
        
        $Uri = "/blocks/$BlockId"
        
        if ($PSCmdlet.ShouldProcess($BlockId, "Delete Notion block")) 
        {
            try 
            {
                $Response = Invoke-NotionApiCall -Uri $Uri -Method Delete
                return [notion_block]::ConvertFromObject($Response)
            } 
            catch 
            {
                Write-Error "Failed to delete block: $_"
            }
        }
    }
}
