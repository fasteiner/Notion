# FILE: Toggle/New-NotionToggleBlock.Tests.ps1
Import-Module Pester -DisableNameChecking

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

Describe "New-NotionToggleBlock" {
    InModuleScope $moduleName {
        It "Should create an empty toggle block" {
            $result = New-NotionToggleBlock

            $result | Should -BeOfType "notion_toggle_block"
            $result.type | Should -Be ([notion_blocktype]::toggle)
            $result.toggle.rich_text | Should -BeNullOrEmpty
        }

        It "Should create a toggle block with text and color" {
            $result = New-NotionToggleBlock -RichText "Details" -Color "gray"

            $result.toggle.rich_text[0].plain_text | Should -Be "Details"
            $result.toggle.color | Should -Be ([notion_color]::gray)
        }
    }
}
