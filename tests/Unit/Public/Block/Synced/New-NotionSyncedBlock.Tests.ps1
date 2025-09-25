# FILE: Synced/New-NotionSyncedBlock.Tests.ps1
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

Describe "New-NotionSyncedBlock" {
    InModuleScope $moduleName {
        It "Should create a synced block" {
            $result = New-NotionSyncedBlock

            $result | Should -BeOfType "notion_synced_block"
            $result.type | Should -Be ([notion_blocktype]::synced_block)
        }
    }
}
