# FILE: Custom_Emoji.Tests.ps1
Import-Module Pester -DisableNameChecking

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

Describe "notion_custom_emoji class" {
    It "Should create an instance with default constructor" {
        $notionEmoji = [notion_custom_emoji]::new()
        $notionEmoji.type         | Should -Be "custom_emoji"
        $notionEmoji.custom_emoji | Should -Be $null
    }

    It "Should create an instance with custom_emoji_structure" {
        $notionEmoji = [notion_custom_emoji]::new("789", "laugh", "https://example.com/laugh.png")
        $notionEmoji.custom_emoji.getType().Name | Should -Be "custom_emoji_structure"
        $notionEmoji.custom_emoji.id   | Should -Be "789"
        $notionEmoji.custom_emoji.name | Should -Be "laugh"
        $notionEmoji.custom_emoji.url  | Should -Be "https://example.com/laugh.png"
    }

    It "Should convert from object" {
        $obj = [PSCustomObject]@{
            custom_emoji = [PSCustomObject]@{
                id   = "101"
                name = "cool"
                url  = "https://example.com/cool.png"
            }
        }
        $notionEmoji = [notion_custom_emoji]::ConvertFromObject($obj)
        $notionEmoji.custom_emoji.id   | Should -Be "101"
        $notionEmoji.custom_emoji.name | Should -Be "cool"
        $notionEmoji.custom_emoji.url  | Should -Be "https://example.com/cool.png"
    }
}
