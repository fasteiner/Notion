function New-NotionTableRowBlock
{
    <#
    .SYNOPSIS
        Creates a new Notion table row.

    .DESCRIPTION
        The New-NotionTableRowBlock function creates a new Notion table row with specified cell data.

    .PARAMETER CellData
        The cell data for the table row. This should be an array of objects.

    .EXAMPLE
        $row = New-NotionTableRowBlock -CellData @("Cell1", "Cell2", "Cell3")

    .OUTPUTS
        [notion_table_row_block] object

    .NOTES
        This function requires the [notion_table_row_block] class to be defined.
    #>
    [CmdletBinding()]
    [OutputType([notion_table_row_block])]
    param (
        [Alias("data")]
        [object[]] $CellData
    )
    return [notion_table_row_block]::new($CellData)
}
