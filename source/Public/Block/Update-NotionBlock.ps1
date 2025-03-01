function Update-NotionBlock 
{
    <#
    .SYNOPSIS
        Updates a Notion block with new properties.
    
    .DESCRIPTION
        This function updates a block in Notion using the Notion API. It allows modifying properties of the block via its ID or a Notion_Block object.
    
    .PARAMETER BlockId
        The ID of the Notion block to update.
    
    .PARAMETER Block
        A Notion_Block object representing the block to update.
    
    .PARAMETER Properties
        A hashtable of properties to update on the Notion block.
    
    .EXAMPLE
        Update-NotionBlock -BlockId "abc123" -Properties @{"text" = "Updated content"}
        Updates the specified Notion block's text content.
    
    .EXAMPLE
        $Block = Get-NotionBlock -BlockId "abc123"
        # Update the block's properties

        Update-NotionBlock -Block $Block
        Updates the specified Notion block using a Notion_Block object.
    
    .OUTPUTS
        Returns a [Notion_Block] object representing the updated block.
    
    .LINK
        https://developers.notion.com/reference/update-a-block
    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    [OutputType([notion_block])]
    param (
        [Parameter(Mandatory=$true, ParameterSetName = "ById")]
        [Alias("id")]
        [string]$BlockId,

        [Parameter(Mandatory=$true, ParameterSetName = "ByObject")]
        [Notion_Block]$Block,

        [Parameter(Mandatory=$true, ParameterSetName = "ById")]
        [hashtable]$Properties
    )

    process {
        $body = @{}
        if ($PSCmdlet.ParameterSetName -eq "ByObject") 
        {
            $BlockId = $Block.Id
            $body = $Block | Select-Object -ExcludeProperty created_by, created_time
        }
        else{
            $body = $Properties
        }
        
        $Uri = "/blocks/$BlockId"
        
        if ($PSCmdlet.ShouldProcess($BlockId, "Update Notion block")) 
        {
            try 
            {
                $body = $body | Remove-NullValuesFromObject
                $Response = Invoke-NotionApiCall -Uri $Uri -Method Patch -Body $body
                return [Notion_Block]::ConvertFromObject($Response)
            } catch 
            {
                Write-Error "Failed to update block: $_"
            }
        }
    }
}
