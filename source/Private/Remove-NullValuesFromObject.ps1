
function Remove-NullValuesFromObject
{
    <#
    .SYNOPSIS
        Removes properties with null or empty values from a PowerShell object, including nested objects and arrays.

    .DESCRIPTION
        The Remove-NullValuesFromObject function recursively processes a given object and removes any properties that have null values, empty strings, or empty arrays.
        It supports nested objects and arrays, ensuring that only properties with meaningful values are retained in the output.
        The function returns a cleaned PSCustomObject with all null or empty properties removed.

    .PARAMETER InputObject
        The object to process. This can be any object, including nested objects or arrays.
        The function will recursively remove null or empty properties from the object.

    .EXAMPLE
        $obj = [PSCustomObject]@{
            Name = "John"
            Age = $null
            Address = [PSCustomObject]@{
                Street = ""
                City = "Seattle"
            }
            Tags = @("admin", $null, "user")
        }
        $cleaned = Remove-NullValuesFromObject -InputObject $obj

        # Result:
        # @{
        #     Name = "John"
        #     Address = @{
        #         City = "Seattle"
        #     }
        #     Tags = @("admin", "user")
        # }

    .NOTES
        This function is needed, as the notion API does not allow null values in properties and also no empty strings or empty arrays.

    #>
    [CmdletBinding()]
    [OutputType([PSCustomObject])]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [object]$InputObject
    )

    process
    {
        # Return an empty object if there are no properties
        if ($InputObject.Count -eq 0)
        {
            return [PSCustomObject]@{}
        }
        # Ensure enums are serialized as strings
        #$InputObject = $InputObject | ConvertTo-Json -Depth 20 -EnumsAsStrings | ConvertFrom-Json
        $InputObject = $InputObject | Select-Object *
        $outputObject = [PSCustomObject]@{}
        # Remove null properties from the input object
        :loop foreach ($property in $InputObject.PSObject.Properties)
        {
            if (-not ($property.IsSettable))
            {
                continue :loop
            }
            if ($null -ne $property.Value)
            {
                Write-Debug "Processing property: $($property.Name): $($property.Value) `<$($property.value.GetType().Name)]"

                if (($property.value -is [int]) -or ($property.value -is [int64]) -or ($property.value -is [double]) -or ($property.value -is [float]) -or ($property.value -is [string]) -or ($property.value -is [bool]) -or ($property.value -is [DateTime]) -or ($property.value -is [enum]))
                {
                    if (($property.Value -is [string]) -and ([string]::IsNullOrEmpty($property.Value)))
                    {
                        # Skip empty strings
                        continue :loop
                    }
                    $outputObject | Add-Member -MemberType NoteProperty -Name $property.Name -Value $property.Value
                }

                elseif ($property.Value -is [array])
                {
                    if ($property.Value.Count -eq 0)
                    {
                        # Skip empty arrays
                        continue :loop
                    }
                    $cleanedArray = @()
                    :cleanArrayLoop foreach ($item in $property.Value)
                    {
                        if ( $null -eq $item )
                        {
                            continue :cleanArrayLoop
                        }
                        if ($item -is [array])
                        {
                            $cleanedArray += , @($(Remove-NullValuesFromObject -InputObject $item))
                        }
                        else
                        {
                            $cleanedArray += $(Remove-NullValuesFromObject -InputObject $item)
                        }
                    }
                    if ( $cleanedArray.Count -eq 0 )
                    {
                        # Skip empty arrays
                        continue :loop
                    }
                    $outputObject | Add-Member -MemberType NoteProperty -Name $property.Name -Value $cleanedArray
                }
                elseif ($property.Value -is [Object] ) 
                {
                    $nestedObject = $null
                    try
                    {
                        $nestedObject = Remove-NullValuesFromObject -InputObject $property.Value                        
                    }
                    catch
                    {
                        Write-Host "Error in property: $($property.Name)" -ForegroundColor Red
                        Write-Host $_.Exception.Message -ForegroundColor Red                        
                    }
                    $outputObject | Add-Member -MemberType NoteProperty -Name $property.Name -Value $nestedObject
                }
                else
                {
                    $outputObject | Add-Member -MemberType NoteProperty -Name $property.Name -Value $property.Value
                }
            }
        }

        # Return cleaned object
        return $outputObject
    }
}
