function Add-TSNotionHeaderToBlock
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
        [Block] $Parent,
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
            $heading = New-TSNotionHeader @PSBoundParameters
        }
        $Parent.addChild($heading)
        #also accepts a page ID
        return Invoke-TSNotionApiCall -Uri "/blocks/$($Parent.id)/children" -Method PATCH -body $Parent
    }
}
