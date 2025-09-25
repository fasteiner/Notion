# FILE: Callout/New-NotionCalloutBlock.Tests.ps1
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

Describe "New-NotionCalloutBlock" {
    InModuleScope $moduleName {
        It "Should create an empty callout block" {
            $result = New-NotionCalloutBlock

            $result | Should -BeOfType "notion_callout_block"
            $result.type | Should -Be ([notion_blocktype]::callout)
            $result.callout.rich_text | Should -BeEmpty
        }

        It "Should create a callout block with rich text icon and color" {
            $richText = New-NotionRichText -Text "Hello"
            $result = New-NotionCalloutBlock -RichText $richText -Icon "💡" -Color blue

            $result | Should -BeOfType "notion_callout_block"
            $result.type | Should -Be ([notion_blocktype]::callout)
            $result.callout.rich_text[0].plain_text | Should -Be "Hello"
            $result.callout.icon.emoji | Should -Be "💡"
            $result.callout.color | Should -Be ([notion_color]::blue)
        }
    }
}
