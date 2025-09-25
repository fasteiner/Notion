# FILE: TableRow/New-NotionTableRowBlock.Tests.ps1
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

Describe "New-NotionTableRowBlock" {
    InModuleScope $moduleName {
        It "Should create a table row from cell data" {
            $result = New-NotionTableRowBlock -CellData @("Cell1", "Cell2")

            $result | Should -BeOfType "notion_table_row_block"
            $result.type | Should -Be ([notion_blocktype]::table_row)
            $result.table_row.cells[0][0].plain_text | Should -Be "Cell1"
            $result.table_row.cells[1][0].plain_text | Should -Be "Cell2"
        }
    }
}
