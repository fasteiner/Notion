# FILE: NumberedListItem/New-NotionNumberedListItemBlock.Tests.ps1
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

Describe "New-NotionNumberedListItemBlock" {
    InModuleScope $moduleName {
        It "Should create an empty numbered list item block" {
            $result = New-NotionNumberedListItemBlock

            $result | Should -BeOfType "notion_numbered_list_item_block"
            $result.type | Should -Be ([notion_blocktype]::numbered_list_item)
            $result.numbered_list_item.rich_text | Should -BeNullOrEmpty
        }

        It "Should create a numbered list item block with text" {
            $result = New-NotionNumberedListItemBlock -RichText "First"

            $result | Should -BeOfType "notion_numbered_list_item_block"
            $result.numbered_list_item.rich_text[0].plain_text | Should -Be "First"
        }
    }
}
