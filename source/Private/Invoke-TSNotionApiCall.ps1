
function Invoke-TSNotionApiCall
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
    Invoke-TSNotionApiCall -uri "https://api.notion.com/v1/databases" -APIKey "YOUR_API_KEY" -APIVersion "2021-05-13" -method "GET" -pageSize 50

    This example invokes a GET API call to the Notion API to retrieve a list of databases. It specifies the API key, API version, and page size of 50.

.OUTPUTS
    The output of the API call, which can be an array of results or null if an error occurs.

.NOTES
    This function requires the "Invoke-RestMethod" cmdlet to be available.

.LINK
    https://www.notion.com/developers/api-reference
    Notion API Reference
#>
{
    
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $false, HelpMessage = "The URI to Notion", Position = 0)]
        [string]$uri,
        [Parameter(Mandatory = $false, HelpMessage = "The API key to authenticate the API call")]
        [String]$APIKey = ($global:TSNotionAPIKey | ConvertFrom-SecureString -AsPlainText),
        [Parameter(Mandatory = $false, HelpMessage = "The version of the Notion API")]
        [String]$APIVersion = $global:TSNotionAPIVersion,
        [Parameter(Mandatory = $false, HelpMessage = "The HTTP method to use for the API call")]
        [ValidateSet("GET", "POST", "PUT", "DELETE", "PATCH") ]
        $method = "GET",
        [Parameter(ValueFromPipeline, ParameterSetName = "Body")]
        [System.Object]$body,
        $fileName,
        [Parameter(HelpMessage = "The number of items from the full list desired in the response. Maximum: 100")]
        [ValidateRange(1, 100)]
        [int]$pageSize = 100,
        [Parameter(HelpMessage = "The number of items returned from the first page in the response")]
        $first
    )

    Begin
    {
        $queryParameters = @{
            "page_size" = $pageSize
        }
        if ($uri -notlike "$global:TSNotionApiUri*")
        {
            $uri = $global:TSNotionApiUri + $uri
        }
        $Params = @{
            "URI"     = $uri
            "Headers" = @{
                "Authorization"  = "Bearer {0}" -F $APIKey
                "Accept"         = "application/json"
                "Content-type"   = "application/json"
                "Notion-Version" = "{0}" -F $APIVersion
            }
            "Method"  = $method
        }
        if ($body)
        {
            $Params.Add("Body", ($body | ConvertTo-Json))
        }
    }

    Process
    {
        # https://developers.notion.com/reference/intro
        # Parameter location varies by endpoint
        #  GET requests accept parameters in the query string.
        #  POST requests receive parameters in the request body.

        "Request params:", $Params | Add-TSNotionLogToFile -filename $fileName -level DEBUG
        :loop while ($true)
        {
            Try
            {
                $output = @()
                if ($first -and ($first -lt ($pageSize + $output.count)))
                {
                    #https://developers.notion.com/reference/intro#pagination
                    # Usage of page_size only allowed for the following requests
                    # GET  https://api.notion.com/v1/users
                    # GET  https://api.notion.com/v1/comments
                    # GET  https://api.notion.com/v1/pages/ { page_id }/properties/ { property_id}
                    # POST https://api.notion.com/v1/databases/ { database_id }/query
                    # POST https://api.notion.com/v1/search
                    
                    # https://developers.notion.com/reference/retrieve-a-page-property#paginated-properties
                    # * title
                    # * rich_text
                    # * relation
                    # * people

                    $queryParameters.page_size = $first
                }
                # Add query parameters to the URI
                if ($method -eq "GET")
                {
                    $Params["URI"] = $uri + "?" + ($queryParameters.GetEnumerator() | ForEach-Object { "{0}={1}" -f $_.Key, $_.Value }) -join "&"
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
                    $Params["Body"] = ($body | ConvertTo-Json)
                }
                else
                {
                    Write-Error "Method $method does not support pagination" -Category NotImplemented -RecommendedAction "Use GET or POST method"
                }
                Write-Debug "$method $($Params["URI"])"
                $content = Invoke-RestMethod @Params
                # $content.results only exists if the response is paginated, otherwise $content is the result
                # TODO: ist aber nicht ideal, denn man sollte nur die $content.results beim pagen aufsummieren, aber das ganze Objekt zurückgeben
                if ($content.results)
                {
                    $output += $content.results
                }
                else
                {
                    $output += $content
                }
                
                if (($content.has_more -eq $true) -and ($output.count -lt $first))
                {
                    $queryParameters | Add-Member -MemberType NoteProperty -Name "start_cursor" -Value $content.next_cursor -Force
                    $Params["URI"] = $uri
                    continue loop
                }
                return $output
                # Convert the output to Notion objects
                # return $output | ConvertTo-TSNotionObject
            }
            catch [Microsoft.PowerShell.Commands.HttpResponseException]
            {
                $message = ($error.Errordetails.message | ConvertFrom-Json)
                $e = @{
                    Status     = $message.status
                    Code       = $message.code
                    Message    = $message.message
                    Command    = $error.InvocationInfo.MyCommand
                    Method     = $error.TargetObject.Method
                    RequestUri = $error.TargetObject.RequestUri
                    Headers    = $error.TargetObject.Headers
                }
                #$e | Add-TSNotionLogToFile -filename $fileName -level ERROR
                "InvokeParams", $params | Add-TSNotionLogToFile -filename $fileName -level ERROR
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
                "Invoke-NotionApiCall - Error in Invoke-RestMethod:", $error | Add-TSNotionLogToFile -filename $fileName -level ERROR
                $error.clear()
                return $null
            }
        }
    }
}
