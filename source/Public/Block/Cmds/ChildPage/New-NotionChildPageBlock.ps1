function New-NotionChildPageBlock
{
    <#
    .SYNOPSIS
        Creates a new Notion child page block object.

    .DESCRIPTION
        This function creates a new instance of the notion_child_page_block class.
        You can create an empty child page block or provide a title for the page.

    .PARAMETER Title
        The title of the child page.

    .EXAMPLE
        New-NotionChildPageBlock -Title "My Page"

    .EXAMPLE
        New-NotionChildPageBlock

    .OUTPUTS
        notion_child_page_block
    #>
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    [OutputType([notion_child_page_block])]
    param (
        [Parameter(ParameterSetName = 'Default')]
        [string]$Title
    )
    $obj = $null
    if ($PSBoundParameters.ContainsKey('Title'))
    {
        $obj = [notion_child_page_block]::new($Title)
    }
    else
    {
        $obj = [notion_child_page_block]::new()
    }
    return $obj
}
