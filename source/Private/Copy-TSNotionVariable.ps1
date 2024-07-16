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


    .PARAMETER Variable
    The Source variable

    .PARAMETER asHashtable
    If set, the variable will be converted to a hashtable

    .EXAMPLE
    Copy-TSNotionVariable -Variable $Variable
    #>
    param (
        $Variable,
        [switch]$asHashtable
    )
    return (ConvertTo-Json -InputObject $Variable | ConvertFrom-Json -AsHashtable)
}
