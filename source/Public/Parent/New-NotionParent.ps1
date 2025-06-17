function New-NotionParent
{
    <#
    .SYNOPSIS
        Creates a new Notion parent object.

    .DESCRIPTION
        This function creates a new instance of the notion_parent class.
        You can create an empty parent, a parent with a type, or a parent with both type and id.

    .PARAMETER Type
        The type of the parent (notion_parent_type) Values are: database_id, page_id, workspace, block_id.

    .PARAMETER Id
        The id of the parent (string).

    .EXAMPLE
        New-NotionParent

        Creates an empty Notion parent object.

    .EXAMPLE
        New-NotionParent -Type "database_id"

        Creates a Notion parent object with the type set to "database_id".

    .EXAMPLE
        New-NotionParent -Type "page_id" -Id "some-guid"

        Creates a Notion parent object with the type set to "page_id" and id set to "some-guid".

    .EXAMPLE
        New-NotionParent -Type "database_id" -Id "12345678-1234-1234-1234-123456789012"

        Creates a Notion parent object with the type set to "database_id" and id set to "12345678-1234-1234-1234-123456789012".

    .OUTPUTS
        [notion_parent]
    #>
    [CmdletBinding(DefaultParameterSetName = 'None')]
    [OutputType([notion_parent])]
    param (
        [Parameter(ParameterSetName = 'WithType', Mandatory = $true)]
        [Parameter(ParameterSetName = 'WithTypeAndId', Mandatory = $true)]
        [ValidateSet("database_id", "page_id", "workspace", "block_id")]
        [string]$Type,

        [Parameter(ParameterSetName = 'WithTypeAndId', Mandatory = $true)]
        [string]$Id
    )

    if ($PSCmdlet.ParameterSetName -eq 'WithTypeAndId')
    {
        $obj = [notion_parent]::new($Type, $Id)
    }
    elseif ($PSCmdlet.ParameterSetName -eq 'WithType')
    {
        $obj = [notion_parent]::new($Type)
    }
    else
    {
        $obj = [notion_parent]::new()
    }
    return $obj
}
