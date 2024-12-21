function Disconnect-Notion
{
    <#
    .SYNOPSIS
    Disconnects from the Notion API by clearing the global variables.
    
    .DESCRIPTION
    The Disconnect-Notion function is used to disconnect from the Notion API. It clears the global variables used to store the connection information. The function uses ShouldProcess to confirm the action with the user.
  
    .PARAMETER Confirm
    Prompts the user to confirm the disconnection from the Notion API.
    
    .EXAMPLE
    Disconnect-Notion
    
    Prompts the user to confirm the disconnection from the Notion API and clears the connection information if confirmed.
    
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'High')]
    param ()
    
    if ($PSCmdlet.ShouldProcess("Notion API connection", "Disconnect"))
    {
        Remove-Variable -Name NotionAPIKey -Scope Global -ErrorAction SilentlyContinue
        Remove-Variable -Name NotionApiUri -Scope Global -ErrorAction SilentlyContinue
        Remove-Variable -Name NotionAPIVersion -Scope Global -ErrorAction SilentlyContinue
        Write-Host "Disconnected from the Notion API." -ForegroundColor Green
    }
    else
    {
        Write-Host "Disconnection from the Notion API was cancelled." -ForegroundColor Yellow
    }
}
