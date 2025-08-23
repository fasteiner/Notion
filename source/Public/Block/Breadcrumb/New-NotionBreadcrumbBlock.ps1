function New-NotionBreadcrumbBlock
{
    <#
    .SYNOPSIS
        Creates a new Notion breadcrumb block object.
    
    .DESCRIPTION
        The New-NotionBreadcrumbBlock function instantiates and returns a new notion_breadcrumb_block object.
        This is typically used to add a breadcrumb block to a Notion page via automation or scripting.
    
    .EXAMPLE
        New-NotionBreadcrumbBlock
    
        Creates a new breadcrumb block object for use with Notion integrations.
    
    .OUTPUTS
        notion_breadcrumb_block object
    #>
    [CmdletBinding()]
    [OutputType([notion_breadcrumb_block])]
    param ( )
    return [notion_breadcrumb_block]::new()
}
