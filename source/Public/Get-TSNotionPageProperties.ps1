function Get-TSNotionPageProperties {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$PageId
    )

    $PropertiesRaw = Invoke-TSNotionApiCall -Uri "/pages/$PageId/properties/" -Method GET
    $Properties = $PropertiesRaw | ConvertTo-TSNotionObject
    return $Properties
}
