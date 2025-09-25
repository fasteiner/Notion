# FILE: ToDo/New-NotionToDoBlock.Tests.ps1
Import-Module Pester

BeforeDiscovery {
    $script:projectPath = "$($PSScriptRoot)/../../../../.." | Convert-Path

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

Describe "New-NotionToDoBlock" {
    InModuleScope $moduleName {
        It "Should create an empty to-do block" {
            $result = New-NotionToDoBlock

            $result | Should -BeOfType "notion_to_do_block"
            $result.type | Should -Be ([notion_blocktype]::to_do)
            $result.to_do.rich_text | Should -BeNullOrEmpty
            $result.to_do.checked | Should -BeFalse
        }

        It "Should create a to-do block with text" {
            $result = New-NotionToDoBlock -RichText "Buy milk"

            $result.to_do.rich_text[0].plain_text | Should -Be "Buy milk"
            $result.to_do.checked | Should -BeFalse
        }

        It "Should create a to-do block with checked state" {
            $result = New-NotionToDoBlock -RichText "Submit report" -Checked $true

            $result.to_do.rich_text[0].plain_text | Should -Be "Submit report"
            $result.to_do.checked | Should -BeTrue
        }
    }
}
