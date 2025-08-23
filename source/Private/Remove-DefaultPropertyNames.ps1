function Remove-DefaultPropertyNames
{
    <#
    .SYNOPSIS
    Removes default property names from a given list of properties.
    
    .DESCRIPTION
    The Remove-DefaultPropertyNames function filters out default properties that are commonly present in .NET objects.
    This is useful for cleaning up property lists to focus on custom or relevant properties.
    
    .PARAMETER propertiesList
    A mandatory array of property names to be filtered. Accepts input from the pipeline.
    
    .OUTPUTS
    PSCustomObject
    Returns a filtered list of property names excluding the default ones.
    
    .EXAMPLE
    # Example usage:
    $properties = @('Name', 'Count', 'Keys')
    $filteredProperties = $properties | Remove-DefaultPropertyNames
    Write-Output $filteredProperties
    
    This will output: Name
    
    .NOTES
    #>
    [CmdletBinding()]
    [OutputType([PSCustomObject])]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, Position = 0)]
        [String[]]$propertiesList
    )

    process
    {        
        # Define default properties to exclude
        $defaultProperties = @(
            'Keys',
            # 'Values',
            'Count',
            'IsReadOnly',
            'IsFixedSize',
            'IsSynchronized',
            'SyncRoot',
            'Comparer',
            'EqualityComparer'
        )

        return $propertiesList.Where({ $_ -notin $defaultProperties })
    }
}
