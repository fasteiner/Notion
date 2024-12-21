function Get-NotionPageProperties {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$PageId
    )

    $PropertiesRaw = Invoke-NotionApiCall -Uri "/pages/$PageId/properties/" -Method GET
    $Properties = $PropertiesRaw | ConvertTo-NotionObject
    return $Properties
}
