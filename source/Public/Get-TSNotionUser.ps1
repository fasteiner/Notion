function Get-TSNotionUser
{
    <#
    .SYNOPSIS
        Retrieves information about a specific Notion user.
    
    .DESCRIPTION
        The `Get-TSNotionUser` function retrieves details about a specific user from Notion by making a GET request
        to the Notion API's `/v1/users/{user_id}` endpoint, utilizing the `Invoke-TSNotionApiCall` function.
    
    .PARAMETER UserId
        The unique identifier of the Notion user. Possible values: '`$null' (list all users) or 'me' (the API User) or a user ID.
    
    .EXAMPLE
        $userId = "12345-67890-abcd-efgh"
        Get-TSNotionUser -UserId $userId
    
        This example retrieves information about the specified user from the Notion API.
    
    .NOTES
        - Ensure that the Notion API integration has the necessary permissions to access user information.
        - The API token and version are handled within the `Invoke-TSNotionApiCall` function.
    
    .LINK
        https://developers.notion.com/reference/get-user
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false, HelpMessage = "Possible values: '`$null' or 'me' or a user ID.")]
        [Alias("Id")]
        [ValidatePattern("^(me|[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12})?$")]
        [string]$UserId
    )

    # Construct the API endpoint URL
    $url = "/users/$UserId"

    try
    {
        # Make the API call using the Invoke-TSNotionApiCall function
        $response = Invoke-TSNotionApiCall -uri $url -method "GET"

        # Return the response to the caller
        return $response.foreach({[notion_user]::ConvertFromObject($_)})
    }
    catch
    {
        # Handle any errors that occur during the API call
        Write-Error "Failed to retrieve the user information: $_"
    }
}
