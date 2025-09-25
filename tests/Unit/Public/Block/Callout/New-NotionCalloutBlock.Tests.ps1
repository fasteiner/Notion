# FILE: New-NotionCalloutBlock.Tests.ps1
Import-Module Pester -DisableNameChecking 

BeforeDiscovery {
    $script:projectPath = "$($PSScriptRoot)/../../../../.." | Convert-Path

    if (-not $ProjectName)
    {
        $ProjectName = Get-SamplerProjectName -BuildRoot $projectPath
    }
    Write-Debug "ProjectName: $ProjectName"
    $global:moduleName = $ProjectName

    Remove-Module -Name $global:moduleName -Force -ErrorAction SilentlyContinue
    $mut = Import-Module -Name "$projectPath/output/module/$ProjectName" -Force -ErrorAction Stop -PassThru
}

Describe "New-NotionCalloutBlock" {
    Context "When called with no parameters" {
        It "Returns an empty notion_callout_block object" {
            $result = New-NotionCalloutBlock
            $result | Should -BeOfType "notion_callout_block"
            $result.callout.rich_text | Should -BeNullOrEmpty
            $result.callout.Icon | Should -BeNullOrEmpty
            $result.callout.Color | Should -Be "default"
        }
    }

    Context "When called with RichText, Icon, and Color" {
        It "Returns a notion_callout_block object with the specified properties" {
            $text = "Hallo"
            $richText = [rich_text]::new("text", [notion_annotation]::new(), $text)
            $icon = "💡"
            $color = [notion_color]::Default

            $result = New-NotionCalloutBlock -RichText @($richText) -Icon $icon -Color $color

            $result | Should -BeOfType "notion_callout_block"
            $result.callout.rich_text.gettype().Name | Should -Be "rich_text[]"
            $result.callout.rich_text.plain_text | Should -Be $text
            $result.callout.Icon | Should -BeOfType "notion_emoji"
            $result.callout.Icon.emoji | Should -Be $icon
            $result.callout.Color | Should -Be $color
        }
    }

    Context "When called with only some parameters" {
        It "Returns an empty notion_callout_block object" {
            $result1 = New-NotionCalloutBlock
            
            $result1 | Should -BeOfType "notion_callout_block"
            $result1.callout.rich_text | Should -BeNullOrEmpty
            $result1.callout.Icon | Should -BeNullOrEmpty
            $result1.callout.Color | Should -Be "default"
        }

        It "Returns an empty notion_callout_block object with text, icon and color" {
            $result2 = New-NotionCalloutBlock -RichText @("Test") -Icon "🌟" -Color ([notion_color]::green)

            $result2.callout.rich_text.gettype().Name | Should -Be "rich_text[]"
            $result2.callout.rich_text.plain_text | Should -Be @("Test")

            $result2.callout.Icon | Should -BeOfType "notion_emoji"
            $result2.callout.icon.emoji | Should -Be "🌟"

            $result2.callout.Color | Should -BeOfType "notion_color"
            $result2.callout.Color | Should -Be "green"
        }
    }
}
