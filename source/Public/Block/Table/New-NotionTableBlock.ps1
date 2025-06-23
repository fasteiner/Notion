function New-NotionTableBlock
{
    <#
    .SYNOPSIS
        Creates a new Notion table.

    .DESCRIPTION
        The New-NotionTableBlock function creates a new Notion table with specified table data, column headers, and row headers.

    .PARAMETER TableData
        The data for the table. This should be a two-dimensional array of objects.

    .PARAMETER has_column_header
        Indicates whether the table has a column header. Default is $false.

    .PARAMETER has_row_header
        Indicates whether the table has a row header. Default is $false.

    .EXAMPLE
        $table = New-NotionTableBlock -TableData @( @("Cell1", "Cell2"), @("Cell3", "Cell4") ) -has_column_header $true -has_row_header $false

    .OUTPUTS
        [notion_table_block] object

    .NOTES
        This function requires the New-NotionTableBlockRow function and the [notion_table_block] class to be defined.
    #>
    [CmdletBinding()]
    [OutputType([notion_table_block])]
    param (
        [Parameter(Mandatory = $true, Position = 0, HelpMessage = "The data for the table. This should be a two-dimensional array of objects or hashtables.")]
        [Alias("data")]
        [object[]] $TableData,
        [bool] $has_column_header = $false,
        [bool] $has_row_header = $false
    )

    if($TableData -is [notion_table_block]) {
        return $TableData
    }

    if(($TableData.count -eq 0) -or (($TableData -isnot [object[]]) -and ($TableData -isnot [hashtable[]]))) {
        Write-Error "TableData must be a non-empty array of objects or hashtables." -Category InvalidArgument -RecommendedAction "Provide a valid TableData parameter." -TargetObject $TableData
        return
    }

    [notion_table_row_block[]]$rows = @()
    $Headers = @()
    if ($TableData -is [hashtable[]]) {
        if ($TableData.Count -gt 0) {
            # Extract property names from the first hashtable as the column header
            $Headers = $TableData[0].Keys
            
            if(-not $has_column_header -and -not $has_row_header) {
                $has_row_header = $true
            }
        }

        $TableData = $TableData.ForEach({
            param($item)
            $item.Values
        })
    }
    if ($has_column_header) {
        if($Headers.Count -ne 0) {
            $TableData = $Headers + $TableData
        }
        $TableData = Invoke-TransposeTable -TableData $TableData
    } 
    if($has_row_header){
        $rows += New-NotionTableRowBlock -CellData ($Headers ?? $TableData[0])
    }
    foreach($row in $TableData) {
        $TableRow = New-NotionTableRowBlock -CellData $row
        $rows += $TableRow
    }

    return [notion_table_block]::new($rows, $has_column_header, $has_row_header)
}
