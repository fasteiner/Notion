# FILE: New-NotionBlock.Tests.ps1
Import-Module Pester -DisableNameChecking

BeforeDiscovery {
    $script:projectPath = "$($PSScriptRoot)/../../../.." | Convert-Path

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

Describe "New-NotionBlock" {
    InModuleScope $moduleName {
        It "Should create a paragraph block" {
            $result = New-NotionBlock -paragraph | Select-Object -Last 1

            $result | Should -Not -BeNullOrEmpty
            $result | Should -BeOfType "notion_paragraph_block"
            $result.type | Should -Be ([notion_blocktype]::paragraph)
        }

        It "Should create a bookmark block when url is provided" {
            $outputs = New-NotionBlock -bookmark -Url "https://example.com" -Caption "Example"
            $result = $outputs | Select-Object -Last 1

            $result | Should -Not -BeNullOrEmpty
            $result | Should -BeOfType "notion_bookmark_block"
            $result.type | Should -Be ([notion_blocktype]::bookmark)
        }

        It "Should create a to-do block when requested" {
            $result = New-NotionBlock -to_do -Checked | Select-Object -Last 1

            $result | Should -Not -BeNullOrEmpty
            $result | Should -BeOfType "notion_to_do_block"
            $result.type | Should -Be ([notion_blocktype]::to_do)
        }
    }
}
