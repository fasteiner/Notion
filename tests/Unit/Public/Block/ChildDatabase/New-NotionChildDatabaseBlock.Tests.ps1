# FILE: ChildDatabase/New-NotionChildDatabaseBlock.Tests.ps1
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

Describe "New-NotionChildDatabaseBlock" {
    InModuleScope $moduleName {
        It "Should create an empty child database block" {
            $result = New-NotionChildDatabaseBlock

            $result | Should -BeOfType "notion_child_database_block"
            $result.type | Should -Be ([notion_blocktype]::child_database)
            $result.child_database.title | Should -BeNullOrEmpty
        }

        It "Should create a child database block with title" {
            $result = New-NotionChildDatabaseBlock -Title "Tasks"

            $result | Should -BeOfType "notion_child_database_block"
            $result.child_database.title | Should -Be "Tasks"
        }
    }
}
