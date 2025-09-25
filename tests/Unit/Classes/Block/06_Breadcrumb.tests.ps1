# Import the module containing the notion_breadcrumb_block class
Import-Module Pester -DisableNameChecking

BeforeDiscovery {
    $projectPath = "$($PSScriptRoot)/../../../.." | Convert-Path

    if (-not $ProjectName)
    {
        $ProjectName = Get-SamplerProjectName -BuildRoot $projectPath
    }
    Write-Debug "ProjectName: $ProjectName"
    $global:moduleName = $ProjectName

    Remove-Module -Name $global:moduleName -Force -ErrorAction SilentlyContinue

    $mut = Import-Module -Name "$projectPath/output/module/$ProjectName" -Force -ErrorAction Stop -PassThru
}

Describe "notion_breadcrumb_block Tests" {
    Context "Constructor Tests" {
        It "Should create a notion_breadcrumb_block" {
            $block = [notion_breadcrumb_block]::new()
            $block | Should -BeOfType "notion_breadcrumb_block"
            $block.type | Should -Be "breadcrumb"
            $block.breadcrumb | Should -BeOfType "System.Collections.Hashtable"
        }
    }

    Context "ConvertFromObject Tests" {
        It "Should convert from object correctly" {
            $mockObject = [PSCustomObject]@{
                breadcrumb = [PSCustomObject]@{}
            }
            $block = [notion_breadcrumb_block]::ConvertFromObject($mockObject)
            $block | Should -BeOfType "notion_breadcrumb_block"
            $block.type | Should -Be "breadcrumb"
            $block.breadcrumb | Should -BeOfType "System.Collections.Hashtable"
        }
    }
}
