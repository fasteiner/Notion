<#
.SYNOPSIS
Adds a Notion header block to a specified parent block.

.DESCRIPTION
The Add-NotionHeaderToBlock function creates a header block in Notion with specified properties such as text, color, level, and toggleability, and adds it to a given parent block. It can also accept an existing header object.

.PARAMETER Text
The text content of the header.

.PARAMETER Color
The color of the header.

.PARAMETER Level
The level of the header (1-3).

.PARAMETER is_toggleable
Indicates if the header is toggleable.

.PARAMETER Parent
The parent block to which the header will be added.

.PARAMETER InputObject
An existing header object to be added to the parent block.

.EXAMPLE
Add-NotionHeaderToBlock -Text "My Header" -Color "blue" -Level 1 -is_toggleable $true -Parent $parentBlock

This example creates a new header with the text "My Header", color "blue", level 1, and toggleable, and adds it to the specified parent block.

.EXAMPLE
$header = New-NotionHeader -Text "My Header" -Color "blue" -Level 1 -is_toggleable $true
Add-NotionHeaderToBlock -InputObject $header -Parent $parentBlock

This example creates a new header object and then adds it to the specified parent block using the InputObject parameter.
#>
function Add-NotionHeaderToBlock

{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = "Params", HelpMessage = "Text of the Header")]
        [TypeName] $Text,
        [Parameter(Mandatory = $true, ParameterSetName = "Params", HelpMessage = "Color of the Header")]
        [notion_color] $Color,
        [Parameter(Mandatory = $true, ParameterSetName = "Params", HelpMessage = "Level of the Header (1-3)")]
        [int] $Level,
        [Parameter(Mandatory = $true, ParameterSetName = "Params", HelpMessage = "Is the Header toggleable")]
        [boolean]  $is_toggleable,
        [Parameter(Mandatory = $true, HelpMessage = "The parent block to add the header to")]
        [notion_block] $Parent,
        [Parameter(Mandatory = $true, ParameterSetName = "Object")]
        [Alias("Object")]
        [Heading] $InputObject
    )
    
    process
    {
        
        if ($PSCmdlet.ParameterSetName -eq "Object")
        {
            $heading = $InputObject
        }
        else
        {
            $PSBoundParameters.Remove("Parent") | Out-Null
            $heading = New-NotionHeader @PSBoundParameters
        }
        $Parent.addChild($heading)
        #also accepts a page ID
        return Invoke-NotionApiCall -Uri "/blocks/$($Parent.id)/children" -Method PATCH -body $Parent
    }
}
