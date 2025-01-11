
function Remove-NullValuesFromObject
{
    [CmdletBinding()]
    [outputtype([PSCustomObject])]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [object]$InputObject
    )

    process
    {
        # Ensure enums are serialized as strings
        $InputObject = $InputObject | ConvertTo-Json -Depth 20 -EnumsAsStrings | ConvertFrom-Json
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
                if (($property.value -is [int]) -or ($property.value -is [int64]) -or ($property.value -is [double]) -or ($property.value -is [float]) -or ($property.value -is [string]) -or ($property.value -is [bool]))
                {
                    $outputObject | Add-Member -MemberType NoteProperty -Name $property.Name -Value $property.Value
                }
                elseif ($property.Value -is [array])
                {
                    $cleanedArray = @()
                    foreach ($item in $property.Value)
                    {
                        if ($item -is [Object])
                        {
                            $cleanedArray += Remove-NullValuesFromObject -InputObject $item
                        }
                        else
                        {
                            $cleanedArray += $item
                        }
                    }
                    $outputObject | Add-Member -MemberType NoteProperty -Name $property.Name -Value $cleanedArray
                }
                elseif ($property.Value -is [Object] ) 
                {
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
