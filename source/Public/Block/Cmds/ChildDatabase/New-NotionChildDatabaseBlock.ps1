function New-NotionChildDatabaseBlock
{
    <#
    .SYNOPSIS
        Creates a new Notion child database block object.

    .DESCRIPTION
        This function creates a new instance of the notion_child_database_block class.
        You can create an empty child database block or provide a title for the database.

    .PARAMETER Title
        The title of the child database.

    .EXAMPLE
        New-NotionChildDatabaseBlock -Title "My Database"

    .EXAMPLE
        New-NotionChildDatabaseBlock

    .OUTPUTS
        notion_child_database_block
    #>
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [Parameter(ParameterSetName = 'Default', HelpMessage = 'Title of the child database.')]
        [string] $Title
    )

    if ($PSBoundParameters.ContainsKey('Title'))
    {
        $obj = [notion_child_database_block]::new($Title)
    }
    else
    {
        $obj = [notion_child_database_block]::new()
    }
    return $obj
}
