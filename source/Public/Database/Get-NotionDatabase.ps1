function Get-NotionDatabase
{
    <#
    .SYNOPSIS
    Retrieves a Notion database structure (not the data) by its ID.
    
    .DESCRIPTION
    The Get-NotionDatabase function calls the Notion API to retrieve a database using the provided DatabaseId. 
    It sends a GET request to the Notion API and converts the response to a notion_database object.
    
    .PARAMETER DatabaseId
    The unique identifier of the Notion database to retrieve.
    
    .OUTPUTS
    notion_database
    
    .EXAMPLE
    PS C:\> Get-NotionDatabase -DatabaseId "your-database-id"
    PS C:\> Get-NotionDatabase -id "your-database-id"
    PS C:\> Get-NotionDatabase "your-database-id"
    
    This command retrieves the Notion database structure with the specified ID.

    #>
    [CmdletBinding()]
    [OutputType([notion_database])]
    param (
        [Alias("Id")]
        [Parameter(Mandatory = $true, Position = 0)]
        [string]$DatabaseId
    )
    
    $response = Invoke-NotionAPICall -Method GET -uri "/databases/$DatabaseId"
    return [notion_database]::ConvertFromObject($response)
}
