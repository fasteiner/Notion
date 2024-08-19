# #############################################################################################################
# Title: Copy-TSVariable
# Description:
# 07/2024 Hello
# # Minimum Powershell Version: 7
# #Requires -Version "7"
# #############################################################################################################
function Copy-TSNotionVariable
{
    <#
    .SYNOPSIS
    Copy the content of a variable to a new variable

    .DESCRIPTION
    Copy the content of a variable to a new variable, this is useful when you want to create a new variable with the same content as the source variable, without having a reference to the source variable.

    .PARAMETER Variable
    The Source variable

    .PARAMETER asHashtable
    If set, the variable will be converted to a hashtable

    .EXAMPLE
    Copy-TSNotionVariable -Variable $Variable
    #>
    param (
        [Parameter(Mandatory = $true)]
        [Alias("Object")]
        $Variable,
        [switch]$asHashtable
    )
    return (ConvertTo-Json -InputObject $Variable | ConvertFrom-Json -AsHashtable:$asHashtable)
}
