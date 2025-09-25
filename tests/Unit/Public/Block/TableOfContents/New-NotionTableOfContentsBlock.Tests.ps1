# FILE: TableOfContents/New-NotionTableOfContentsBlock.Tests.ps1
Import-Module Pester -DisableNameChecking

BeforeDiscovery {
    $script:projectPath = "$($PSScriptRoot)/../../../../.." | Convert-Path

    if (-not $ProjectName)
    {
        $ProjectName = Get-SamplerProjectName -BuildRoot $script:projectPath
    }
    Write-Debug "ProjectName: $ProjectName"
    $global:moduleName = $ProjectName
    Set-Alias -Name gitversion -Value dotnet-gitversion
    $script:version = (gitversion /showvariable MajorMinorPatch)

    Remove-Module -Name $global:moduleName -Force -ErrorAction SilentlyContinue

    $mut = Import-Module -Name "$script:projectPath/output/module/$ProjectName/$script:version/$ProjectName.psd1" -Force -ErrorAction Stop -PassThru
}

Describe "New-NotionTableOfContentsBlock" {
    InModuleScope $moduleName {
        It "Should create a default table of contents block" {
            $result = New-NotionTableOfContentsBlock

            $result | Should -BeOfType "notion_table_of_contents_block"
            $result.type | Should -Be ([notion_blocktype]::table_of_contents)
            $result.table_of_contents.color | Should -Be ([notion_color]::default)
        }

        It "Should create a table of contents block with custom color" {
            $result = New-NotionTableOfContentsBlock -Color "gray"

            $result.table_of_contents.color | Should -Be ([notion_color]::gray)
        }
    }
}
