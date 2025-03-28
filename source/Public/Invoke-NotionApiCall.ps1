
function Invoke-NotionApiCall
{
    <#
    .SYNOPSIS
        Invokes an API call to Notion.
    
    .DESCRIPTION
        This function is used to make API calls to Notion. It supports various HTTP methods such as GET, POST, PUT, DELETE, and PATCH. It also allows you to specify the API key, API version, and other parameters required for the API call.
    
    .PARAMETER uri
        The URI to Notion.
    
    .PARAMETER APIKey
        The API key to authenticate the API call. (Optional)
    
    .PARAMETER APIVersion
        The version of the Notion API. (Optional)
    
    .PARAMETER method
        The HTTP method to use for the API call. Valid values are "GET", "POST", "PUT", "DELETE", and "PATCH".
    
    .PARAMETER body
        The body of the API request. (Optional)
    
    .PARAMETER fileName
        The name of the log file to write the API call details. (Optional)
    
    .PARAMETER pageSize
        The number of items from the full list desired in the response. Maximum: 100. (Default: 100)
    
    .PARAMETER first
        The number of items returned from the first page in the response. Maximum: 100.
    
    .EXAMPLE
        Invoke-NotionApiCall -uri "https://api.notion.com/v1/databases" -APIKey "YOUR_API_KEY" -APIVersion "2021-05-13" -method "GET" -pageSize 50
    
        This example invokes a GET API call to the Notion API to retrieve a list of databases. It specifies the API key, API version, and page size of 50.
    
    .OUTPUTS
        The output of the API call, which can be an array of results or null if an error occurs.
    
    .NOTES
        This function requires the "Invoke-RestMethod" cmdlet to be available.
    
    .LINK
        https://www.notion.com/developers/api-reference
        Notion API Reference
    #>
    
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $false, HelpMessage = "The URI to Notion", Position = 0)]
        [string]$uri,
        [Parameter(Mandatory = $false, HelpMessage = "The API key to authenticate the API call")]
        [securestring]$APIKey,
        [Parameter(Mandatory = $false, HelpMessage = "The version of the Notion API")]
        [String]$APIVersion = $script:NotionAPIVersion,
        [Parameter(Mandatory = $false, HelpMessage = "The HTTP method to use for the API call")]
        [ValidateSet("GET", "POST", "PUT", "DELETE", "PATCH") ]
        $method = "GET",
        [Parameter(ParameterSetName = "Body")]
        [System.Object]$body,
        $fileName,
        [Parameter(HelpMessage = "The number of items from the full list desired in the response. Maximum: 100")]
        [ValidateRange(1, 100)]
        [int]$pageSize,
        [Parameter(HelpMessage = "The number of items returned from the first page in the response")]
        $first
    )


    Process
    {
        if ((-not $script:NotionAPIKey) -and (-not $APIKey))
        {
            $ErrorRecord = New-Object System.Management.Automation.ErrorRecord (
                [System.Management.Automation.RuntimeException]::new("API key is not set. Please use Connect-Notion to set the API key."),
                "APIKeyNotSet",
                [System.Management.Automation.ErrorCategory]::InvalidData,
                $PSBoundParameters
            )

            throw $ErrorRecord
        }
        $APIKey ??= $script:NotionAPIKey
        $queryParameters = @{}
        if ($PSBoundParameters.ContainsKey("pageSize") -and $pageSize -gt 0)
        {
            $queryParameters["page_size"] = $pageSize
        }
        if ($uri -notlike "$script:NotionApiUri*")
        {
            $uri = $script:NotionApiUri + $uri
        }
        $Params = @{
            "URI"     = $uri
            "Headers" = @{
                "Authorization"  = "Bearer {0}" -F ($APIKey | ConvertFrom-SecureString -AsPlainText)
                "Accept"         = "application/json"
                "Content-type"   = "application/json"
                "Notion-Version" = "{0}" -F $APIVersion
            }
            "Method"  = $method
        }
        if ($body)
        {
            $Params.Add("Body", ($body | ConvertTo-Json -EnumsAsStrings -Depth 20))
        }
        # https://developers.notion.com/reference/intro
        # Parameter location varies by endpoint
        #  GET requests accept parameters in the query string.
        #  POST requests receive parameters in the request body.

        "Request params:", $Params | Add-NotionLogToFile -filename $fileName -level DEBUG
        :loop while ($true)
        {
            Try
            {
                $output = @()
                if ($method -in @("GET", "POST"))
                {                   
                    # https://developers.notion.com/reference/intro#pagination
                    $SupportPagingPatterns = @(
                        "/v1/users", 
                        "/v1/blocks/.*/children",
                        "/v1/comments",
                        "/v1/pages/.*/properties/.*", 
                        "/v1/databases/.*/query", 
                        "/v1/search"
                    )
    
                    # Extract the endpoint part of the URL
                    $endpoint = $uri -replace '^https://[^/]+', ''
    
                    # Filter the endpoint based on the defined patterns
                    $filteredEndpoint = $SupportPagingPatterns.Where( { $endpoint -match $_ })
    
                    # Output the result if it matches any of the patterns
                    if ($filteredEndpoint )
                    {
                        Write-Debug "Paging: Endpoint: $endpoint supports paging using page_size $first"
                        if (-not $queryParameters.page_size -and $first -gt 0)
                        {
                            $queryParameters.Add("page_size", $first)
                        }
                    }
                    else
                    {
                        Write-Debug "Paging: Endpoint $endpoint doesn't support paging"
                        # remove page_size from queryParameters
                        try
                        {
                            $queryParameters.Remove("page_size")
                        }
                        catch
                        {
                            <#Do this if a terminating exception happens#>
                            $error.Clear()
                        }
                    }
                }
                else
                {
                    Write-Debug "Paging: Method $method doesn't support paging"
                    # remove page_size from queryParameters
                    try
                    {
                        $queryParameters.Remove("page_size")
                    }
                    catch
                    {
                        $error.Clear()
                    }
                }
                if ($first -and $queryParameters.page_size -and ($first -lt ($pageSize + $output.count)))
                {
                    $queryParameters.page_size = $first
                }
                # Add query parameters to the URI
                if ($method -eq "GET")
                {
                    $Params["URI"] = $uri 
                    if ($queryParameters.Count -gt 0)
                    {
                        $Params["URI"] += "?" + ($queryParameters.GetEnumerator() | ForEach-Object { "{0}={1}" -f $_.Key, $_.Value }) -join "&"
                    }
                }
                # Add parameter to the body
                elseif ($method -eq "POST")
                {
                    $Params["URI"] = $uri
                    foreach ($key in $queryParameters.Keys)
                    {
                        $value = $queryParameters[$key]
                        $body | Add-Member -MemberType NoteProperty -Name $key -Value $value -Force
                    }
                    Write-Debug "Body: $($body | ConvertTo-Json -EnumsAsStrings -Depth 20)"
                    $Params["Body"] = ($body | ConvertTo-Json -EnumsAsStrings -Depth 20)
                }
                Write-Debug "$method $($Params["URI"])"
                $content = Invoke-RestMethod @Params
                # $content.results only exists if the response is paginated, otherwise $content is the result
                if (($content.object -eq "list") -and ($content.results))
                {
                    Write-Debug "Paging: Found $($content.results.count) items"
                    $output += $content.results
                }
                else
                {
                    Write-Debug "Paging: Result is not paginated, object type: $($content.object)"
                    $output += $content
                }
                # content.has_more is only available if the endpoint supports pagination
                if (($content.has_more -eq $true) -and ($output.count -lt $first))
                {
                    $queryParameters | Add-Member -MemberType NoteProperty -Name "start_cursor" -Value $content.next_cursor -Force
                    $Params["URI"] = $uri
                    continue loop
                }
                return $output
                # Convert the output to Notion objects
                # return $output | ConvertTo-NotionObject
            }
            catch [Microsoft.PowerShell.Commands.HttpResponseException]
            {
                $message = ($_.Errordetails.message | ConvertFrom-Json)
                $e = @{
                    Status     = $message.status
                    Code       = $message.code
                    Message    = $message.message
                    Command    = $_.InvocationInfo.MyCommand
                    Method     = $_.TargetObject.Method
                    RequestUri = $_.TargetObject.RequestUri
                    Headers    = $_.TargetObject.Headers
                }
                #$e | Add-NotionLogToFile -filename $fileName -level ERROR
                $outputParams = $Params.Clone()
                $outputParams.Headers.Authorization = "Bearer *****"
                "InvokeParams", $outputParams | Add-NotionLogToFile -filename $fileName -level ERROR
                "Body", $outputParams.body | Add-NotionLogToFile -filename $fileName -level ERROR
                switch -wildcard ($e.Status)
                {
                    400
                    {
                        Write-Error "HTTP error 400: $($message.code) - $($message.message)" -TargetObject $e -Category InvalidData
                        # switch ($e.code)
                        # {
                        #     "invalid_json"
                        #     {
                        #         Write-Error "HTTP error 400: Error parsing JSON body."
                        #     }
                        #     "invalid_request_url"
                        #     {
                        #         Write-Error "HTTP error 400: Invalid request URL"
                        #     }
                        #     "invalid_request"
                        #     {
                        #         Write-Error "HTTP error 400: Unsupported request: <request name>."
                        #     }
                        #     "invalid_grant"
                        #     {
                        #         Write-Error "HTTP error 400: Invalid code: this code has been revoked."
                        #     }
                        #     "validation_error"
                        #     {
                        #         Write-Error "HTTP error 400: Body failed validation: $message"
                        #     }
                        #     "missing_version"
                        #     {
                        #         Write-Error "HTTP error 400: Notion-Version header failed validation: Notion-Version header should be defined, instead was undefined."
                        #     }
                        # }
                        break
                    }
                    401
                    {
                        Write-Error "HTTP error 401: API token is invalid."
                        break
                    }
                    403
                    {
                        Write-Error "HTTP error 403: API token does not have access to this resource."
                        break
                    }
                    404
                    {
                        Write-Error "HTTP error 404: Could not find object. Make sure the relevant pages and databases are shared with your integration."
                        break
                    }
                    409
                    {
                        Write-Error "HTTP error 409: Conflict occurred while saving. Please try again."
                        break
                    }
                    429
                    {
                        Write-Error "HTTP error 429: Rate limit exceeded. Please wait and retry."
                        if (($e.Headers.Contains("Retry-After")) -and ($e.Headers.GetValues("Retry-After")))
                        {
                            #get the first value of the array (is provided as string array)
                            Write-Warning "Sleeping for $([int]$e.headers.GetValues("Retry-After")[0]) sec as to many api calls"
                            Start-Sleep ([int]$e.Headers.GetValues("Retry-After")[0])
                        }
                        else
                        {
                            Write-Warning "Sleeping for 60 sec as to many api calls"
                            Start-Sleep 60
                        }
                        $error.Clear()
                        continue loop
                    }
                    500
                    {
                        Write-Error "HTTP error 500: Internal server error. Unexpected error occurred."
                        break
                    }
                    502
                    {
                        Write-Error "HTTP error 502: Bad gateway."
                        break
                    }
                    503
                    {
                        switch ($e.code)
                        {
                            "service_unavailable"
                            {
                                Write-Error "HTTP error 503: service_unavailable - Notion is unavailable, please try again later."
                            }
                            "database_connection_unavailable"
                            {
                                Write-Error "HTTP error 503: database_connection_unavailable - Database is unavailable, please try again later."
                            }
                            "gateway_timeout"
                            {
                                Write-Error "HTTP error 503: gateway_timeout - Gateway timeout."
                            }
                        }
                    }
                    default
                    {
                        Write-Error "Something went wrong with your request"
                    }
                }
                $error.Clear()
                return $null
            }
            catch
            {
                "Invoke-NotionApiCall - Error in Invoke-RestMethod:", $error | Add-NotionLogToFile -filename $fileName -level ERROR
                $error.clear()
                return $null
            }
        }
    }
}
