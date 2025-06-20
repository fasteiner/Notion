# FILE: New-NotionCalloutBlock.Tests.ps1
Import-Module Pester

BeforeDiscovery {
    $script:projectPath = "$($PSScriptRoot)/../../../.." | Convert-Path

    <#
        If the QA tests are run outside of the build script (e.g with Invoke-Pester)
        the parent scope has not set the variable $ProjectName.
    #>
    if (-not $ProjectName)
    {
        # Assuming project folder name is project name.
        $ProjectName = Get-SamplerProjectName -BuildRoot $script:projectPath
    }
    Write-Debug "ProjectName: $ProjectName"
    $global:moduleName = $ProjectName
    Set-Alias -Name gitversion -Value dotnet-gitversion
    $script:version = (gitversion /showvariable MajorMinorPatch)

    Remove-Module -Name $global:moduleName -Force -ErrorAction SilentlyContinue

    $mut = Import-Module -Name "$script:projectPath/output/module/$ProjectName/$script:version/$ProjectName.psd1" -Force -ErrorAction Stop -PassThru
}

Describe "New-NotionEmoji" {

    BeforeAll {
        # Mock notion_emoji class for testing
        class notion_emoji
        {
            [string] $emoji
            notion_emoji()
            {
            }
            notion_emoji([string] $emoji)
            {
                $this.emoji = $emoji 
            }
        }
    }

    Context "When called with no parameters" {
        It "Returns a notion_emoji object with no emoji set" {
            $result = New-NotionEmoji
            $result | Should -BeOfType "notion_emoji"
            $result.emoji | Should -BeNullOrEmpty
        }
    }

    Context "When called with an emoji parameter" {
        It "Returns a notion_emoji object with the specified emoji" {
            $emojiChar = "😀"
            $result = New-NotionEmoji $emojiChar
            $result | Should -BeOfType "notion_emoji"
            $result.emoji | Should -Be $emojiChar
        }
    }
}
