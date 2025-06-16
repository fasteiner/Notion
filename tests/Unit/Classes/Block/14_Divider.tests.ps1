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

Describe "notion_divider_block Tests" {
    Context "Constructor Tests" {
        It "Should create an empty notion_divider_block" {
            $block = [notion_divider_block]::new()
            $block | Should -BeOfType "notion_divider_block"
            $block.type | Should -Be "divider"
            $block.divider | Should -BeOfType "hashtable"
        }
    }

    Context "ConvertFromObject Tests" {
        It "Should convert from object correctly" {
            $mock = [PSCustomObject]@{
                type    = "divider"
                divider = @{}
            }
            $block = [notion_divider_block]::ConvertFromObject($mock)
            $block | Should -BeOfType "notion_divider_block"
            $block.type | Should -Be "divider"
            $block.divider | Should -BeOfType "hashtable"
        }
    }
}
