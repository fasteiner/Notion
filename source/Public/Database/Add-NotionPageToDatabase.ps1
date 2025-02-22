function Add-NotionPageToDatabase {
    <#
    .SYNOPSIS
    Adds a new page to a Notion database.
    
    .DESCRIPTION
    The Add-NotionPageToDatabase function creates a new page in a specified Notion database. 
    It is an alias for the New-NotionPage function and allows setting various properties, 
    including the parent database, properties of the page, children blocks, icon, cover image, and title.
    
    .PARAMETER parent_database
    The parent database object of the page.
    
    .PARAMETER properties
    A hashtable containing the properties of the page.
    
    .PARAMETER children
    An array of blocks within this page.
    
    .PARAMETER icon
    The icon object of the page.
    
    .PARAMETER cover
    The cover image object of the page (see notion_file).
    
    .PARAMETER title
    The title of the page. This will overwrite the title-property if it exists.
    
    .OUTPUTS
    [notion_page]
    Returns the created Notion page object.
    
    .EXAMPLE
    PS> Add-NotionPageToDatabase -parent_database $database -properties $props -title "New Page"
    This example creates a new page in the specified Notion database with the given properties and title.
    #>
    # Alias for New-NotionPage
    [CmdletBinding()]
    [OutputType([notion_page])]
    param(
        [Parameter(HelpMessage = "The parent object of the page, if empty it will be created at the root (workspace) level")]
        [object] $parent_database,
        [Parameter(HelpMessage = "The properties of the page")]
        [hashtable] $properties = @{},
        [Parameter(HelpMessage = "An array of blocks within this page")]
        $children = @(),
        [Parameter(HelpMessage = "The icon of the page")]
        $icon,
        [Parameter(HelpMessage = "The cover image of the page (see notion_file)")]
        $cover,
        [Parameter(HelpMessage = "The title of the page. (Will overwrite the title-property if it exists)")]
        $title
    )

    $PSBoundParameters.Remove('parent_database') | Out-Null
    return (New-NotionPage @PSBoundParameters -parent_obj $parent_database)    
}
