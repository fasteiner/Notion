function Remove-DefaultPropertyNames
{
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
