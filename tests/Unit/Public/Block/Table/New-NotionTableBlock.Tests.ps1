# FILE: Table/New-NotionTableBlock.Tests.ps1
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

Describe "New-NotionTableBlock" {
    InModuleScope $moduleName {
        It "Should create a table block with column headers" {
            $tableData = @(
                @("Header1", "Header2"),
                @("Value1", "Value2")
            )
            $result = New-NotionTableBlock -TableData $tableData -has_column_header

            $result | Should -BeOfType "notion_table_block"
            $result.table.has_column_header | Should -BeTrue
            $result.table.children.Count | Should -Be 2
            $result.table.children[0].table_row.cells[0][0].plain_text | Should -Be "Header1"
            $result.table.children[1].table_row.cells[1][0].plain_text | Should -Be "Value2"
        }

        It "Should create an empty table block" {
            $result = New-NotionTableBlock -empty_table

            $result | Should -BeOfType "notion_table_block"
            $result.table.children | Should -BeNullOrEmpty
        }
    }
}
