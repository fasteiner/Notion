#############################################################################################################
# Title: ConvertTo-NotionObject.Tests
# Description: 
# 08/2024 Thomas.Subotitsch@base-IT.at
# Minimum Powershell Version: 7
#Requires -Version "7"
#############################################################################################################

BeforeDiscovery {
    $script:projectPath = "$($PSScriptRoot)/../../../.." | Convert-Path

    <#
        If the QA tests are run outside of the build script (e.g with Invoke-Pester)
        the parent scope has not set the variable $ProjectName.
    #>
    if (-not $ProjectName)
    {
        # Assuming project folder name is project name.
        $ProjectName = Get-SamplerProjectName -BuildRoot $script:projectPath
    }
    Write-Debug "ProjectName: $ProjectName"
    $global:moduleName = $ProjectName
    Set-Alias -Name gitversion -Value dotnet-gitversion
    $script:version = (gitversion /showvariable MajorMinorPatch)

    Remove-Module -Name $global:moduleName -Force -ErrorAction SilentlyContinue

    $mut = Import-Module -Name "$script:projectPath/output/module/$ProjectName/$script:version/$ProjectName.psd1" -Force -ErrorAction Stop -PassThru

}

Describe "ConvertTo-NotionObject" {
    It "should convert a list object correctly" {
        $input = @{
            object  = "list"
            results = @(
                @{ object = "block"; type = "paragraph" },
                @{ object = "block"; type = "heading_1" }
            )
        }
        $result = $input | ConvertTo-NotionObject
        $result | Should -Not -BeNullOrEmpty
    }

    # It "should convert a block object with paragraph type correctly" {
    #     $input = @{
    #         object = "block"
    #         type   = "paragraph"
    #     }
    #     $result = $input | ConvertTo-NotionObject
    #     $result | Should -Not -BeNullOrEmpty
    # }

    # It "should convert a block object with heading_1 type correctly" {
    #     $input = @{
    #         object = "block"
    #         type   = "heading_1"
    #     }
    #     $result = $input | ConvertTo-NotionObject
    #     $result | Should -Not -BeNullOrEmpty
    # }

    It "should convert a page object correctly" {
        $input = @{
            object = "page"
        }
        $result = $input | ConvertTo-NotionObject
        $result | Should -Not -BeNullOrEmpty
    }

    # It "should log an error for unsupported object types" {
    #     $input = @{
    #         object = "unsupported_object"
    #     }
    #     $result = $input | ConvertTo-NotionObject
    #     $result | Should -BeNullOrEmpty
    # }
}
