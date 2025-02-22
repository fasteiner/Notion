function Get-NotionPageProperty
{
    <#
    .SYNOPSIS
    Retrieves the properties of a specified Notion page.

    .DESCRIPTION
    The `Get-NotionPageProperty` function fetches the properties of a Notion page
    by making a GET request to the Notion API. The properties are returned as a 
    `notion_pageproperties` object for further use.

    .PARAMETER PageId
    The unique identifier of the Notion page whose properties are to be retrieved. This parameter is mandatory.

    .PARAMETER PropertyID

    The unique identifier of the Notion page property to retrieve.

    .OUTPUTS
    [notion_pageproperties]
    Returns a `notion_pageproperties` object containing the properties of the specified Notion page.

    .EXAMPLE
    Get-NotionPageProperty -PageId "12345678-abcd-1234-efgh-56789ijklmn0"

    This example retrieves the properties of the Notion page with the specified ID.

    .EXAMPLE
    Get-NotionPageProperty -PageId "12345678-abcd-1234-efgh-56789ijklmn0" -PropertyID "6757567-98568907657-4435235"

    This example retrieves the specified property of the Notion page with the specified ID.

    .NOTES
    Requires the `Invoke-NotionApiCall` function and appropriate API authentication to be configured.
    Ensure you have access permissions for the specified page in Notion.

    .LINK
    https://developers.notion.com/reference/retrieve-a-page-property#rollup-properties
    #>

    [CmdletBinding()]
    [OutputType([PagePropertiesBase])]
    param (
        [Parameter(Mandatory = $true, Position = 0, HelpMessage = "The ID of the Notion page to retrieve properties for.")]
        [Alias("Id")]
        [string]$PageId,
        [Parameter(Mandatory = $true, Position = 1, HelpMessage = "The ID of the Notion page property to retrieve.")]
        [string]$PropertyID
    )

    $PropertiesRaw = Invoke-NotionApiCall -Uri "/pages/$PageId/properties/$PropertyID" -Method GET
    if($PropertiesRaw.object -eq "property_item")
    {
        $converted = [PagePropertiesBase]::ConvertFromObject($PropertiesRaw)
        return $converted
    }
    elseif($PropertiesRaw.object -eq "lists")
    {
        $converted = $PropertiesRaw.results.foreach({[PagePropertiesBase]::ConvertFromObject($_)})
        #TODO: implement pagination
        return $converted
    }
    else{
        Write-Error "Unknown object type: $($PropertiesRaw.object)" -Category InvalidData -RecommendedAction "Check the object type"
    }
    return $null
}
