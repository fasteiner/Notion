function Disconnect-TSNotion
{
    <#
    .SYNOPSIS
    Disconnects from the Notion API by clearing the global variables.
    
    .DESCRIPTION
    The Disconnect-TSNotion function is used to disconnect from the Notion API. It clears the global variables used to store the connection information. The function uses ShouldProcess to confirm the action with the user.
  
    .PARAMETER Confirm
    Prompts the user to confirm the disconnection from the Notion API.
    
    .EXAMPLE
    Disconnect-TSNotion
    
    Prompts the user to confirm the disconnection from the Notion API and clears the connection information if confirmed.
    
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'High')]
    param ()
    
    if ($PSCmdlet.ShouldProcess("Notion API connection", "Disconnect"))
    {
        Remove-Variable -Name TSNotionAPIKey -Scope Global -ErrorAction SilentlyContinue
        Remove-Variable -Name TSNotionApiUri -Scope Global -ErrorAction SilentlyContinue
        Remove-Variable -Name TSNotionAPIVersion -Scope Global -ErrorAction SilentlyContinue
        Write-Output "Disconnected from the Notion API."
    }
    else
    {
        Write-Output "Disconnection from the Notion API was cancelled."
    }
}
