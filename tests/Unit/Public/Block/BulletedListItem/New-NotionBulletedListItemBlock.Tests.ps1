# FILE: BulletedListItem/New-NotionBulletedListItemBlock.Tests.ps1
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

Describe "New-NotionBulletedListItemBlock" {
    InModuleScope $moduleName {
        It "Should create an empty bulleted list item block" {
            $result = New-NotionBulletedListItemBlock

            $result | Should -BeOfType "notion_bulleted_list_item_block"
            $result.type | Should -Be ([notion_blocktype]::bulleted_list_item)
            $result.bulleted_list_item.rich_text | Should -BeNullOrEmpty
        }

        It "Should create a bulleted list item block with text and color" {
            $result = New-NotionBulletedListItemBlock -RichText "Item 1" -Color "yellow"

            $result | Should -BeOfType "notion_bulleted_list_item_block"
            $result.type | Should -Be ([notion_blocktype]::bulleted_list_item)
            $result.bulleted_list_item.rich_text[0].plain_text | Should -Be "Item 1"
            $result.bulleted_list_item.color | Should -Be ([notion_color]::yellow)
        }
    }
}
