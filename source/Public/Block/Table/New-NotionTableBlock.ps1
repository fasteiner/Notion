function New-NotionTableBlock
{
    <#
    .SYNOPSIS
        Creates a new Notion table.

    .DESCRIPTION
        The New-NotionTableBlock function creates a new Notion table with specified table data, column headers, and row headers. By default, the function may automatically pivot (transpose) the data for row headers. Use the -NoPivot switch to prevent this automatic pivoting.

    .PARAMETER TableData
        The data for the table. This should be a two-dimensional array of objects, OrderedDictionaries or hashtables.

    .PARAMETER has_column_header
        Indicates whether the table has a column header.

    .PARAMETER has_row_header
        Indicates whether the table has a row header.

    .PARAMETER NoPivot
        Prevents automatic pivoting (transposing) of the table data when row headers are used.

    .EXAMPLE
        $table = New-NotionTableBlock -TableData @( @("Cell1", "Cell2"), @("Cell3", "Cell4") ) -has_column_header

    .EXAMPLE
        $table = New-NotionTableBlock -TableData @( @("Header1", "Cell1"), @("Header2", "Cell2") ) -has_row_header -NoPivot

    .OUTPUTS
        [notion_table_block] object

    .NOTES
        This function requires the New-NotionTableBlockRow function and the [notion_table_block] class to be defined.
    #>
    [CmdletBinding(DefaultParameterSetName = "ParamSetTableData")]
    [OutputType([notion_table_block])]
    param (
        [Parameter(Mandatory = $true, Position = 0, HelpMessage = "The data for the table. This should be a two-dimensional array of objects or hashtables.", ParameterSetName = "ParamSetTableData")]
        [Alias("data")]
        $TableData,
        [Parameter(Mandatory = $false,HelpMessage = "Indicates whether the table has a column header.", ParameterSetName = "ParamSetTableData")]
        [switch] $has_column_header,
        [Parameter(Mandatory = $false, HelpMessage = "Indicates whether the table has a row header.", ParameterSetName = "ParamSetTableData")]
        [switch] $has_row_header,
        [Parameter(Mandatory = $false, HelpMessage = "Prevents automatic pivoting (transposing) of the table data when row headers are used.", ParameterSetName = "ParamSetTableData")]
        [switch] $NoPivot,
        [Parameter(Mandatory = $false, Position = 1, HelpMessage = "Can be specified to create an empty table with no data.", ParameterSetName = "ParamSetEmptyTable")]
        [Alias("empty")]
        [switch] $empty_table
    )
    if ($empty_table) {
        return [notion_table_block]::new()
    }

    if($TableData -is [notion_table_block]) {
        return $TableData
    }

    if(($TableData.count -eq 0) -or ($TableData -isnot [object[]])) {
        Write-Error "TableData must be a non-empty array of objects or hashtables." -Category InvalidArgument -RecommendedAction "Provide a valid TableData parameter." -TargetObject $TableData
        return
    }

    if((($TableData[0] -is [hashtable]) -or ($TableData[0] -is [ordered])) -and ($has_column_header -and $has_row_header)) {
        Write-Error "Cannot have both column and row headers when TableData is an array of hashtables." -Category InvalidArgument -RecommendedAction "Set either has_column_header or has_row_header to false, or use a 2D array instead." -TargetObject $TableData
        return
    }

    [notion_table_row_block[]]$rows = @()
    if (($TableData[0] -is [hashtable]) -or ($TableData[0] -is [ordered])) {
        $Headers = @()
        if ($TableData.Count -gt 0) {
            # Extract property names from the first hashtable as the column header
            $Headers = $TableData[0].Keys
            if((-not $has_column_header) -and (-not $has_row_header)) {
                $has_column_header = $true
            }
        }

        $array = $TableData.ForEach({
            $row = $_
            if($row -is [hashtable]){
                # Sort the hashtable keys to ensure consistent order
                $Headers = @($Headers) | Sort-Object
                #ensure that all hastables keys are in the same order
                $values = @()
                foreach ($header in $Headers) {
                    if ($row.ContainsKey($header)) {
                        $values += $row["$header"]
                    }
                }
                return ,$values
            }
            else{
                return ,$row.Values
            }
        })
        $TableData = @()
        $TableData += ,$Headers
        $TableData += $array
    }
    if ($has_row_header -and (-not $has_column_header) -and (-not $NoPivot)) {
        $TableData = Invoke-TransposeTable -InputObject $TableData
    } 
    foreach($row in $TableData) {
        $TableRow = New-NotionTableRowBlock -CellData $row
        $rows += $TableRow
    }

    return [notion_table_block]::new($rows, $has_column_header, $has_row_header)
}
