function New-NotionTable
{
    <#
    .SYNOPSIS
        Creates a new Notion table.

    .DESCRIPTION
        The New-NotionTable function creates a new Notion table with specified table data, column headers, and row headers.

    .PARAMETER TableData
        The data for the table. This should be a two-dimensional array of objects.

    .PARAMETER has_column_header
        Indicates whether the table has a column header. Default is $false.

    .PARAMETER has_row_header
        Indicates whether the table has a row header. Default is $false.

    .EXAMPLE
        $table = New-NotionTable -TableData @( @("Cell1", "Cell2"), @("Cell3", "Cell4") ) -has_column_header $true -has_row_header $false

    .OUTPUTS
        [notion_table_block] object

    .NOTES
        This function requires the New-NotionTableRow function and the [notion_table_block] class to be defined.
    #>
    [CmdletBinding()]
    [OutputType([notion_table_block])]
    param (
        [Alias("data")]
        [object[][]] $TableData,
        [bool] $has_column_header = $false,
        [bool] $has_row_header = $false
    )

    [notion_table_row_block[]]$rows = @()
    foreach ($row in $TableData)
    {
        $TableRow = New-NotionTableRow -CellData $row
        $rows += $TableRow
    }
    return [notion_table_block]::new($rows, $has_column_header, $has_row_header)
}
