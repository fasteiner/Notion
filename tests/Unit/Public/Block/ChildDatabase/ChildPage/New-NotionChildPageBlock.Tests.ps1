# FILE: ChildDatabase/ChildPage/New-NotionChildPageBlock.Tests.ps1
Import-Module Pester

BeforeDiscovery {
    $script:projectPath = "$($PSScriptRoot)/../../../../../../" | Convert-Path

    if (-not $ProjectName) {
        $ProjectName = Get-SamplerProjectName -BuildRoot $script:projectPath
    }
    Write-Debug "ProjectName: $ProjectName"
    $global:moduleName = $ProjectName
    Set-Alias -Name gitversion -Value dotnet-gitversion
    $script:version = (gitversion /showvariable MajorMinorPatch)

    Remove-Module -Name $global:moduleName -Force -ErrorAction SilentlyContinue

    $mut = Import-Module -Name "$script:projectPath/output/module/$ProjectName/$script:version/$ProjectName.psd1" -Force -ErrorAction Stop -PassThru
}

Describe "New-NotionChildPageBlock" {
    InModuleScope $moduleName {
        It "Should create an empty child page block" {
            $result = New-NotionChildPageBlock

            $result | Should -BeOfType "notion_child_page_block"
            $result.type | Should -Be ([notion_blocktype]::child_page)
            $result.child_page.title | Should -BeNullOrEmpty
        }

        It "Should create a child page block with a title" {
            $result = New-NotionChildPageBlock -Title "Documentation"

            $result | Should -BeOfType "notion_child_page_block"
            $result.child_page.title | Should -Be "Documentation"
        }
    }
}
