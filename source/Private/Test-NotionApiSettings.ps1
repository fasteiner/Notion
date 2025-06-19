function Test-NotionApiSettings
{
    <#
    .SYNOPSIS
        Validates that the required Notion API connection parameters are set.

    .DESCRIPTION
        Checks if the script-scoped variables $script:NotionAPIKey, $script:NotionApiUri, and $script:NotionAPIVersion are defined.
        If any of these are missing, writes an error message and returns $false. Otherwise, returns $true.

    .PARAMETER calledFrom
        The name of the calling command or function. Defaults to the current function name.

    .OUTPUTS
        [Boolean] Returns $true if all required Notion API parameters are set; otherwise, $false.

    .EXAMPLE
        Test-NotionConnectParams
        # Returns $true if all Notion API credentials are set, otherwise writes an error and returns $false.

    .NOTES
        Used internally to ensure Notion API connectivity prerequisites are met.
    #>
    param (
        [Parameter(Position = 0, HelpMessage = "The name of the calling command or function.")]
        $calledFrom = $MyInvocation.MyCommand.Name
    )
    # Check if $script:NotionAPIKey,$script:NotionApiUri,$script:NotionAPIVersion is set, otherwise write error and return false
    if (-not $script:NotionAPIKey -or -not $script:NotionApiUri -or -not $script:NotionAPIVersion)
    {
        Write-Error "$($calledFrom): Notion API credentials are not set. Please connect to Notion using Connect-Notion." -Category ConnectionError -RecommendedAction "Run Connect-Notion to set the API credentials."
        return $false
    }
    else
    {
        return $true
    }
}
